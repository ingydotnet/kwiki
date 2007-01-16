use inc::Module::Install;

name 'Kwiki-NewPage';
all_from 'lib/Kwiki/NewPage.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

WriteAll;
