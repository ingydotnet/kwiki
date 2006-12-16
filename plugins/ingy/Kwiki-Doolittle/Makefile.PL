use inc::Module::Install;

name 'Kwiki-Doolittle';
all_from 'lib/Kwiki/Doolittle.pm';

requires(qw(
    perl 5.6.1
    Test::Chunks 0.38
));

WriteAll;
