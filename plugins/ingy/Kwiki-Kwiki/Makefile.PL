use inc::Module::Install;

name            'Kwiki-Kwiki';
license         'perl';
all_from        'lib/Kwiki/Kwiki.pm';

manifest_skip   qw'ToDo';

requires        perl => '5.8.4';

WriteAll;
