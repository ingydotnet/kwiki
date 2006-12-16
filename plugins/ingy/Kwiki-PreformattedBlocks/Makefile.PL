use inc::Module::Install;

name 'Kwiki-PreformattedBlocks';
all_from 'lib/Kwiki/PreformattedBlocks.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

WriteAll;
