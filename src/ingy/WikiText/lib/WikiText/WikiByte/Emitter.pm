package WikiText::WikiByte::Emitter;
use strict;
use warnings;

sub new {
    my $class = shift;
    return bless {
        @_,
        last_event => '',
    }, ref($class) || $class;
}

sub init {
    my $self = shift;
    $self->{output} = '';
}

sub content {
    my $self = shift;
    return $self->{output};
}

sub insert {
    my $self = shift;
    my $ast = shift;
    if ($self->{last_event} eq 'text') {
        chomp $self->{output};
        my $subtext = $ast->{output} || '';
        $subtext =~ s/^ //;
        $self->{output} .= $subtext;
    }
    else {
        $self->{output} .= $ast->{output} || '';
    }
}

sub begin_node {
    my $self = shift;
    my $node = shift;
    my $tag = $node->{type};
    $tag =~ s/-.*//;
    my $attributes = _get_attributes($node);
    $self->{output} .= "+$tag$attributes\n";
    $self->{last_event} = 'begin';
}

sub end_node {
    my $self = shift;
    my $node = shift;
    my $tag = $node->{type};

    $self->{last_event} = 'end';

    return if $self->{output} =~ s/^\+$tag\b(.*\n)\z/=$tag$1/m;

    $tag =~ s/-.*//;
    $self->{output} .= "-$tag\n";
}

sub text_node {
    my $self = shift;
    my $text = shift;
    $text =~ s/\n/\n /g;
    if ($self->{last_event} eq 'text') {
        chomp $self->{output};
        $self->{output} .= "$text\n";
    }
    else {
        $self->{output} .= " $text\n";
    }
    $self->{last_event} = 'text';
}

sub _get_attributes {
    my $node = shift;
    return "" unless exists $node->{attributes};
    return join "", map {
        qq{ $_="${\ $node->{attributes}->{$_}}"}
    } sort keys %{$node->{attributes}};
}

1;

=head1 NAME

WikiText::WikiByte::Emitter - A WikiByte Emitter

=head1 SYNOPSIS

    use WikiText::WikiByte::Emitter;
    
=head1 DESCRIPTION

A receiver module to write documents as WikiByte. WikiByte is a
intermediate format for all wiki languages.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
