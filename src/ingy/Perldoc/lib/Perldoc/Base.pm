package Perldoc::Base;
use strict;
use warnings;
use base 'Exporter';

use Class::Field 0.10 qw'field const';
use XXX;

our @EXPORT = qw'field const XXX';

sub new {
    my $self = bless {}, shift;
    while (my ($k, $v) = splice @_, 0, 2) {
        $self->{$k} = $v;
    }
    return $self;
}

1;

=head1 NAME

Perldoc::Base - Base Class for Perldoc Classes

=head1 SYNOPSIS

    package Perldoc::Foo;
    use Perldoc::Base -Base;

=head1 DESCRIPTION

Perldoc is Spiffy.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

Audrey wrote the original code for this parser.

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
