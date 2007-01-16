use inc::Module::Install;

name 'Kwiki-Transclude';
all_from 'lib/Kwiki/Transclude.pm';

requires(qw(
    perl 5.6.1
));

WriteAll;
