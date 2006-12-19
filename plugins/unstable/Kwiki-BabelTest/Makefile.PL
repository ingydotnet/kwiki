use inc::Module::Install;

name('Kwiki-BabelTest');
author('Brian Ingerson <ingy@cpan.org>');
abstract('BabelTest Blocks Plugin');
license('perl');
version_from('lib/Kwiki/BabelTest.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.31
));

check_nmake();

&WriteAll();
