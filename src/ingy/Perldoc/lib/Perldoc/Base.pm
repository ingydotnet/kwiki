## Base Class for Perldoc Classes
#
# Perldoc is Spiffy.

## Synopsis:
# 
#     package Perldoc::Foo;
#     use Perldoc::Base -Base;

##
# Copyright (c) 2007. Ingy döt Net. All rights reserved.
#
# Licensed under the same terms as Perl itself.

package Perldoc::Base;
use strict;
use warnings;
use IO::All -utf8;
use Class::Field 0.10 qw'field const';
use XXX;

sub import {
    my $class = shift;
    my $flag = $_[0] || '';
    my $package = caller;
    if ($flag eq '-base') {
        no strict 'refs';
        push @{$package . "::ISA"}, $class;
        *{$package . "::$_"} = \&$_
          for qw'io field const WWW XXX YYY ZZZ';
    }
}

sub new {
    my $class = shift;
    return bless {@_}, $class;
}

1;
