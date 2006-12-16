use inc::Module::Install;

name 'Kwiki-GuestBook';
all_from 'lib/Kwiki/GuestBook.pm';

requires(qw(
    perl 5.6.1
    Kwiki 0.37
    Kwiki::UserName 0.14
    DB_File 0
    DB_File::Lock 0
));

WriteAll;
