use inc::Module::Install;

name('Kwiki-Theme-Aqua');
author('Alberto Simoes');
abstract('A aqua theme.);
license('perl');
version_from('lib/Kwiki/Theme/Aqua.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.34
));

check_nmake();

&WriteAll();
