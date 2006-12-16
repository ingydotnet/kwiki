use inc::Module::Install;

name 'Kwiki-Cache';
all_from 'lib/Kwiki/Cache.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.34
    Digest::MD5 0
));

WriteAll;
