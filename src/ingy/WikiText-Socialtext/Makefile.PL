use inc::Module::Install;

name        'WikiText-Socialtext';
all_from    'lib/WikiText/Socialtext.pm';

requires    perl => '5.6.1';
requires    WikiText => '0.08';

use_test_base;

WriteAll;
