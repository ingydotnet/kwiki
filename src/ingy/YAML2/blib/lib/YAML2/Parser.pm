package YAML2::Parser;
use strict;
use warnings;

use Class::Field qw(field);

sub new {
    my $class = shift;
    $class = ref($class) if ref $class;
    bless {@_}, $class;
}

sub parse {
    my $self = shift;
    $self->{stream} ||= shift;
#     $self->{grammar} ||= $self->set_grammar;
#     $self->{receiver} ||= $self->set_receiver;
#     $self->{receiver}->init;
    $self->parse_stream();
    return $self->{receiver}->content;
}

sub parse_stream {
    my $self = shift;
    $self->{receiver}->stream_start;
}

1;
