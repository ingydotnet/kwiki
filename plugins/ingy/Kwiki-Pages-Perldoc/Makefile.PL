use inc::Module::Install;

name 'Kwiki-Pages-Perldoc';
all_from 'lib/Kwiki/Pages/Perldoc.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

WriteAll;
