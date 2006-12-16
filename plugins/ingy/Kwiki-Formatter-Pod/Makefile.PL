use inc::Module::Install;

name 'Kwiki-Formatter-Pod';
all_from 'lib/Kwiki/Formatter/Pod.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

WriteAll;
