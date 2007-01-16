use inc::Module::Install;

name 'Kwiki-Theme-Klassik';
all_from 'lib/Kwiki/Theme/Klassik.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

WriteAll;
