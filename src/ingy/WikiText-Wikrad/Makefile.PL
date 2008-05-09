use inc::Module::Install;

name        'WikiText-Wikrad';
all_from    'lib/WikiText/Wikrad.pm';

requires    perl => '5.6.1';
requires    WikiText => '0.08';

use_test_base;

WriteAll;
