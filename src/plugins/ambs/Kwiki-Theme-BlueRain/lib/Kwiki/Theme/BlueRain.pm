package Kwiki::Theme::BlueRain;
use Kwiki::Theme -Base;
our $VERSION = '0.01';

const theme_id => 'bluerain';
const class_title => 'Blue Rain Theme';

__DATA__

__theme/bluerain/css/header_bg.png__
iVBORw0KGgoAAAANSUhEUgAAAAEAAABsCAMAAACcoSg/AAAABGdBTUEAAK/INwWK6QAAABl0RVh0
U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAEXUExURUB70ixVjjtxwDJgoUB60EN/2j10
xkJ+1y5ZlSxVjT94zSxWj0J+2EF81C1XkTNipjRlqjpwvjxzwzxywi5Yk0J/2TZosC5aljtywS9c
mi1Ykj53yj52yj52yTFenTltuC1XkDhstzBcmkF91UJ91j95zi1XkkF91j11yEF70zx0xThrtjlu
ujNipTZnrzRkqStVjDBdnC9bmTVmrTRkqDhrtTVmrDNjpztwvz11xytUjC9alzpvvTVnrjdqszhs
uDFfnzdqtDRjpzZor0N/2TxzxEF81TJhoi9blzdpsjltuTFenjJho0B60T53yyxWkC5ZlDVlqz95
zzpvvDNhpDBdmy1YkzFfoDdpsTBdnTluuz53zC9bmBhZsZMAAACUSURBVHjaFMGHIgIAFADAQ2Ul
O7Oy9x4ZIdkz2Yn//46eO8e2dMaW2B1fTMnEBeO+DKnpiCNK7vzZMWbGp20/8h6d+9YWbz35sK7X
gQt7NvV5VbTr1IZLWXX3zlTsWzWtrODBmoZ3J/odao2jBg24tiIVjyzJmTSh6ldXnPcmEZ/9W9YT
b8xaNKc9puOwK0nJpgADAKcKESASzMvVAAAAAElFTkSuQmCC
__theme/bluerain/template/tt2/kwiki_screen.html__
[%- INCLUDE kwiki_doctype.html %]
[% INCLUDE kwiki_begin.html %]

 <div id="main">
  <div id="header">
   <h1>[% screen_title || self.class_title %]</h1>
  </div>
  <div id="menu">[% hub.toolbar.html %]</div>
  <div id="content">
   <div class="article">
    [% INCLUDE $content_pane %]
   </div>
  </div>
  <div id="panel">
   <div class="left">
    <div id="widgets_pane">[% hub.widgets.html %]</div>
   </div>
   <div class="right">
    [% IF hub.have_plugin('user_name') %][% INCLUDE user_name_title.html %][% END %]
    <div id="status_pane"> [% hub.status.html %] </div>
   </div>
  </div>
 <div id="footer"><p>Designed by <a href="http://www.pixelcarnage.com/">PixelCarnage</a>.</p></div>

[% INCLUDE kwiki_end.html -%]

__theme/bluerain/css/kwiki.css__
* {
	margin : 0;
	padding : 0;
}

a {
	color : #437fda;
	text-decoration : none;
}
a:visited {
	color : #437fda;
	text-decoration : underline;
}
a:hover {
	color : #ba8f43;
}

h2 {
	color : #343434;
        margin-top: 5px;
	font : italic 200% sans-serif;
}
h3 {
	color : #343434;
	font : italic 160% sans-serif;
}
h4 {
	color : #343434;
	font : bold italic 120% sans-serif;
	padding : 1em 1em 0 1em;
}

html {
	color : #565656;
	font : 70%/170% sans-serif;
	text-align : justify;
}

img {
	margin : 1em 1em 0 1em;
}
img.left {
	float : left;
	margin : 1em 1em 0 0;
}
img.right {
	float : right;
	margin : 1em 0 0 1em;
}

blockquote {
	font-style : italic;
	margin : 1em 1em 0 1em;
	padding : 0 0 1em 0;
}
blockquote span {
	font-size : 200%;
	line-height : 1%;
	margin : 0 0.15em;
	position : relative;
	top : 0.25em;
}

form textarea {
	border : solid 1px #dfdfdf;
	width : 100%;
	height : 20em;
}

p {
	padding : 1em 1em 0 1em;
}

ul,
ol {
	padding : 1em 1em 0 3em;
}

#main {
	margin : auto;
	max-width : 75em;
	min-width : 40em;
	width : auto !important;
	width : 75em;
}

#header {
	background : #2b548c url('header_bg.png') repeat-x bottom left;
	padding : 6em 4em 1em 4em;
}
#header h1 {
	color : #ffffff;
	font : italic 200% sans-serif;
}

#menu {
	background : #437fda;
	border-bottom : 1px solid #2b548c;
	font : 100% sans-serif;
}
#menu div {
	padding : 0.75em 4em;
}
#menu span {
	display : inline;
}
#menu span a {
	color : #ffffff;
	padding : 0.75em 1.5em;
}
#menu span a:hover {
	background : #2b548c;
}
#menu span.selected a {
	background : #ffffff;
	border : 1px solid #2b548c;
	border-bottom : 1px solid #ffffff;
	color : #437fda;
}
#menu span.selected a:hover {
	background : #ffffff;
	color : #ba8f43;
}

#content {
	border-bottom : 1px solid #cfcfcf;
	height : auto !important;
	height : 1%;
	overflow : hidden;
	padding : 2em 0 0 0;
        font : 120% sans-serif;
}
#content div {
	padding : 0 4em 2em 4em;
}

#panel {
	background : #efefef;
	border : 1px solid #dfdfdf;
	border-bottom : 1px solid #cfcfcf;
	border-top : none;
	height : auto !important;
	height : 1%;
	overflow : hidden;
	padding : 0 5em 2em 5em;
}
#panel div {
	padding : 2em 0 0 0;
}
div.left {
	left : -1em;
	float : left;
	position : relative;
	width : 50%;
}
div.right {
	left : 1em;
	float : left;
	position : relative;
	width : 50%;
}

#footer {
	font-size : 85%;
	margin : auto;
	padding : 1em 0 3em 0;
	text-align : center;
	width : 65%;
}

span.toolbar_button {
        margin: 0px;
        padding: 0px;
}

div.toolbar {
        margin: 0px;
        padding: 0px;
}

div#user_name_title {
        float: none;
        margin: 0px;
}
