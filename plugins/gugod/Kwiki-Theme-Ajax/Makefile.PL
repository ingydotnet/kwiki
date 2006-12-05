use inc::Module::Install;

name            ('Kwiki-Theme-Ajax');
abstract        ('');
author          ('Kang-min Liu <gugod@gugod.org>');
license         ('perl');
version_from    ('lib/Kwiki/Theme/Ajax.pm');
requires        ('Spiffy');
build_requires  ('Test::More');

&WriteAll;

