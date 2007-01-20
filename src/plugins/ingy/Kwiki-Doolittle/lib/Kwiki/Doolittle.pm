package Kwiki::Doolittle;
use Kwiki::Plugin -Base;
use Kwiki ':char_classes';
use mixin 'Kwiki::Installer';

const class_id => 'doolittle';

sub register {
    my $registry = shift;
    $registry->add(action => 'doolittle_index');
    $registry->add(command => 'doolittle_build_index',
                   description => 'Rebuild document index',);
    $registry->add(hook => 'cgi:set_default_page_name',
                   pre => 'page_name_hook');
    $registry->add(hook => 'pages:all', post => 'pages_all');
    $registry->add(hook => 'page:load_content', post => 'load_content');
    $registry->add(hook => 'archive:fetch', post => 'archive_fetch');
    $registry->add(hook => 'archive:commit', pre => 'archive_pre_commit');
    $registry->add(hook => 'archive:commit', post => 'archive_post_commit');
    $registry->add(hook => 'page:store_content', pre => 'store_content');
    $registry->add(hook => 'hub:action', post => 'action');
}

sub action {
    my $hook = pop;
    ($self->cgi->action || $self->cgi->page_name)
    ? $hook->returned
    : 'doolittle_index';
}

sub doolittle_index {
    $self->template->process($self->screen_template,
        content_pane => 'doolittle_content.html');
}

sub pages_all {
    my $hook = pop;
    grep {
        -l "database/" . $_->id and $_->id ne '.index'
    } $hook->returned;
}

sub handle_doolittle_build_index {
    my $index = io->catfile($self->config->database_directory, ".index");
    for my $source_file ($index->chomp->getlines) {
        next if $source_file =~ /^(#|\s*$)/;
        next unless -f $source_file;
        unless ($self->extract_pod(io($source_file)->all)) {
            warn "No pod for $source_file\n";
            next;
        }
        my ($module) = $source_file =~ /.*\/lib\/(.*)$/;
        $module =~ s/\//-/g;
        $module =~ s/\.pm$//;
        my $link_file = $self->config->database_directory . "/$module";
        next if -e $link_file;
        symlink($source_file, $link_file)
          or die "Can't make symlink for $link_file\n:$!";
    }
}

sub page_name_hook {
    my $hook = pop;
    $hook->cancel;
    return shift || '';
}

sub extract_pod {
    my $content = shift;
    return $content;
    $content =~ /.*\n__DATA__\n(?:.*?\n)?(=\w+.*?)(?:\n=cut|\z)(?:.*)\z/s
      or return;
    return $1;
    
}

sub store_pod {
    die "FIXME";
    my ($content, $pod) = @_;
    $content =~
      s/(.*\n__DATA__\n(?:.*?\n)?)(=\w+.*?)((?:\n=cut|\z)(?:.*)\z)/$1$pod$3/s
        or die;
    return $content;
}

sub archive_pre_commit {
    my $page = shift;
    my $hook = pop;
    my $page_source = readlink($page->file_path)
      or die $!;
    $page->{page_source} = $page_source;
}

sub archive_post_commit {
    my $page = shift;
    my $hook = pop;
    my $link = $page->file_path;
    my $page_source = $page->{page_source};
    unlink $link
      or die $!;
    symlink($page_source, $link);
}

sub archive_fetch {
    my $hook = pop;
    my $content = $hook->returned;

    my $local = $self->hub->doolittle;
    my $pod = $local->extract_pod($content)
     or die;
    return $pod;
}

sub load_content {
    my $content = $self->content;
    my $page_name = $self->id;
    my $local = $self->hub->doolittle;

    my $pod = $local->extract_pod($content)
     or die $local->invalid_doolittle_page($page_name);
    $self->content($pod);
    return $self;
}

sub store_content {
    die "FIXME";
    my $hook = pop;
    $hook->cancel;
    my $local = $self->hub->doolittle;
    my $file = io($self->file_path)->utf8;
    my $old_content = $file->all;
    my $pod = $self->content;
    if ($pod) {
        $pod =~ s/\r//g;
        $pod =~ s/\n*\z/\n/;
    }
    my $content = $local->store_pod($old_content, $pod);
    unless ($self->force) {
        return if $file->exists and 
                  $content eq $old_content;
    }
    $file->print($content);
    return $self;
}

sub invalid_doolittle_page {
    my $name = shift;
    die "Invalid Doolittle source for page '$name'";
}

__DATA__

=head1 NAME

Kwiki::Doolittle - Hooks For the Doolittle Project

=head1 SYNOPSIS

 ?

=head1 DESCRIPTION

Doolittle is the Kwiki wiki that contains all of the documentation for the Kwiki core modules. By editing Doolittle, one edits the Kwiki documentation. In fact, right now I'm writing about Doolittle *within* Doolittle! (Makes my brain hurt.)

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

Copyright (c) 2005. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut

__template/tt2/doolittle_content.html__
<h1>Welcome to Doolittle</h1>
<ul>
[% FOR page = hub.pages.all %]
<li>[% page.kwiki_link %]</li>
[% END %]
</ul>

