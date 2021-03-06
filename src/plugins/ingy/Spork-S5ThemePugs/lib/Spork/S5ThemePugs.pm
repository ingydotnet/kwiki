package Spork::S5ThemePugs;
use Spork::S5Theme -Base;

our $VERSION = '0.10';

__DATA__

=head1 NAME

Spork::S5ThemePugs - Pugs Theme for Spork::S5

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Brian Ingerson <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut

__ui/framing.css__
/* The following styles size and place the slide components.
   Edit them if you want to change the overall slide layout.
   The commented lines can be uncommented (and modified, if necessary) 
    to help you with the rearrangement process. */

div#header, div#footer, div.slide {width: 100%; top: 0; left: 0;}
div#header {top: 0; height: 1em;}
div#footer {top: auto; bottom: 0; height: 2.5em}
div.slide {top: 0; width: 92%; padding: 3.5em 4% 4%;}
/*div#controls {left: 50%; top: 0; width: 50%; height: 100%;}
#footer>*/
div#controls {bottom: 0; top: auto; height: auto;}

div#controls form {position: absolute; bottom: 0; right: 0; width: 100%;
  margin: 0;}
div#currentSlide {position: absolute; left: -500px; bottom: 1em; width: 130px; z-index: 10;}
/*html>body 
#currentSlide {position: fixed;}*/

/*
div#header {background: #FCC;}
div#footer {background: #CCF;}
div#controls {background: #BBD;}
div#currentSlide {background: #FFC;}
*/
__ui/pretty.css__
/* Puppy Theme 2004 by Martin Hense ::: www.lounge7.de */

/* Following are the presentation styles -- edit away!
   Note that the 'body' font size may have to be changed if the resolution is
    different than expected. */

body {background: #fff url(pugpup.png) no-repeat; color: #222; font-size: 2em;}
:link, :visited {text-decoration: none;}
#controls :active {color: #88A !important;}
#controls :focus {outline: 1px dotted #227;}
h1, h2, h3, h4 {font-size: 100%; margin: 0; padding: 0; font-weight: inherit;}
ul, pre {margin: 0; line-height: 1em;}
html, body {margin: 0; padding: 0;}

blockquote, q {font-style: italic;}
blockquote {padding: 0 2em 0.5em; margin: 0 1.5em 0.5em; text-align: center; font-size: 1em;}
blockquote p {margin: 0;}
blockquote i {font-style: normal;}
blockquote b {display: block; margin-top: 0.5em; font-weight: normal; font-size: smaller; font-style: normal;}
blockquote b i {font-style: italic;}

kbd {font-weight: bold; font-size: 1em;}
sup {font-size: smaller; line-height: 1px;}

code {padding: 2px 0.25em; font-weight: bold; color: #533;}
code.bad, code del {color: red;}
code.old {color: silver;}
pre {padding: 0; margin: 0.25em 0 0.5em 0.5em; color: #533; font-size: 90%;}
pre code {display: block;}
ul {margin-right: 7%; margin-left: 50px; padding: 0; list-style: circle;}
li {margin-top: 0.75em; margin-right: 0;}
ul ul {line-height: 1;}
ul ul li {margin: .2em; font-size: 85%; list-style: disc;}
img.leader {display: block; margin: 0 auto;}

div#header, div#footer {background: transparent; color: #BA9384;
  font-family: Verdana, Helvetica, sans-serif;}
div#header {line-height: 1px;}
div#footer {font-size: 0.5em; font-weight: bold; padding: 1em 0;
border-top: 1px solid #999999; background: #FFF0CF;}
#footer h1, #footer h2 {display: block; padding: 0 1em;}
#footer h2 {font-style: italic;}

div.long {font-size: 0.75em;}

.slide {
font-family: georgia, times, 'Times New Roman', serif; background: transparent url(pugpupbig2.png) right no-repeat;
background-position: right;
}
.slide h1 {position: absolute; z-index: 1;
  margin: 0; padding: 0.3em 0 0 50px; white-space: nowrap;
  text-transform: capitalize;  
  top: 35px; left: 60px; color: #4A040A;
  font: 150%/1em georgia, times, 'Times New Roman', serif;
  background: transparent;}
.slide h3 {font-size: 130%;}
h1 abbr {font-variant: small-caps;}

div#controls {position: absolute; z-index: 1; left: 50%; top: 0;
  width: 50%; height: 100%;
  text-align: right;}
#footer>div#controls {position: fixed; bottom: 0; padding: 1em 0;
  top: auto; height: auto;}
div#controls form {position: absolute; bottom: 0; right: 0; width: 100%;
  margin: 0; padding: 0;}
div#controls a {font-size: 2em; padding: 0; margin: 0 0.5em; 
 background: transparent;  color: #BA9384; border: none;
  cursor: pointer;}
div#controls select {visibility: hidden; background: #DDD; color: #227;}
div#controls div:hover select {visibility: visible;}

#currentSlide {text-align: center; font-size: 0.5em;
color: #646587; font-family: Verdana, Helvetica, sans-serif; font-weight: bold;}

#slide0 {padding-top: 3.5em; font-size: 90%;}
#slide0 h1 {position: static; margin: 1em 0 1.33em; padding: 0;
   white-space: normal;
   color: #000; background: transparent;
	font: 2em georgia, times, 'Times New Roman', serif;}
#slide0 h3 {margin-top: 0.5em; font-size: 1.5em;}
#slide0 h4 {margin-top: 0; font-size: 1em;}

ul.urls {list-style: none; display: inline; margin: 0;}
.urls li {display: inline; margin: 0;}
.note {display: none;}
__ui/print.css__
/* The next rule is necessary to have all slides appear in print! DO NOT REMOVE IT! */
div.slide, ul {page-break-inside: avoid; visibility: visible !important;}
h1 {page-break-after: avoid;}

body {font-size: 12pt; background: white;}
* {color: black;}

#slide0 h1 {font-size: 200%; border: none; margin: 0.5em 0 0.25em;}
#slide0 h3 {margin: 0; padding: 0;}
#slide0 h4 {margin: 0 0 0.5em; padding: 0;}
#slide0 {margin-bottom: 3em;}

h1 {border-top: 2pt solid gray; border-bottom: 1px dotted silver;}
.extra {background: transparent !important;}
div.extra, pre.extra, .example {font-size: 10pt; color: #333;}
ul.extra a {font-weight: bold;}
p.example {display: none;}

#footer h1 {margin: 0; border-bottom: 1px solid; color: gray; font-style: italic;}
#footer h2, #controls {display: none;}
__ui/s5-core.css__
/* Do not edit or override these styles! The system will likely break if you do. */

div#header, div#footer, div.slide {position: absolute;}
html>body div#header, html>body div#footer, html>body div.slide {position: fixed;}
div#header {z-index: 1;}
div.slide  {z-index: 2; visibility: hidden;}
#slide0 {visibility: visible;}
div#footer {z-index: 5;}
div#controls {position: absolute; z-index: 1;}
#footer>div#controls {position: fixed;}
.handout {display: none;}
__ui/pugpup.png__
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
