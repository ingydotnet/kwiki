use inc::Module::Install;

name('Kwiki-Notify-IRC');
abstract('announce updates to your Kwiki on IRC channels');
author('Ian Langworth <ian@cpan.org>');
version_from('lib/Kwiki/Notify/IRC.pm');
license('perl');

requires(qw(
    perl 5.6.1
    Kwiki 0.32
    POE::Component::IKC::ClientLite
    POE::Component::IRC
    YAML
    Term::ANSIColor
));

check_nmake();

&WriteAll();
