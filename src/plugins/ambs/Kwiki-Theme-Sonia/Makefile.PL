use inc::Module::Install;

name('Kwiki-Theme-Sonia');
author('Alberto Simoes');
abstract('A blue theme.);
license('perl');
version_from('lib/Kwiki/Theme/Sonia.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

check_nmake();

&WriteAll();
