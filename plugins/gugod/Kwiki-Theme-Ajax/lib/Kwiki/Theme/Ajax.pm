package Kwiki::Theme::Ajax;
use Kwiki::Theme -Base;
use UNIVERSAL qw(can);
const theme_id => 'ajax';
const class_title => 'Ajax Theme';

const cgi_class => 'Kwiki::Theme::Ajax::CGI';

sub init {
    super;
    $self->hub->javascript->add_file('JSAN.js');
    $self->hub->javascript->add_file('KwikiAjax.js');
}

sub register {
    super;
    my ($registry) = @_;
    $registry->add(action => 'ajax');
    $registry->add(hook => 'page:kwiki_link', pre => 'uri_hook');
    $registry->add(hook => 'edit:render_screen', pre => 'render_screen_hook');
}

sub ajax {
    my $operation = "ajax_" . $self->cgi->operation;
    if(can($self, $operation)) {
        return $self->$operation;
    }
    return $self->ajax_display_error;
}

sub ajax_display_content {
    my $page = $self->pages->current;
    eval {  $page->content; };
    if ($@) {
        return $self->ajax_display_error;
    }
    $page->to_html;
}

sub ajax_edit {
    $self->hub->edit->edit;
}

sub ajax_display_error {
    return "<span>Are you talking to me ?</span>";
}

sub uri_hook {
    my $hook = pop;
    $hook->cancel;

    my ($label) = @_;
    my $page_uri = $self->uri;
    $label = $self->title
      unless defined $label;
    my $script = $self->hub->config->script_name;
    my $class = $self->active
      ? '' : ' class="empty"';
    qq(<a href="javascript:kwiki.display('$page_uri')" $class>$label</a>);
}

sub render_screen_hook {
    my $hook = pop; $hook->cancel;
    $self->template_process($self->class_id . '_content.html', @_);
}

package Kwiki::Theme::Ajax::CGI;
use base 'Kwiki::CGI';

cgi 'operation';

package Kwiki::Theme::Ajax;
__DATA__

=head1 NAME

  Kwiki::Theme::Ajax - 

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 COPYRIGHT

Copyright 2005 by Kang-min Liu <gugod@gugod.org>.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

See <http://www.perl.com/perl/misc/Artistic.html>

=cut

__theme/ajax/css/kwiki.css__
#logo_pane
{
  width:100px;
  height:100px;
  float:left;
  }

hr { clear:both; }

#preview_pane
{
  background:lightyellow;
  border-bottom:1px solid #000;
  border-right:1px solid #000;
  border-top:1px solid #ccc;
  border-left:1px solid #ccc;
  padding:1em;
  display:none;
}
.spacer { clear:both; height:0; }

#header_pane {
  height:100px;
  width:100%;
  position:fixed;
  top:0;
  left:0;
  margin-bottom:12px;
  border-bottom:1px dotted #000;
  z-index:200;
  background:#fff;
}

#content_pane {
  position:absolute;
  top: 110px;
  left: 120px;
  padding: 0 0 0 12px;
  margin:0;
}

__theme/ajax/template/tt2/theme_toolbar_pane.html__
<div id="toolbar_pane">
<div class="toolbar">
<a href="javascript:kwiki.display('HomePage')" accesskey="h" title="Home Page">
Home
</a>
&nbsp;
<a href="javascript:kwiki.edit()" title="Edit This Page">
Edit
</a>
</div>
</div>
__theme/ajax/template/tt2/theme_screen.html__
[%- INCLUDE theme_html_doctype.html %]
[% INCLUDE theme_html_begin.html %]
<div class="navigation">
[% INCLUDE theme_logo_pane.html %]
[% INCLUDE theme_title_pane.html %]
[% INCLUDE theme_toolbar_pane.html %]
[% INCLUDE theme_status_pane.html %]
</div>

<hr />
[% INCLUDE theme_content_pane.html %]
<hr />

<div class="navigation">
[% INCLUDE theme_widgets_pane.html %]
</div>

[% INCLUDE theme_html_end.html -%]
__theme/ajax/template/tt2/theme_content_pane.html__
<div id="content_pane"></div>
__theme/ajax/template/tt2/theme_logo_pane.html__
<div id="logo_pane">
<img src="[% logo_image %]" alt="Kwiki Logo" title="[% site_title %]" />
</div>
__theme/ajax/template/tt2/theme_screen.html__
<!-- BEGIN theme_screen -->
[%- INCLUDE theme_html_doctype.html %]
[% INCLUDE theme_html_begin.html %]
<div id="header_pane" class="navigation">
[% INCLUDE theme_logo_pane.html %]
[% INCLUDE theme_title_pane.html %]
[% INCLUDE theme_toolbar_pane.html %]
[% INCLUDE theme_status_pane.html %]
<div class="spacer">&nbsp;</div>
</div>
[% INCLUDE theme_content_pane.html %]

<div  class="navigation">
[% INCLUDE theme_widgets_pane.html %]
</div>

[% INCLUDE theme_html_end.html -%]
<!-- END theme_screen -->

