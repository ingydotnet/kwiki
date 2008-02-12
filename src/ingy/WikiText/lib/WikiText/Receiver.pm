package WikiText::Receiver;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = bless {
        callbacks => ref($class) ? $class->{callbacks} : {},
        @_
    }, ref($class) || $class;
}

sub content {
    my $self = shift;
    return $self->{output};
}

sub init {
    my $self = shift;
    die "You need to override WikiText::Receiver::init";
    # $self->{output} = '';
}

sub insert {
    my $self = shift;
    my $ast = shift;
    die "You need to override WikiText::Receiver::insert";
    # $self->{output} .= $ast->{output};
}

sub begin_node {
    my $self = shift;
    my $context = shift;
    die "You need to override WikiText::Receiver::begin_node";
    # $self->{output} .= "+" . $context->{type} . "\n";
}

sub end_node {
    my $self = shift;
    my $context = shift;
    die "You need to override WikiText::Receiver::end_node";
    # $self->{output} .= "-" . $context->{type} . "\n";
}

sub text_node {
    my $self = shift;
    my $text = shift;
    die "You need to override WikiText::Receiver::text_node";
    # $self->{output} .= " $text\n";
}

1;

=head1 NAME

WikiText::Receiver - An Interface Class

=head1 SYNOPSIS

    use base 'WikiText::Receiver';
    
=head1 DESCRIPTION

The base class of WikiText modules that act as receivers of parse events, and
are therefore hooked up to a parser.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
