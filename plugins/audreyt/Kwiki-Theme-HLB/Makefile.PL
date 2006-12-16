use inc::Module::Install;

name 'Kwiki-Theme-HLB';
all_from 'lib/Kwiki/Theme/HLB.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.32
));

WriteAll;
