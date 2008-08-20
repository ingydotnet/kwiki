use inc::Module::Install;

name            'JS';
all_from        'lib/JS.pm';

use_test_base;

install_script  'js-cpan';

clean_files     'META.yml';

WriteAll;
