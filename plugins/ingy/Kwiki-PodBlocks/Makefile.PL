use inc::Module::Install;

name 'Kwiki-PodBlocks';
all_from 'lib/Kwiki/PodBlocks.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
    Pod::Simple 0
));

WriteAll;
