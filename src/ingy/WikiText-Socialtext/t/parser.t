use lib '../WikiText/lib';
use t::TestWikiText;

plan tests => 11;

#no_diff;

$t::TestWikiText::parser_module = 'WikiText::Socialtext::Parser';
$t::TestWikiText::emitter_module = 'WikiText::WikiByte::Emitter';

filters({wikitext => 'parse_wikitext'});

run_is 'wikitext' => 'wikibyte';

__DATA__
=== Multiline Paragraphs

--- wikitext
this is a multiline blob of
text that should be in a
single paragraph

but this should be alone

--- wikibyte
+p
 this is a multiline blob of
 text that should be in a
 single paragraph
-p
+p
 but this should be alone
-p

=== H1 and Bold
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

=== H4 and Bold
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

Some text.

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
+p
 Some text.
-p

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

=== Italics and Indented
--- wikitext
> This is _italic_ indented text
> that has more indents

--- wikibyte
+blockquote
+p
 This is 
+i
 italic
-i
  indented text
 that has more indents
-p
-blockquote

=== Links and Named Links
--- wikitext
[Link to a page]
"other page"[Second link]

--- wikibyte
+p
+a target="Link to a page"
 Link to a page
-a
 
 
+a target="Second link"
 other page
-a
-p

=== pre text
--- wikitext
.pre
no *bold* here
.pre
but *bold* here

--- wikibyte
+pre
 no *bold* here
 
-pre
+p
 but 
+b
 bold
-b
  here
-p

=== WAFL Paragraph
--- wikitext
{foo: bar}

some text
--- wikibyte
+waflparagraph function="foo" options="bar"
-waflparagraph
+p
 some text
-p

=== Horizonal Rule
--- wikitext
line

----

goes here

--- wikibyte
+p
 line
-p
+hr
-hr
+p
 goes here
-p

