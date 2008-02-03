use t::TestDocumentTools tests => 2;

# no_diff;
spec_file 't/data/lists';

filters {
    creole => 'parse_creole_wikibyte',
};

run_is creole => 'wikibyte';
