use inc::Module::Install;

name 'Kwiki-Theme-Selectable';
all_from 'lib/Kwiki/Theme/Selectable.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.38
));

WriteAll;
