use inc::Module::Install;

name('Spork-Formatter-Kwid');
author('Brian Ingerson <ingy@cpan.org>');
abstract('Kwid Formatter for Spork');
license('perl');
version_from('lib/Spork/Formatter/Kwid.pm');

requires(qw(
    perl 5.6.1
));

check_nmake();

&WriteAll();
