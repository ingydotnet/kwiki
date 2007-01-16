use inc::Module::Install;

name 'Kwiki-ParagraphBlocks';
all_from 'lib/Kwiki/ParagraphBlocks.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

WriteAll;
