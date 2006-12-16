use inc::Module::Install;

name 'Kwiki-Revisions';
all_from 'lib/Kwiki/Revisions.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.38
));

WriteAll;
