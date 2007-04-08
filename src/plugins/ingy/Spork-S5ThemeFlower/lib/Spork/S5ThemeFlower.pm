package Spork::S5ThemeFlower;
use Spork::S5Theme -Base;

our $VERSION = '0.10';

__DATA__

=head1 NAME

Spork::S5ThemeFlower - Flower Theme for Spork::S5

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
div#footer {top: auto; bottom: 0; height: 2.5em;}
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
/* Flower Theme 2004 by Martin Hense ::: www.lounge7.de */

/* Following are the presentation styles -- edit away!
   Note that the 'body' font size may have to be changed if the resolution is
    different than expected. */

body {background: #fff url(blume.jpg) no-repeat; color: #222; font-size: 2em;}
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
font-family: georgia, times, 'Times New Roman', serif; background: transparent url(blumerechts.jpg) right top no-repeat;
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
__ui/slides.css__
@import url(s5-core.css); /* required to make the slide show run at all */
@import url(framing.css); /* sets basic placement and size of slide components */
@import url(pretty.css);  /* stuff that makes the slides look better than blah */
__ui/blume.jpg__
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
__ui/blumerechts.jpg__
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
