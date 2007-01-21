package Kwiki::Display;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const config_file => 'display.yaml';
const class_id => 'display';
const class_title => 'Page Display';
const css_file => 'display_changed_by.css';

sub init {
    $self->hub->css->add_file($self->css_file);
}

sub register {
    my $registry = shift;
    $registry->add(action => 'display');
    $registry->add(action => 'display_html');
    $registry->add(toolbar => 'home_button', 
                   template => 'home_button.html',
                  );
    $registry->add(preference => $self->display_changed_by);
}

sub display_changed_by {
    my $p = $self->new_preference('display_changed_by');
    $p->query('Show a "Changed by ..." section on each page?');
    $p->default(0);
    return $p;
}

sub display_html {
    $self->pages->current->to_html;
}

sub display {
    my $page = $self->pages->current;
    return $self->redirect('')
      unless $page;
    my $page_title = $page->title;
    my $page_uri = $page->uri;
    return $self->redirect("action=edit;page_name=$page_uri")
      if not($page->exists) and $self->have_plugin('edit');
    my $script = $self->config->script_name;
    my $screen_title = $self->hub->have_plugin('search')
    ? "<a href=\"$script?action=search;search_term=$page_uri\">$page_title</a>"
    : $page_title;
    eval {
        $page->content;
    };
    if ($@) {
        my $main_page = $self->config->main_page;
        die $@ if $page->title eq $main_page;
        return $self->redirect($main_page);
    }
    $self->render_screen(
        screen_title => $screen_title,
        page_html => $page->to_html,
    );
}

__DATA__

=head1 NAME 

Kwiki::Display - Kwiki Page Display Plugin

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

Copyright (c) 2004. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
__template/tt2/home_button.html__
<a href="[% script_name %]?" accesskey="h" title="Home Page">
[% INCLUDE home_button_icon.html %]
</a>
__template/tt2/home_button_icon.html__
Home
__template/tt2/display_content.html__
<div class="wiki">
[% page_html -%]
</div>
[% INCLUDE display_changed_by.html %]
__template/tt2/display_changed_by.html__
[% IF self.preferences.display_changed_by.value %]
[% page = hub.pages.current %]
<div id="changedby">
Last changed by [% page.edit_by_link %] at [% page.edit_time %].
</div>
[% END %]
__css/display_changed_by.css__
div#changedby {
  background-color: #eee;
  padding: 2px;
  padding-left: 4px;
  text-style: italic;
}

