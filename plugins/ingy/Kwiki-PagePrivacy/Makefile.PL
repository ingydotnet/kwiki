use inc::Module::Install;

name 'Kwiki-PagePrivacy';
all_from 'lib/Kwiki/PagePrivacy.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.37
));

WriteAll;
