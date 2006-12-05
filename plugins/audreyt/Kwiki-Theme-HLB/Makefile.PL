use inc::Module::Install;

name('Kwiki-Theme-HLB');
author('Brian Ingerson <ingy@cpan.org>');
abstract('The Classic Kwiki Theme Plugin');
license('perl');
version_from('lib/Kwiki/Theme/HLB.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.32
));

check_nmake();

&WriteAll();
