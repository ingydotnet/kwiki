package Kwiki::Theme::YAPCChicago;
use Kwiki::Theme -Base;
use Kwiki::Toolbar::List;
our $VERSION = '0.11';
use 5.006001;

const theme_id => 'yapc_chicago';
const class_title => 'YAPC Chicago 2006 Theme';

sub register {
    super;
    my $registry = shift;
    $registry->add(hook => 'toolbar:html', post => 'fix_html');
}

sub fix_html {
    my $hook = pop;
    my $html = $hook->returned;
    $html =~ s!<ul id="nav">!<ul class="primary">!;
    $html =~ s#
        <li><!--\sBEGIN\srecent_changes_options\s-->\s*
        .*
        <!--\sEND\srecent_changes_options\s-->\s*
        </li>
    ##xs;
    return $html;
}

__DATA__


__theme/yapc_chicago/template/tt2/kwiki_screen.html__

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head profile="http://gmpg.org/xfn/11">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="generator" content="WordPress 1.5" /> <!-- leave this for stats -->
        <link rel="stylesheet" href="http://yapcchicago.org/wp-content/themes/yapc_wide/style.css" type="text/css" media="screen" />
        <link rel="shortcut icon" type="image/png" href="http://yapcchicago.org/wp-content/themes/yapc_wide/images/favicon.png" />

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
</head>
<body>
<!-- END kwiki_begin -->
<img id="logo_left" src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/logo_left.jpg" alt="YAPC::NA 2006" />
<img id="logo_right" src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/logo_right.jpg" alt="YAPC::NA 2006" />
<div id="nav">
[% hub.toolbar.html %]
[%# IF hub.have_plugin('user_name') %]
[%# INCLUDE user_name_title.html %]
[%# END %]
</div>


	<div id="content">
[% INCLUDE $content_pane %]
	</div>
	
	<div id="left_sidebar">

		<p><a href="http://www.valueclick.com"><img src="http://www.yapcchicago.org/media/sponsors/valueclick/web.jpg" alt="ValueClick" border="0" /></a></p>
		<p><a href="http://www.livetext.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/livetext.jpg" alt="LiveText" border="0" /></a></p>
		<p><a href="http://www.bignerdranch.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/bnr.gif" alt="Big Nerd Ranch" border="0" /></a></p>
		<p><a href="http://www.google.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/google.gif" alt="Google" border="0" /></a></p>
		<p><a href="http://www.itasoftware.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/ita_software.gif" alt="ITA Software" border="0" /></a></p>
		<br/><p><a href="http://www.performics.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/performics.jpg" alt="Performics" border="0" /></a></p>
		<br/><p><a href="http://www.stonehenge.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/stonehenge.gif" alt="Stonehenge"  border="0"/></a></p>
		<br/><p><a href="http://damian.conway.org"><img src="http://www.yapcchicago.org/media/sponsors/thoughtstream/web.jpg" alt="Thoughtstream"  border="0"/></a></p>
		<p><a href="http://www.sxip.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/sxip.gif" alt="Sxip" border="0" /></a></p>
		<br/><p><a href="http://www.openmake.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/om.gif" alt="Open Make" border="0" /></a></p>
		<br/><p><a href="http://www.shopzilla.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/shopzilla.gif" alt="Shopzilla" border="0" /></a></p>
		<br/><p><a href="http://www.oreilly.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/oreilly.gif" alt="O'Reilly" border="0" /></a></p>
		<!--<br/><p><a href="http://www.socialtext.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/socialtext.gif" alt="Social Text" border="0" /></a></p>-->
		<br/><p><a href="http://www.apress.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/apress.gif" alt="Apress"  border="0"/></a></p>
		<br/><p><a href="http://www.grantstreetgroup.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/grant.gif" alt="Grant Street Group"  border="0"/></a></p>
		<br/><p><a href="http://www.acxiom.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/acxiom.gif" alt="Acxiom"  border="0"/></a></p>
		<br/><p><a href="http://www.zoomshare.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/zoomshare.gif" alt="Zoomshare"  border="0"/></a></p>
		<br/><p><a href="http://www.cheetahmail.com"><img src="http://yapcchicago.org/media/sponsors/cheetahmail/web.png" alt="CheetahMail"  border="0"/></a></p>
		<br/><p><a href="http://www.flr.follett.com"><img src="http://www.yapcchicago.org/media/sponsors/follett/web.gif" alt="Follett Library Resources"  border="0"/></a></p>
		<br/><p><a href="http://www.manning.com"><img src="http://www.yapcchicago.org/media/sponsors/manning/web.gif" alt="Manning"  border="0"/></a></p>
		<br/><p><a href="http://www.nostarch.com/"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/nsp.gif" alt="No Starch Press"  border="0"/></a></p>
		<br/><p><a href="http://www.pragmaticprogrammer.com/"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/pragmatic.png" alt="Pragmatic Programmers"  border="0"/></a></p>
		<br/><p><a href="http://www.allantgroup.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/allant.jpg" alt="Allant"  border="0"/></a></p>
		<br/><p><a href="http://www.rimmkaufman.com"><img src="http://www.yapcchicago.org/media/sponsors/rimmkaufman/web.jpg" alt="Rimm Kaufman"  border="0"/></a></p>
		<br/><p><a href="http://www.combinenet.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/combinenet.jpg" alt="CombineNet"  border="0"/></a></p>
		<br/><p><a href="http://www.plainblack.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/plainblack.png" alt="PlainBlack"  border="0"/></a></p>
		<br/><p><a href="http://www.activestate.com"><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/active_state.gif" alt="ActiveState"  border="0"/></a></p>

		<br/>

			<p>Promote YAPC::NA on your site!</p>
		                	<p><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/yapcna_blue_gold.gif"  border="0" alt="YAPC::NA Badge"/></p>
			                	<p><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/yapcna_purple_grey.gif"  border="0" alt="YAPC::NA Badge"/></p>
			                	<p><img src="http://yapcchicago.org/wp-content/themes/yapc_wide/images/yapcna_purple_white.gif"  border="0" alt="YAPC::NA Badge"/></p>
			
		<p><a href="http://yapcchicago.org/yapc_poster.pdf">Poster</a></p>

	</div>

	<div id="right_sidebar">
[% hub.widgets.html %]
	</div>

</body>
</html>

__theme/yapc_chicago/css/kwiki.css__
#content {
    font-size: 160%;
}

form.edit input { position: absolute; left: 3% }
textarea { width: auto }

a         {text-decoration: none}
a:hover   {text-decoration: underline}
a:active  {text-decoration: underline}
a.empty   {color: gray}
a.private {color: black}

.error    {color: #f00;}

div.side a { display: list-item; list-style-type: none }
div.upper-nav { }
textarea { width: 100% }
div.navigation a:visited {
    color: #d64;
}
