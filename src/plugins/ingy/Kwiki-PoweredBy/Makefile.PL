use inc::Module::Install;

name 'Kwiki-PoweredBy';
all_from 'lib/Kwiki/PoweredBy.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.38
));

WriteAll;
