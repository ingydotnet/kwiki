use inc::Module::Install;

name('Kwiki-Theme-OSCON');
author('Brian Ingerson <ingy@cpan.org>');
abstract('Kwiki Theme for OSCON 2005');
license('perl');
version_from('lib/Kwiki/Theme/OSCON.pm');

requires(qw(
    perl 5.6.1
));

check_nmake();

&WriteAll();
