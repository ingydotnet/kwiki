package Document::Viewer::HTML;
use strict;
use warnings;

use base 'Document::AST';

#sub view {
#    my ($self, $ast) = @_;
#}

#sub new {
#    my $class = shift;
#    return bless { @_ }, ref($class) || $class;
#}

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
    my $tag = shift;
    $tag =~ s/-.*//;
    $self->{output} .= "<$tag>";
}

sub end_node {
    my $self = shift;
    my $tag = shift;
    $tag =~ s/-.*//;
    $self->{output} .= "</$tag>";
}

sub text_node {
    my $self = shift;
    my $text = shift;
    $text =~ s/\n/\n /g;
    $self->{output} .= "$text";
}

1;
