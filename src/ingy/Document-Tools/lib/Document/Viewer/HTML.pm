package Document::Viewer::HTML;
use strict;
use warnings;

use base 'Document::AST';
use CGI::Util;

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

sub uri_escape {
    $_ = shift;
    s/ /\%20/g;
    return $_;
}

sub begin_node {
    my $self = shift;
    my $tag = shift;
    my $node = shift;
    if ($tag eq "a") {
        $self->{output} .=
            '<a href="' .
            CGI::Util::escape($node->{href}) .
            '">';
        return;
    }
# XXX For tables.
#    $tag =~ s/-.*//;
    $self->{output} .= ($tag =~ /^(br|hr)$/)
        ? "<$tag />\n"
        : "<$tag>";
}

sub end_node {
    my $self = shift;
    my $tag = shift;
    $tag =~ s/-.*//;
    return if ($tag =~ /^(br|hr)$/);
    $self->{output} .= "</$tag>" .
        ($tag =~ /^(p|hr|table|ul|ol|h\d)$/ ? "\n" : "");
}

sub text_node {
    my $self = shift;
    my $text = shift;
    $self->{output} .= "$text";
}

1;
