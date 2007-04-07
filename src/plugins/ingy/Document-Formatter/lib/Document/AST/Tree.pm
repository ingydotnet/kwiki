package Document::AST::Tree;
use base 'Document::AST';

sub insert {
    my $self = shift;
    my $ast = shift;
    my $new = $ast->{output};
    my $current = $self->{output}[-1];
    my ($key) = keys %$current;
    push @{$current->{$key}}, @$new;
}

sub begin_node {
    my $self = shift;
    push @{$self->{output}}, {shift, []};
}

sub text_node {
    my $self = shift;
    push @{$self->{output}}, shift;
}

sub end_node {
}

1;
