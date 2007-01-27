use inc::Module::Install;

name('Kwiki-Theme-BlueRain');
author('Alberto Simoes');
abstract('A blue theme.);
license('perl');
version_from('lib/Kwiki/Theme/BlueRain.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

check_nmake();

&WriteAll();
