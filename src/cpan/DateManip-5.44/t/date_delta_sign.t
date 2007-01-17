#!/usr/local/bin/perl -w

require 5.001;
use Date::Manip;
@Date::Manip::TestArgs=();
$runtests=shift(@ARGV);
if ( -f "t/test.pl" ) {
  require "t/test.pl";
} elsif ( -f "test.pl" ) {
  require "test.pl";
} else {
  die "ERROR: cannot find test.pl\n";
}
$ntest=4;

print "1..$ntest\n"  if (! $runtests);
&Date_Init(@Date::Manip::TestArgs);

$calcs="

2001020304:05:06
+ 2 hours
  2001020306:05:06

2001020304:05:06
- 2 hours
  2001020302:05:06

2001020304:05:06
+ -2 hours
  2001020302:05:06

2001020304:05:06
- -2 hours
  2001020306:05:06

";

print "DateCalc (date,delta)...\n";
&test_Func($ntest,\&DateCalc,$calcs,$runtests);

1;
