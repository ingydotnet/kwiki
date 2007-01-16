use inc::Module::Install;

name 'Kwiki-Favorites';
all_from 'lib/Kwiki/Favorites.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.37
));

WriteAll;
