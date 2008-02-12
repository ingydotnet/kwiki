use t::TestWikiText tests => 3;

#no_diff;
spec_file 't/data/sample';

filters {
    sample => 'parse_sample_html',
};

run_is sample => 'html';
