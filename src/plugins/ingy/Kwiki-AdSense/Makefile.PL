use inc::Module::Install;

name 'Kwiki-AdSense';
all_from 'lib/Kwiki/AdSense.pm';

requires(qw(
    perl 5.6.1
));

WriteAll;
