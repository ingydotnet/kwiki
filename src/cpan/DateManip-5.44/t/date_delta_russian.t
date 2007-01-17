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
$ntest=2;

print "1..$ntest\n"  if (! $runtests);
&Date_Init(@Date::Manip::TestArgs);

$calcs="

среда 20 ноября 1996 12ч00
назад на 3 дня 2 часа 20 минут
  1996111509:40:00

вторник 4 декабря 2001 23ч00
вперед на 1 неделю 2 дня 3 часа
  2001121411:00:00

";

print "DateCalc (Russian,date,delta)...\n";
&Date_Init("Language=Russian","DateFormat=non-US","Internal=0");
&test_Func($ntest,\&DateCalc,$calcs,$runtests,2);

1;
