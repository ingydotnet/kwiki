use t::TestDocumentTools tests => 4;

#no_diff;
spec_file 't/data/phrases';

filters {
    creole => 'parse_creole_html',
};

run_is creole => 'html';
