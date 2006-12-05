use inc::Module::Install;

name        ('Kwiki-Archive-SVK');
author      ('Autrijus Tang <autrijus@autrijus.org>');
abstract    ('Kwiki Page Archival Using SVK');
license     ('perl');
version_from('lib/Kwiki/Archive/SVK.pm');

requires    (qw(
    perl    5.6.1
    SVK     0.17
    Kwiki   0.33
    IO::All 0.31
));

&WriteAll( sign => 1 );
