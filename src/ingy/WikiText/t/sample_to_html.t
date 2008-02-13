use t::TestWikiText tests => 3;

#no_diff;
spec_file 't/data/sample';

$t::TestWikiText::parser_module = 'WikiText::Sample::Parser';
$t::TestWikiText::emitter_module = 'WikiText::HTML::Emitter';

filters {
    sample => 'parse_wikitext',
};

run_is sample => 'html';
