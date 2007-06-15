use t::TestDocumentTools tests => 2;

use Document::Parser::Creole;
use Document::AST::WikiByte;

no_diff;
filters {
    creole => 'parse_creole',
};

sub parse_creole {
    my $parser = Document::Parser::Creole->new(
        receiver => Document::AST::WikiByte->new,
    );
    $parser->parse($_);
}

run_is creole => 'wikibyte';


__DATA__
=== Sublists are well formed XHTML
--- creole
= Unordered =

Unordered list:

* Item one.
* Item two.
** Subitem one.
*** Subsubitem one.
** Subitem two.
** Subitem three.
*** Subsubitem one (of subitem three).
* Item three.

Fini.
--- wikibyte
+h1
 Unordered
-h1
+p
 Unordered list:
-p
+ul
+li
 Item one.
-li
+li
 Item two.
+ul
+li
 Subitem one.
+ul
+li
 Subsubitem one.
-li
-ul
-li
+li
 Subitem two.
-li
+li
 Subitem three.
+ul
+li
 Subsubitem one (of subitem three).
-li
-ul
-li
-ul
-li
+li
 Item three.
-li
-ul
+p
 Fini.
-p

