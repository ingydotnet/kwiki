# perl-test
# $Id: 04-string-mod.t 192 2006-01-04 07:57:15Z knok $

use strict;
use Test;

BEGIN { plan tests => 2 };

use File::MMagic;

my $dir = -d 't' ? 't/' : '';


my $m1 = File::MMagic->new($dir . 'test-magic');
my $ret = $m1->checktype_filename($dir . 'test.html');
ok($ret eq 'text/html');
my $m2 = File::MMagic->new();
$ret = $m2->checktype_filename($dir . 'test.html');
ok($ret eq 'text/html');
