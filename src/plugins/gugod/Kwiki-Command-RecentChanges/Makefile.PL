use inc::Module::Install;

name            ('Kwiki-Command-RecentChanges');
abstract        ('1');
author          ('Kang-min Liu <gugod@gugod.org>');
license         ('perl');
version_from    ('lib/Kwiki/Command/RecentChanges.pm');
requires        ('Spiffy');
build_requires  ('Test::More');

&WriteAll;

