use inc::Module::Install;

name 'Kwiki-Zipcode';
all_from 'lib/Kwiki/Zipcode.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

WriteAll;
