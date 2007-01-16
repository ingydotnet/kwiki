use inc::Module::Install;

name 'Kwiki-UserPreferences';
all_from 'lib/Kwiki/UserPreferences.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.37
));

WriteAll;
