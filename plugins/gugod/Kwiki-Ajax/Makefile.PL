use inc::Module::Install;

name 'Kwiki-Ajax';
all_from 'lib/Kwiki/Ajax.pm';

requires(qw(
    perl 5.6.1
));

WriteAll;
