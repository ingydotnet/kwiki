#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Kwiki::Docsite' );
}

diag( "Testing Kwiki::Docsite $Kwiki::Docsite::VERSION, Perl $], $^X" );
