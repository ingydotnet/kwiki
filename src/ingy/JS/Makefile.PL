use inc::Module::Install;

name            'JS';
all_from        'lib/JS.pm';

use_test_base;

install_script  'js-cpan';

WriteAll;
