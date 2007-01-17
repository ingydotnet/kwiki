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
&Date_Init(@Date::Manip::TestArgs);

$tests="

1:2:3:4:5:6:7
4
%yv %Mv %wv %dv %hv %mv %sv
  1_2_3_4_5_6_7

1:2:3:4:5:6:7
4
%yd %Md %wd %dd %hd %md %sd
  1.1667_2.0000_3.6018_4.2126_5.1019_6.1167_7.0000

1:2:3:4:5:6:7
0
%yh %Mh %wh %dh %hh %mh %sh
  1_14_3_25_605_36306_2178367

1:2:3:4:5:6:7
4
%yt %Mt %wt %dt %ht %mt %st
  1.1667_14.0000_3.6018_25.2126_605.1019_36306.1167_2178367.0000

1:2:3:4:5:6:7
approx
4
%yv %Mv %wv %dv %hv %mv %sv
  1_2_3_4_5_6_7

1:2:3:4:5:6:7
approx
4
%yd %Md %wd %dd %hd %md %sd
  1.2357_2.8283_3.6018_4.2126_5.1019_6.1167_7.0000

1:2:3:4:5:6:7
approx
4
%yh %Mh %wh %dh %hh %mh %sh
  1_14_63.875_451.125_10832_649926_38995567

1:2:3:4:5:6:7
approx
4
%yt %Mt %wt %dt %ht %mt %st
  1.2357_14.8283_64.4768_451.3376_10832.1019_649926.1167_38995567.0000
";

print "FormatDelta...\n";
&test_Func($ntest,\&Delta_Format,$tests,$runtests);

1;

