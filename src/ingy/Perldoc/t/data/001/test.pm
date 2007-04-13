## Math is *Hard*
#
# As *Arithmetic Barbie* has taught us: "{/Math is Hard!/}".
# `Math::Barbie` changes all that. It makes doing math as easy as
# pulling a string.
#
# Copyright (c) 2007.
# Ingy döt Net <ingy@ingy.net>.
# All rights reserved.
# 
# Licensed under the same terms as Perl itself.

package Math::Barbie;
use base 'Exporter';
our @EXPORT = qw(add divide);

## Synopsis:
#     use Math::Barbie;
# 
#     print "2 + 4 = ", add(2, 4);
#     print "2 / 4 = ", divide(2, 4);

## Add two arguments and return the result.
sub add {
    my $x = shift;      ## First number
    my $y = shift;      ## Second number
    return $x + $y;
}

## Divide the first number by the second number and return the result.
sub divide {
    my $x = shift;      ## Numerator
    my $y = shift;      ## Divisor
      or die "Can't divide by zero";
    return $x / $y;
}

## See Also:
#
# [Math::Ken]

1;

## Bugs:
# 
# Math::Barbie currently only supports half of the mathematical functions.
# `subtract` and ``multiply` are /coming real soon now/.
