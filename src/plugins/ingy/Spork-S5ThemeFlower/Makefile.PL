use inc::Module::Install;

name('Spork-S5ThemeFlower');
author('Brian Ingerson <ingy@cpan.org>');
abstract('Flower Theme for Spork::S5');
license('perl');
version_from('lib/Spork/S5ThemeFlower.pm');

requires(qw(
    perl 5.6.1
));

check_nmake();

&WriteAll();
