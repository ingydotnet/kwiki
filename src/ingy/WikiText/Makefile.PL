use inc::Module::Install;

name        'WikiText';
all_from    'lib/WikiText.pm';

requires    perl => '5.6.1';

use_test_base;

WriteAll;
