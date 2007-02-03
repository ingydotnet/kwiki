use inc::Module::Install;

name('Kwiki-Theme-EEng');
author('Alberto Simoes');
abstract("EEng theme for Minho's University.");
license('perl');
version_from('lib/Kwiki/Theme/EEng.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

check_nmake();

&WriteAll();
