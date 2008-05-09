package WikiText::Wikrad::Emitter;
use strict;
use warnings;

use base 'WikiText::Emitter';
use XXX;

sub begin_node {
    my $self = shift;
    my $event = shift;
    my $type = $event->{type};
    my $method = "begin_node_$type";
    $self->$method($event);
}

sub begin_node_h2 {
    my $self = shift;
    my $event = shift;
    my $text = $event->{text};
    $text = "== $text ==";
    $self->{output} .= ' ' x ((80 - int(length($text))) / 2) . $text;

}

1;
