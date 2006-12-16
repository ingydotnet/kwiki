use inc::Module::Install;

name 'Kwiki-BreadCrumbs';
all_from 'lib/Kwiki/BreadCrumbs.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.37
));

WriteAll;
