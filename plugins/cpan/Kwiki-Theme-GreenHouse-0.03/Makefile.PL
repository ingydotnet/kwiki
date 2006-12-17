use inc::Module::Install;
name('Kwiki-Theme-GreenHouse');
author('Ryan King <rking@panoptic.com');
abstract('Green Kwiki Theme');
license('perl');
version_from('lib/Kwiki/Theme/GreenHouse.pm');
requires(qw(
    perl 5.6.1
    Kwiki 0.34
));
check_nmake();
&WriteAll();
