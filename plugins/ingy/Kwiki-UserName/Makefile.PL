use inc::Module::Install;

name 'Kwiki-UserName';
all_from 'lib/Kwiki/UserName.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.37
    Kwiki::UserPreferences 0.13
));

WriteAll;
