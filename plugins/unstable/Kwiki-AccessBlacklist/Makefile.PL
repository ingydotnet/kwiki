use inc::Module::Install;

name('Kwiki-AccessBlacklist');
author('Brian Ingerson <ingy@ttul.org>');
abstract('Blacklist IP Addresses from Kwiki');
license('perl');
version_from('lib/Kwiki/AccessBlacklist.pm');

requires(qw(
    perl 5.6.1
));

check_nmake();

&WriteAll();
