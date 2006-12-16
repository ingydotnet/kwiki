use inc::Module::Install;

name 'Kwiki-Ajax-Toolman';
all_from 'lib/Kwiki/Ajax/Toolman.pm';

requires(qw(
    perl 5.6.1
    Kwiki::Ajax 0
));

WriteAll;
