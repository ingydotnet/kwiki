package Kwiki::Theme::GreenHouse;
use strict;
use warnings;
use Kwiki::Theme '-Base';
use mixin 'Kwiki::Installer';
our $VERSION = '0.03';
const config_file => 'greenhouse.yaml';
const theme_id => 'greenhouse';
const class_title => 'The greenhouse theme';
1;

__DATA__

=head1 NAME 

Kwiki::Theme::GreenHouse - Green Kwiki Theme

=head1 SYNOPSIS

 $ cd /path/to/kwiki
 $ vim plugins # (Replace your current Kwiki::Theme::Xyz
               # with Kwiki::Theme::GreenHouse)
 $ kwiki -update

=head1 DESCRIPTION

Designed to make you feel like you're eating Lime Sherbet.  Mmmm.

=head2 Configuration

  None needed, currently.

=head1 AUTHOR

Ryan King <rking@panoptic.com>

=head1 COPYRIGHT

Copyright (c) 2005. Ryan King. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
__theme/greenhouse/template/tt2/kwiki_screen.html__
<!-- BEGIN kwiki_screen -->
[%- INCLUDE kwiki_doctype.html %]
<!-- BEGIN kwiki_screen.html -->
[% INCLUDE kwiki_begin.html %]

<div id="container">

<div id="widgets_pane">
[% hub.widgets.html %]
</div>

<script type="text/javascript">
var bgoffset = Math.round(Math.random()*10)
document.writeln("<div id='title_pane' style='background-position: " + bgoffset + "0% " + bgoffset + "0%'>")
</script>
[% screen_title || self.class_title %]
</div>

<div id="toolbar_pane">
[% hub.toolbar.html %]
[% IF hub.have_plugin('user_name') %]
[% INCLUDE user_name_title.html %]
[% END %]
</div>

<div id="status_pane">
[% hub.status.html %]
</div>

<hr />

<div id="content_pane">
[% INCLUDE $content_pane %]
</div>

<hr />

<div id="toolbar_pane_2">
[% hub.toolbar.html %]
</div>

[% INCLUDE kwiki_end.html %]
</div><!-- container -->
<div id="right_pane">
</div>
<!-- END kwiki_screen -->
__theme/greenhouse/template/tt2/theme_screen.html__

[%- INCLUDE kwiki_screen.html -%]

__theme/greenhouse/css/kwiki.css__
#title_pane, h1, h2, h3, h4, h5, h6 {
    color: white;
    background: rgb(127,196,36) url('/theme/greenhouse/images/bg.png');
    border: thin solid rgb(50,150,50);
    margin: 0px;
    padding: 2px;
}
#title_pane {
    font-weight: bold;
    font-size: x-large;
    /* offset it a little so it's not so obviously the same exact image: */
    background-position: 30%30%; 
    color: white;
}
#title_pane a { color: white; }
#toolbar_pane {
    margin: 2px;
}
#container {
    position: absolute;
    min-height:100%;
    border-left: 14px solid rgb(235,255,225);
    border-right: 14px solid rgb(235,255,225);
    padding: 2px;
    background: white;
}

.navLink:after { content: " | "; }

a         { text-decoration: none }
a:link    { color: rgb(92,171,109) }
a:visited { color: rgb(14,52,20) }
a:hover   { text-decoration: underline }
a:active  { text-decoration: underline }
a.empty   { color: gray }
a.private { color: black }

body {
    background: rgb(200,200,200);
    font-family: sans-serif;
    font-size: 12px;
    color: rgb(46,90,65);
    margin: 0px;
    padding: 0px;
}


hr {
    border: 0px;
    padding: 0px;
    margin-bottom: 10px;
    clear: both;
    height: 1px;
    background-color: white;
    border-bottom: 1px solid rgb(127,196,36);
}

.error    {color: red;}

ul { list-style-type: circle }

pre {
    background-color: white;
    color: black;
    border: none;
}

input[type=text] {
    height: 14px;
    font-family: sans-serif;
    font-size: 11px;
    color: rgb(127,196,36);
    border: 1px solid rgb(127,196,36);
    padding: 2px;
}

input[type=submit] {
    background-color: rgb(92,171,109);
    color: white;
    font-weight: bold;
    //border: thin solid black;
}


form.edit input { position: absolute; left: 3% }
__theme/greenhouse/images/bg.png__
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
/z+0mA/N1vmrlwAAAABJRU5ErkJggg==
