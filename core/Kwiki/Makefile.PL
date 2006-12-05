use inc::Module::Install;

name('Kwiki');
author('Brian Ingerson <ingy@cpan.org>');
abstract('Kwiki Wiki Framework');
license('perl');
version_from('lib/Kwiki.pm');

requires(qw(
    perl 5.6.1
    Spoon 0.22
    Storable 0
    URI::Escape 0
));

install_script('kwiki');

check_nmake();

&WriteAll();
