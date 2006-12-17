use inc::Module::Install;

name('Kwiki-Icons-Crystal');
author('Matt Howard <hattmoward@cpan.org>');
abstract('Kwiki Crystal Icons Plugin');
license('gpl');
version_from('lib/Kwiki/Icons/Crystal.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.30
    Kwiki::Icons 0
));

check_nmake();

&WriteAll();
