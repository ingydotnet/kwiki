use inc::Module::Install;

name 'Kwiki-HomePagePreference';
all_from 'lib/Kwiki/HomePagePreference.pm';

requires(qw(
    perl 5.6.1
));

WriteAll;
