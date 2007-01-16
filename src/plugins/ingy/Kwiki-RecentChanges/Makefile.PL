use inc::Module::Install;

name 'Kwiki-RecentChanges';
all_from 'lib/Kwiki/RecentChanges.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.37
));

WriteAll;
