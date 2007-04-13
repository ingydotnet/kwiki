## Perldoc Makefile handler
#
# This module provides the support for `Makefile` targets related to
# Perldoc.
#
# Copyright (c) 2007. Ingy döt Net. All rights reserved.
#
# Licensed under the same terms as Perl itself.

package Perldoc::Make;
use strict;
use warnings;
use Perldoc::Base -base;

sub import {
    my $class = shift;
    my $self = $class->new;
    my $command = shift
      or die "No command provided to Perldoc::Make::import";
    my $method = "handle_$command";
    eval { $self->$method(@ARGV) };
    if ($@) {
        warn $@;
        exit 1;
    }
    exit 0;
}

## Handler for `make doc`.
sub handle_pm_into_pod {
    my $self = shift;
    my $pm_file_path = shift;
    my $pod_file_path = $pm_file_path;
    my $pod = $self->convert_pm_to_pod($pm_file_path)
      or return;
    warn "Generating new documentation for '$pm_file_path'\n";
    my $pm_file = io($pm_file_path);
    my $pm_text = $pm_file->all;
    $pm_text =~ s/^=for perldoc\n.*?\n=cut\n/$pod/sm or
        do { $pm_text .= $pod };
    $pm_file->print($pm_text);
}

sub convert_pm_to_pod {
    my $self = shift;
    my $pm_path = shift;
    require Perldoc::Parser::Perldoc;
    require Perldoc::Document;
    my $stash = Perldoc::Parser::Perldoc->new(
        input_file => $pm_path,
    )->parse;
    my $doc = Perldoc::Document->new(
        stash => $stash,
    );
    return $doc->to_pod;
}

1;
