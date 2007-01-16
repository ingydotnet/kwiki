use inc::Module::Install;

name 'Kwiki-Search';
all_from 'lib/Kwiki/Search.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

WriteAll;
