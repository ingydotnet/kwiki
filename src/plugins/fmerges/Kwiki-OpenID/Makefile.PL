use inc::Module::Install;

name            ('Kwiki::OpenID');
abstract        ('OpenID authentication for Kwiki');
author          ('Florian Merges <fmerges@cpan.org>');
license         ('perl');
version_from    ('lib/Kwiki/OpenID.pm');
requires        ('Kwiki' => 0.38);
requires        ('Spoon' => 0.22);
requires        ('Kwiki::Username' => 0.14);
requires        ('Kwiki::Session'  => 0.01);
requires        ('Net::OpenID::Consumer' => 0.14);
requires        ('LWPx::ParanoidAgent' => 1.03);
requires        ('Text::Microformat' => 0.02);
 
build_requires  ('Test::More');

&WriteAll;
