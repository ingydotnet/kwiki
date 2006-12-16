use inc::Module::Install;

name 'Kwiki-Spork';
all_from 'lib/Kwiki/Spork.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.37
    Spork 0.18
));

WriteAll;
