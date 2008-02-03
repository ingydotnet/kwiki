use t::TestDocumentTools tests => 3;

#no_diff;
spec_file 't/data/hr';

filters {
    creole => 'parse_creole_html',
};

run_is creole => 'html';
