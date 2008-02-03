package Document::Receiver;
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
    die "You need to override Document::Receiver::init";
    # $self->{output} = '';
}

sub insert {
    my $self = shift;
    my $ast = shift;
    die "You need to override Document::Receiver::insert";
    # $self->{output} .= $ast->{output};
}

sub begin_node {
    my $self = shift;
    my $context = shift;
    die "You need to override Document::Receiver::begin_node";
    # $self->{output} .= "+" . $context->{type} . "\n";
}

sub end_node {
    my $self = shift;
    my $context = shift;
    die "You need to override Document::Receiver::end_node";
    # $self->{output} .= "-" . $context->{type} . "\n";
}

sub text_node {
    my $self = shift;
    my $text = shift;
    die "You need to override Document::Receiver::text_node";
    # $self->{output} .= " $text\n";
}

1;
