use inc::Module::Install;

name('Kwiki-Doolittle');
author('Brian Ingerson <ingy@cpan.org>');
abstract('Hooks For the Doolittle Project');
license('perl');
version_from('lib/Kwiki/Doolittle.pm');

requires(qw(
    perl 5.6.1
    Test::Chunks 0.38
));

check_nmake();

&WriteAll();
