use inc::Module::Install;

name        'WikiText-Creole';
all_from    'lib/WikiText/Creole.pm';

requires    perl => '5.6.1';
requires    'Document::Parser' => '0';

use_test_base;

WriteAll;
