use lib '../WikiText/lib';
use t::TestWikiText;

plan tests => 5;

#no_diff;

$t::TestWikiText::parser_module = 'WikiText::Socialtext::Parser';
$t::TestWikiText::emitter_module = 'WikiText::WikiByte::Emitter';

filters({wikitext => 'parse_wikitext'});

run_is 'wikitext' => 'wikibyte';

__DATA__
=== First Test
--- wikitext
^ Hello

We are *Devo*.

--- wikibyte
+h1
 Hello
-h1
+p
 We are 
+b
 Devo
-b
 .
-p

=== Second Test
--- wikitext
^^^^ Goodbye

We are not *Devo*.

--- wikibyte
+h4
 Goodbye
-h4
+p
 We are not 
+b
 Devo
-b
 .
-p

=== Strikeout and Monospace
--- wikitext
this is -strikeout- text, and `monospace` text.

--- wikibyte
+p
 this is 
+del
 strikeout
-del
  text, and 
+tt
 monospace
-tt
  text.
-p

=== Table Test 1
--- wikitext
|table|value|
| *one*|1|
|two|2|

--- wikibyte
+table
+tr
+td
 table
-td
+td
 value
-td
-tr
+tr
+td
+b
 one
-b
-td
+td
 1
-td
-tr
+tr
+td
 two
-td
+td
 2
-td
-tr
-table

=== Unordered and Ordered Lists
--- wikitext
* one
** two a
** two b
* two
## -ol one-
## ol two
--- wikibyte
+ul
+li
 one
+ul
+li
 two a
-li
+li
 two b
-li
-ul
-li
+li
 two
+ol
+li
+del
 ol one
-del
-li
+li
 ol two
-li
-ol
-li
-ul

