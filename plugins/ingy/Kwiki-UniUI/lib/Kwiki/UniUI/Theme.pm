package Kwiki::UniUI::Theme;
use Kwiki::Theme -Base;

const theme_id => 'uniui';

sub init {
    super;
    my $path = $self->resolve_install_path($self->default_template_path);
    $self->hub->template->add_path($path);
}

sub register {
    my $register = shift;
    $register->add(preload => 'theme',
                   priority => 1,
                  );
    $register->add(prerequisite => 'toolbar');
#     $register->add(prerequisite => 'widgets');
#     $register->add(prerequisite => 'status');
}

__DATA__

__theme/uniui/template/tt2/home_button.html__
<a href="" onclick="uniui_home_page(); return false" accesskey="c" title="Home Page">
[% INCLUDE home_button_icon.html %]
</a>
__theme/uniui/template/tt2/recent_changes_button.html__
<a href="" onclick="uniui_recent_changes(); return false" accesskey="c" title="Recent Changes">
[% INCLUDE recent_changes_button_icon.html %]
</a>
__template/tt2/search_box.html__
<form id="search_form" method="post" action="javascript:uniui_search()" enctype="application/x-www-form-urlencoded" style="display: inline">
<input type="text" name="search_term" size="8" value="Search" onfocus="this.value=''" />
<input type="hidden" name="action" value="search" />
</form>
__theme/uniui/template/tt2/theme_title_pane.html__
<div id="title_pane" style="xxx-position: fixed">
<h1 id="site_title">
[% site_title %]
</h1>
[% INCLUDE theme_toolbar_pane.html %]
</div>
__theme/uniui/template/tt2/theme_screen.html__
[%- INCLUDE theme_html_doctype.html %]
[% INCLUDE theme_html_begin.html %]
<table id="group"><tr>
<td id="group_1">
<div class="navigation">
[% INCLUDE theme_title_pane.html %]
[% INCLUDE theme_status_pane.html %]
</div>

<hr />
[% INCLUDE theme_content_pane.html %]
<hr />

<div class="navigation">
[%# INCLUDE theme_toolbar2_pane.html %]
</div>
</td>

<td id="group_2">
<div class="navigation">
[% INCLUDE theme_logo_pane.html %]
<br/>
[% INCLUDE theme_widgets_pane.html %]
</div>

</td>
</tr></table>
[% INCLUDE theme_html_end.html -%]
__theme/uniui/css/kwiki.css__
#logo_pane
{
position: fixed;
top: 10px;
left: 0px;
width: 120px;
}

#title_pane
{
position: fixed;
height: 80px;
padding-top: 10px;
top: 0px;
left: 120px;
border-bottom: 2px dotted grey;
width: 85%;
background: white;
z-index: 300;
}

#title_pane .toolbar
{
border: 1px solid white;
}

h1#site_title 
{
color: green;
text-align: center;
margin: 5px;
}

#content_pane
{
position: absolute;
width: 80%;
top: 100px;
left: 120px;
}

hr { display: none;}
