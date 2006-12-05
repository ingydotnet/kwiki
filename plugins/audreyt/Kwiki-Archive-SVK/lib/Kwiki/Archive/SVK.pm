package Kwiki::Archive::SVK;
use strict;
use warnings;
use SVK;
use SVK::XD;
use SVN::Repos;
use File::Glob;
use Time::Local;
use Kwiki::Archive '-Base';
our $VERSION = '0.06';

sub register {
    super;
    my $registry = shift;
    $registry->add(page_hook_content => 'page_content');
    $registry->add(page_hook_metadata => 'page_metadata');
    $registry->add(attachments_hook_list => 'attachments_list');
    $registry->add(attachments_hook_upload => 'attachments_upload');
    $registry->add(attachments_hook_delete => 'attachments_delete');
}

sub generate {
    super;

    my $rcs_dump = $self->export_rcs;
    rename($self->plugin_directory => $self->plugin_directory.'.rcs-old')
        or die "Cannot rename '".$self->plugin_directory."': $!";

    SVN::Repos::create(
        $self->plugin_directory, undef, undef, undef, {
            ($SVN::Core::VERSION =~ /^1\.0/) ? (
                'bdb-txn-nosync' => '1',
                'bdb-log-autoremove' => '1',
            ) : (
                'fs-type' => 'fsfs',
            )
        }
    );

    $self->import_rcs($rcs_dump) if $rcs_dump;
}

sub import_rcs {
    my $rcs_dump = shift;
    my $page = $self->hub->pages->page_class->new;
    my $meta = $self->hub->pages->meta_class->new;

    foreach my $id (sort keys %$rcs_dump) {
        local $SIG{__WARN__} = sub { 1 };
        print STDERR "Storing $id";
        my $history = $rcs_dump->{$id};
        $page->id($id);
        $meta->id($id);
        foreach my $info (reverse @$history) {
            print STDERR ".";
            $page->content(delete $info->{content});
            $meta->from_hash($info);
            $page->metadata($meta);
            $page->store;
        }
        print STDERR "\n";
    }
}

sub export_rcs {
    my @files = File::Glob::bsd_glob(
        io->catfile($self->plugin_directory, '*,v')->absolute
    ) or return;

    require Kwiki::Archive::Rcs;
    my $rcs = Kwiki::Archive::Rcs->new;
    my $page = $self->hub->pages->page_class->new;

    return {
        map {
            print STDERR "Loading $_...\n";
            $page->id($_);
            my $history = $rcs->history($page);
            $_->{content} = $rcs->fetch($page, delete $_->{revision_id})
              foreach @$history;
            ($page->id => $history);
        } map {
            m{([^\\/]+),v$} ? $1 : ()
        } @files
    }
}

sub empty {
    not io->catfile($self->plugin_directory, 'format')->exists;
}

sub attachments_upload {
    my ($attachments, $page_id, $file, $message) = @_;

    my $co_file = io->catfile(
        $attachments->plugin_directory, $page_id, $file
    )->absolute;

    $self->svk(
        $attachments,
        mkdir   => [ -m => "", "//attachments/$page_id" ],
        add     => [ $co_file ],
        commit  => [ -m => "$message", $co_file ]
    );
}

sub attachments_list {
    my ($attachments, $page_id) = @_;

    my $out = $self->svk(
        $attachments,
        list => [ "//attachments/$page_id" ],
    );

    $self->svk(
        $attachments,
        map (
            (revert => [ 
                io->catfile(
                    $attachments->plugin_directory,
                    $page_id,
                    $_,
                )->absolute
            ]),
            split(/\n/, $out)
        ),
    );
}

sub attachments_delete {
    my ($attachments, $page_id, $file, $message) = @_;
    my $co_file = io->catfile(
        $attachments->plugin_directory, $page_id, $file
    )->absolute;

    $self->svk(
        $attachments,
        delete => [ $co_file ],
        commit => [ -m => "$message", $co_file ],
    );
}

sub page_content {
    my $page = shift;
    my $co_file = $page->io->absolute;

    my ($atime, $mtime) = ($co_file->stat)[8, 9];
    $self->svk( $page, up  => [ $co_file ] );
#    XXX - need better conflict resolution
#    $self->svk( $page, revert  => [ $co_file ] );
    utime($atime, $mtime, $co_file) 
      if $mtime and $atime;
}

sub page_metadata {
    my $page = shift;
    return;

    my $metadata = $page->{metadata};

    $metadata->from_hash($self->fetch_metadata($page));
    $metadata->store;
}

sub commit {
    my ($page, $message) = @_;
    my $co_file = $page->io->absolute;
    my $props = $self->page_properties($page);

    local $ENV{USER} = $props->{edit_by} || $self->user_name;
    $message = '' if not defined $message;

    # XXX - what about $props->{edit_time}?

    $self->svk(
        $page, 
        add     => [ $co_file ],
        commit  => [ -m => "$message", $co_file ],
    );
}

sub revision_numbers {
    my $page = shift;
    my $limit = shift;

    my $handle = $self->svk_handle($page);
    my $fs = ($handle->{xd}->find_repos('//', 1))[2]->fs;
    my $path = "/pages/".$page->id;

    my $pool = SVN::Pool->new_default;
    my $hist = $fs->revision_root($fs->youngest_rev)->node_history($path);
    my @rv;

    $limit = -1 if !$limit;
    while (($hist = $hist->prev(0)) and $limit--) {
        push @rv, ($hist->location)[1];
        $pool->clear;
    }

    return \@rv;
}

sub fetch_metadata {
    my ($page, $rev) = @_;
    my $co_file = $page->io->absolute;

    $self->svk(
        $page,
        log => [ ($rev ? ( -r => $rev ) : ( -l => 1 )), $co_file ]
    ) =~ /r(\d+): +(.*) \| (.+)\n\n([\d\D]+)\n/ or return {};

    return {
        revision_id     => $1,
        edit_by         => $2,
        message         => $4,
        $self->timestamp_props($3),
    };
}

sub timestamp_props {
    my $time = shift;

    $time =~ /(\d+)-(\d+)-(\d+)T(\d+):(\d+):(\d+)/ or return;
    my $gmtime = timegm($6, $5, $4, $3, $2-1, $1);

    return (
        edit_time       => scalar gmtime($gmtime),
        edit_unixtime   => $gmtime,
    );
}

sub history {
    my $page = shift;

    return [
        map $self->fetch_metadata($page, $_),
            @{$self->revision_numbers($page)}
    ];
}

sub fetch {
    my ($page, $revision_id) = @_;

    return $self->svk(
        $page,
        cat => [ -r => $revision_id, $page->io->absolute ],
    );
}

sub svk {
    my $obj = shift;

    local @ENV{qw(SVKMERGE SVKDIFF LC_CTYPE LC_ALL LANG LC_MESSAGES)};
    local *SVK::I18N::loc = *SVK::I18N::_default_gettext;

    my $svk = $self->svk_handle($obj);

    while (my $cmd = shift) {
        my $args = shift;
        $svk->$cmd(map "$_", @$args);
    }

    return unless defined wantarray;
    return $self->utf8_decode(${$svk->{output}});
}

sub svk_handle {
    my $obj = shift;
    return $obj->{svk_handle} if $obj->{svk_handle};

    my $co_obj = Data::Hierarchy->new;
    my $co_path = $self->plugin_directory;

    my $xd = SVK::XD->new(
        depotmap => { '' => $co_path },
        checkout => $co_obj,
        svkpath  => $co_path,
    );

    my $repos = ($xd->find_repos('//', 1))[2];
    my $svk = SVK->new(xd => $xd, output => \(my $output));

    my $subdir = $obj->class_id;
    $subdir =~ s/s?$/s/; # pluralize the directory name

    my $method = {
        pages => 'database_directory',
    }->{$subdir} || 'plugin_directory';

    $co_obj->store(
        io($obj->$method)->absolute,
        { depotpath => "//$subdir", revision => $repos->fs->youngest_rev },
    );

    # mkdir $subdir if not exists -- refactor back to SVK!
    my $fs = ($svk->{xd}->find_repos('//', 1))[2]->fs;
    my $root = $fs->revision_root($fs->youngest_rev);
    if ($root->check_path("/$subdir") == $SVN::Node::none) {
        $svk->mkdir( -m => '', "//$subdir");
    }

    $obj->{svk_handle} = $svk;
    return $svk;
}

1;

__DATA__

=head1 NAME 

Kwiki::Archive::SVK - Kwiki Page Archival Using SVK

=head1 VERSION

This document describes version 0.06 of Kwiki::Archive::SVK, released
September 20, 2004.

=head1 SYNOPSIS

    % cd /path/to/kwiki
    % kwiki -add Kwiki::Archive::SVK

=head1 DESCRIPTION

This modules provides revision archival for Kwiki, using the B<SVK>
module and the B<Subversion> file system.  It is recommended to use
svn version 1.1 or above, for better stability with its C<fsfs>
file system.

You may wish to install B<Kwiki::Revisions> and B<Kwiki::Diff>
modules, to show past revisions to users.

=head1 AUTHOR

Autrijus Tang <autrijus@autrijus.org>

=head1 COPYRIGHT

Copyright 2004.  Autrijus Tang.  All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
