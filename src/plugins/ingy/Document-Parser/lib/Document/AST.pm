package Document::AST;

sub new {
    my $class = shift;
    return bless { output => [], @_ }, ref($class) || $class;
}

sub content {
    my $self = shift;
    return $self->{output};
}

sub insert {
    my $self = shift;
    my $ast = shift;
    die;
    # $self->{output} .= $ast->{output};
}

sub begin_node {
    my $self = shift;
    my $tag = shift;
    die;
    # $self->{output} .= "+$tag\n";
}

sub end_node {
    my $self = shift;
    my $tag = shift;
    die;
    # $self->{output} .= "-$tag\n";
}

sub text_node {
    my $self = shift;
    my $text = shift;
    die;
    # $self->{output} .= " $text\n";
}

1;
