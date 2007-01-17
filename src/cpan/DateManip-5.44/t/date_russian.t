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
$ntest=16;

print "1..$ntest\n"  if (! $runtests);
&Date_Init(@Date::Manip::TestArgs,"ForceDate=1997-03-08-12:30:00");

$dates="

двадцать седьмого июня 1977 16:00:00
    1977062716:00:00

04.12.1999
    1999120400:00:00

2 мая 2012
    2012050200:00:00

2 май 2012
    2012050200:00:00

31/12/2000
    2000123100:00:00

3 сен 1975
    1975090300:00:00

27 окт 2001
    2001102700:00:00

первое сентября 1980
    1980090100:00:00

декабрь 20, 1999
    1999122000:00:00

20 июля 1987 12:32:20
    1987072012:32:20

23:37:20 первое июня 1987
    1987060123:37:20

20/12/01 17:27:08
    2001122017:27:08

20/12/01 в 17:27:08
    2001122017:27:08

20/12/01 в 17ч27м08с00
    2001122017:27:08

17:27:08 20/12/01
    2001122017:27:08

4 октября 1975 4ч00 дня
    1975100416:00:00
";

print "Date (Russian)...\n";
&Date_Init("Language=Russian","DateFormat=non-US","Internal=0");
&test_Func($ntest,\&ParseDate,$dates,$runtests);

1;
