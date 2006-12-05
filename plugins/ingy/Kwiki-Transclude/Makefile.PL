use inc::Module::Install;

name('Kwiki-Transclude');
author('Brian Ingerson <ingy@cpan.org>');
abstract('Kwiki Transclusion Plugin');
license('perl');
version_from('lib/Kwiki/Transclude.pm');

requires(qw(
    perl 5.6.1
));

check_nmake();

&WriteAll();
