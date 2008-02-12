use t::TestWikiText tests => 3;

#no_diff;
spec_file 't/data/sample';

filters {
    sample => 'parse_sample_wikibyte',
};

run_is sample => 'wikibyte';
