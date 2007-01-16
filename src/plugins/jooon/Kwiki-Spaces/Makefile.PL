use inc::Module::Install;

name('Kwiki-Spaces');
author('Jon Aslund <jon.aslund.org>');
abstract('Blocks edit based on added URLs');
license('perl');
version_from('lib/Kwiki/Spaces.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.38
));

check_nmake();

&WriteAll();
