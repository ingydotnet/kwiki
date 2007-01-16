use inc::Module::Install;

name            ('Kwiki-Command-Edit');
abstract        ('Extend kwiki to have -edit command');
author          ('Kang-min Liu <gugod@gugod.org>');
license         ('perl');
version_from    ('lib/Kwiki/Command/Edit.pm');
requires        (Kwiki => '0.37');
build_requires  ('Test::More');

&WriteAll;

