use lib '../WikiText/lib';
use lib '../WikiText-Socialtext/lib';
use t::TestWikiText;

plan tests => 19;

#no_diff;

$t::TestWikiText::parser_module = 'WikiText::Socialtext::Parser';
$t::TestWikiText::emitter_module = 'WikiText::Wikrad::Emitter';

filters({socialtext => 'parse_wikitext'});

run_is 'socialtext' => 'wikrad';

__DATA__
=== Multiline Paragraphs

--- socialtext
^^ Canada

* [one]
** _two_

--- wikrad
                                  = Canada =

o [[one]]
  o //two//
