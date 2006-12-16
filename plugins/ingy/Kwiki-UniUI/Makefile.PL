use inc::Module::Install;

name 'Kwiki-UniUI';
all_from 'lib/Kwiki/UniUI.pm';

requires(qw(
    perl 5.6.1
));

WriteAll;
