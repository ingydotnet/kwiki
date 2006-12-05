#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Kwiki::Users::Cookie::SQL' );
}

diag( "Testing Kwiki::Users::Cookie::SQL $Kwiki::Users::Cookie::SQL::VERSION, Perl $], $^X" );
