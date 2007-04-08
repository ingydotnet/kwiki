use inc::Module::Install;

name            'Perldoc';
all_from        'lib/Perldoc.pm';

requires        'perl' => '5.6.1';
requires        'Class::Field' => '0.10';

use_test_base;

# manifest_skip   'Stories';

install_script  'perl-doc';

WriteAll;
