use inc::Module::Install;

name('Kwiki-Theme-OSCON');
author('Alberto Simoes');
abstract("Theme for OSCON 2007");
license('perl');
version_from('lib/Kwiki/Theme/OSCON2007.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

check_nmake();

&WriteAll();
