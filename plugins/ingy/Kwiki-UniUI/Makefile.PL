use inc::Module::Install;

name('Kwiki-UniUI');
author('Brian Ingerson <ingy@cpan.org>');
abstract('A Unified Interface Theme for Kwiki');
license('perl');
version_from('lib/Kwiki/UniUI.pm');

requires(qw(
    perl 5.6.1
));

check_nmake();

&WriteAll();
