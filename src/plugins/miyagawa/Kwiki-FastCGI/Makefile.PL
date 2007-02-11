use inc::Module::Install;
name 'Kwiki-FastCGI';
all_from 'lib/Kwiki/FastCGI.pm';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
