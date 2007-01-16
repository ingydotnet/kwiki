use inc::Module::Install;

name 'Kwiki-PerlTidyBlocks';
all_from 'lib/Kwiki/PerlTidyBlocks.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.37
    Kwiki::Cache 0.11
    Perl::Tidy 20031021
));

WriteAll;
