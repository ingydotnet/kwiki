package Kwiki::Theme;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const class_id => 'theme';
const theme_id => '__theme__';

sub register {
    my $register = shift;
    $register->add(preload => 'theme',
                   priority => 1,
                  );
    $register->add(prerequisite => 'toolbar');
    $register->add(prerequisite => 'widgets');
    $register->add(prerequisite => 'status');
}

const default_template_path => "theme/%s/template/tt2";
const default_css_path => "theme/%s/css";
const default_javascript_path => "theme/%s/javascript";

const default_css_file => 'kwiki.css';
const default_javascript_file => '';

sub init {
    $self->SUPER::init(@_);

    my $paths = $self->hub->paths;
    
    my $theme_id = $self->theme_id;
    my $template_path = 
      sprintf $self->default_template_path, $theme_id;
    $paths->add_path(template => $paths->all_ending($template_path));

    my $css_path = 
      sprintf $self->default_css_path, $theme_id;
    $paths->add_path(css => $paths->all_ending($css_path));
    $self->hub->css->add_file
      (ref $self->default_css_file
          ? @{$self->default_css_file}
          : $self->default_css_file);

    my $javascript_path = 
      sprintf $self->default_javascript_path, $theme_id;
    $paths->add_path(javascript => $paths->all_ending($javascript_path));
    $self->hub->javascript->add_file
      (ref $self->default_javascript_file
          ? @{$self->default_javascript_file}
          : $self->default_javascript_file);

    $self->hub->cookie; 
}

sub resolve_install_path {
    sprintf shift, $self->theme_id;
}

__DATA__


__css/icons.css__
div.toolbar img {
    margin: 0;
    padding: 0;
    border: 0;
    vertical-align: middle;
}
__template/tt2/kwiki_doctype.html__

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml11.dtd">

__template/tt2/kwiki_begin.html__

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>
[% IF hub.action == 'display' || 
      hub.action == 'edit' || 
      hub.action == 'revisions' 
%]
  [% hub.cgi.page_name %] -
[% END %]
[% IF hub.action != 'display' %]
  [% self.class_title %] - 
[% END %]
  [% site_title %]</title>
[%# FOR link = hub.links.all -%]
<!-- XXX Kwiki::Atom might need this, but it breaks Hub::AUTOLOAD
  <link rel="[% link.rel %]" type="[% link.type %]" href="[% link.href %]" />
-->
[%# END %]
[% IF favicon != '' %]
   <link rel="shortcut icon" href="[% favicon %]"/>
[% END %]
[% FOR css_file = hub.css.files -%]
  [% IF css_file -%]
    <link rel="stylesheet" type="text/css" href="[% css_file %]" />
  [% END -%]
[% END -%]
[% FOR javascript_file = hub.javascript.files -%]
  [% IF javascript_file -%]
    <script type="text/javascript" src="[% javascript_file %]"></script>
  [% END -%]
[% END -%]
  <link rel="start" href="[% script_name %]" title="Home" />
</head>
[% INCLUDE body_tag.html %]
__template/tt2/body_tag.html__
<body>
__template/tt2/kwiki_end.html__
</body>
</html>

__theme/%s/template/tt2/theme_screen.html__

[%- INCLUDE kwiki_screen.html -%]

__theme/%s/template/tt2/theme_html_doctype.html__

[%- INCLUDE kwiki_doctype.html %]
__theme/%s/template/tt2/theme_html_begin.html__

[%- INCLUDE kwiki_begin.html %]
__theme/%s/template/tt2/theme_html_end.html__
[% INCLUDE kwiki_end.html -%]

__theme/%s/template/tt2/theme_logo_pane.html__
<div id="logo_pane">
<img src="[% logo_image %]" align="center" alt="Kwiki Logo" title="[% site_title %]" />
</div>
__theme/%s/template/tt2/theme_title_pane.html__
<div id="title_pane">
<h1>
[% screen_title || self.class_title %]
</h1>
</div>
__theme/%s/template/tt2/theme_toolbar_pane.html__
<div id="toolbar_pane">
[% hub.toolbar.html %]
[% INCLUDE theme_login_pane.html %]
</div>
__theme/%s/template/tt2/theme_login_pane.html__
[% IF hub.have_plugin('user_name') %]
[% INCLUDE user_name_title.html %]
[% END %]
__theme/%s/template/tt2/theme_status_pane.html__
<div id="status_pane">
[% hub.status.html %]
</div>
__theme/%s/template/tt2/theme_widgets_pane.html__
<div id="widgets_pane">
[% hub.widgets.html %]
</div>
__theme/%s/template/tt2/theme_content_pane.html__
<div id="content_pane">
[% INCLUDE $content_pane %]
</div>
__theme/%s/template/tt2/theme_toolbar2_pane.html__
<div id="toolbar2_pane">
[% hub.toolbar.html %]
</div>
