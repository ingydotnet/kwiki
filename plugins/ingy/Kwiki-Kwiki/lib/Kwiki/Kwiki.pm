package Kwiki::Kwiki;

use 5.008004;

our $VERSION = '0.10';
use File::Path qw(mkpath rmtree);;
use Cwd qw(cwd abs_path);

sub make_src {
    my $class = shift;
    my $list = read_list();
    my $svn_list = $list->{svn}{list};
    for my $url (@$svn_list) {
        $url =~ s/\/$//;
        my ($dir) = ($url =~ /^.*\/(.*)/);
        my $path = "kwiki/src/svn/$dir";
        if (-e $path) {
            if (not(-e "$path/.svn" and
                    `svn info $path` =~ /^URL: \Q$url\E$/m)) {
                warn "Deleting out of date path: $path\n";
                rmtree $path;
            }
        }
        if (-e $path) {
            system_command("svn up $path");
        }
        else {
            system_command("svn co $url $path");
        }
    }
}

sub make_lib {
    my $class = shift;
    my $list = read_list();
    my $svn_list = $list->{svn}{list};

    my $top = cwd();
    chdir('kwiki') or die "Could not chdir to the 'kwiki' directory";
    
    my @sources;
    for my $url (@$svn_list) {
        $url =~ s/\/$//;
        my ($dir) = ($url =~ /^.*\/(.*)/);
        my $path = "src/svn/$dir";
        push @sources, $path;
    }
    
    my %path_map;

    my $home = cwd();
    for my $dir (@sources) {
        next unless -d $dir and -r $dir;
        chdir $dir or die "Couldn't chdir to $dir";
        # XXX Refactor UNIX commands into Perl
        for my $path (`find lib -type f | grep '\\.pm\$'`) {
            chomp $path;
            $path_map{$path} =
                join('/', ('..') x ((split '/', $path) - 1)) .  "/$dir/$path";
        }
        chdir $home or die "Couldn't chdir back to $home";
    }

#     use YAML; die Dump \%path_map;

    for my $src_path (keys %path_map) {
        my $target_path = $path_map{$src_path};
        my ($rel_dir) = ($src_path =~ /(.*)\/\w+\.pm$/)
          or die "Can't find directory component for $src_path";
        mkpath($rel_dir) unless -e $rel_dir;
        unlink $src_path if -l $src_path;
        symlink($target_path, $src_path)
          or die "Can't create symlink from $src_path to $target_path\n";
    }
    chdir $top or die "Couldn't chdir back to $top";
}

sub read_list {
    open LIST, "kwiki/sources/list"
      or die "Can't open kwiki/sources/list for input";
    my @lines = <LIST>;
    close LIST;
    my $list = {};
    my $type = undef;
    my $line = 0;
    for (@lines) {
        $line++;
        next if /^(#|\s*$)/;
        if (/===\s+(\w+)/) {
            $type = $1;
            next;
        }
        die "Invalid list format. No type line. (at line $line)\n"
          unless $type;
        die "Invlaid list format. Invalid list line (at line $line)\n"
          unless /^---\s+(.*?)\s*$/; 
        my $list = $list->{$type}{list} ||= [];
        push @$list, $1;
    } 
    return $list;
}

sub delete_distribution_files {
    rmtree('Changes');
    rmtree('Makefile.PL');
    rmtree('lib');
    rmtree('t');
}

sub system_command {
    my $command = shift;
    warn "> $command\n";
    system($command) == 0
      or die "Command failed\n";
}

__END__

=head1 NAME

Kwiki-Kwiki - Kwiki Kwiki is a Wiki

=head1 SYNOPSIS

    > tar xzf Kwiki-Kwiki-#.##-tar.gz
    > mv Kwiki-Kwiki-#.##-tar.gz path/to/cgi-bin/mykwiki
    > cd path/to/cgi-bin/mykwiki
    > bin/kwiki-kwiki

or better yet:

    > cd path/to/cgi-bin
    > svn co http://svn.kwiki.org/ingy/Kwiki-Kwiki mykwiki
    > cd mykwiki
    > bin/kwiki-kwiki

=head1 DESCRIPTION

Kwiki-Kwiki is a Wiki. It's the best way to install/run/maintain a site
using the popular Kwiki wiki framework modules.

Most folks think that Kwiki is wiki software, and in a sense it is. But
the main purpose of Kwiki is to be a framework for creating wiki
software. In other words, it's a Perl hacker's playground. Most of the
energy was put into figuring out how plugins from various folks could
play well together, and less thought was put into how to simply run a
wiki with the features you'd expect.

This is where Kwiki-Kwiki comes in. Kwiki-Kwiki ties all the useful
plugins that the friendly hackers have been creating for you, into a
nice, easy to install and upgrade package.

=head1 SYSTEM REQUIREMENTS

=over

=item Perl 5.8.4 or higher

Kwiki uses unicode, and unicode didn't really stabilize until Perl
5.8.4. If you try to run Kwiki on older perls, you will likely run into
problems. So Kwiki-Kwiki requires 5.8.4 or higher.

However, you'll be happy to know that Kwiki-Kwiki doesn't require any Perl
modules to be installed (except the ones that come with Perl). Kwiki-Kwiki
gets all these modules and installs them itself.

=item Subversion 1.0 or higher

Depending on how you configure Kwiki-Kwiki, you may need subversion. You
really want subversion. It makes life so much simpler. If you really
can't get it on your machine, that's ok.

=item A Web Server

Most people use the apache web server. Kwiki also provides a standalone web
server written in Perl.

=back

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
