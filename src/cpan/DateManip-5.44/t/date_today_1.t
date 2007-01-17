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
$ntest=8;

print "1..$ntest\n"  if (! $runtests);
&Date_Init(@Date::Manip::TestArgs,"ForceDate=1997-03-08-12:30:00");

$dates="

today
    1997030812:30:00

now
    1997030812:30:00

today at 4:00
    1997030804:00:00

now at 4:00
    1997030804:00:00

today week
    1997031512:30:00

now week
    1997031512:30:00

today week at 4:00
    1997031504:00:00

now week at 4:00
    1997031504:00:00

";

print "Date (today/now TodayIsMidnight=0)...\n";
&Date_Init("TodayIsMidnight=0","Internal=0");
&test_Func($ntest,\&ParseDate,$dates,$runtests);

1;
