use inc::Module::Install;

name('Kwiki-WeblogUpdates');
abstract('Hook to do weblogUpdates.ping xmlrpc to configured sites');
author('Chris Dent <chris.dent@socialtext.com>');
version_from('lib/Kwiki/WeblogUpdates.pm');
license('perl');

requires('Kwiki' => 0.37);
requires('LWP::UserAgent');

check_nmake();

&WriteAll();
