use inc::Module::Install;

name            ('Kwiki-Invite');
abstract        ('Invite your friends to visit this kwiki.');
author          ('Kang-min Liu <gugod@gugod.org>');
license         ('perl');
version_from    ('lib/Kwiki/Invite.pm');
requires        ('Kwiki' => 0.38);
build_requires  ('Test::More');

&WriteAll;

