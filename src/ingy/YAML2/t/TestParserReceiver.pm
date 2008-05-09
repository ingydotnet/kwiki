package t::TestParserReceiver;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = bless {@_}, $class;
    $self->{output} = '';
    return $self;
}

sub content {
    my $self = shift;
    return $self->{output};
}

sub stream_start {
    my $self = shift;
    $self->{output} .= "stream_start\n";
}

sub stream_end {
    my $self = shift;
    $self->{output} .= "stream_end\n";
}

sub document_start {
    my $self = shift;
    $self->{output} .= "document_start\n";
}

sub document_end {
    my $self = shift;
    $self->{output} .= "document_end\n";
}

1;
