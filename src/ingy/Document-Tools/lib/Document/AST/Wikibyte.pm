package Document::AST::WikiByte;
use strict;
use warnings;

sub new {
    my $class = shift;
    return bless { @_ }, ref($class) || $class;
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
    $self->{output} .= $ast->{output} || '';
}

sub begin_node {
    my $self = shift;
    my $node = shift;
    my $tag = $node->{type};
    $tag =~ s/-.*//;
    my $attributes = _get_attributes($node);
    $self->{output} .= "+$tag$attributes\n";
}

sub end_node {
    my $self = shift;
    my $node = shift;
    my $tag = $node->{type};
    $tag =~ s/-.*//;
    $self->{output} .= "-$tag\n";
}

sub text_node {
    my $self = shift;
    my $text = shift;
    $text =~ s/\n/\n /g;
    $self->{output} .= " $text\n";
}

sub _get_attributes {
    my $node = shift;
    return "" unless exists $node->{attributes};
    return join "", map {
        qq{ $_="${\ $node->{attributes}->{$_}}"}
    } sort keys %{$node->{attributes}};
}

1;
