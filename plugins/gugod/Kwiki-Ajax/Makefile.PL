use inc::Module::Install;

name('Kwiki-Ajax');
author('Brian Ingerson <ingy@cpan.org>');
abstract('Ajax Support for Kwiki');
license('perl');
version_from('lib/Kwiki/Ajax.pm');

requires(qw(
    perl 5.6.1
));

check_nmake();

&WriteAll();
