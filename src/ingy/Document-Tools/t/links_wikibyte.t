use t::TestDocumentTools tests => 2;

no_diff;
spec_file 't/data/links';

filters {
    creole => 'parse_creole_wikibyte',
};

run_is creole => 'wikibyte';
