use inc::Module::Install;

name 'Kwiki-Archive-Rcs';
all_from 'lib/Kwiki/Archive/Rcs.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.38
));

WriteAll;
