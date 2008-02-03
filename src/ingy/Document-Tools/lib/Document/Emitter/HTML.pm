package Document::Emitter::HTML;
use strict;
use warnings;

use base 'Document::Receiver';
use CGI::Util;

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
    my $node = shift;
    my $tag = $node->{type};
# XXX For tables maybe...
#    $tag =~ s/-.*//;
    $self->{output} .=
      ($tag =~ /^(br|hr)$/)
        ? "<$tag />\n" 
        : ($tag eq "wikilink")
          ?  $self->begin_wikilink($node)
          : "<$tag>";
}

sub begin_wikilink {
    my $self = shift;
    my $node = shift;
    my $tag = $node->{type};

    my $link = $self->{callbacks}{wikilink}
        ? $self->{callbacks}{wikilink}->($node)
        : CGI::Util::escape($node->{attributes}{target});
    return qq{<a href="$link">};
}

sub end_node {
    my $self = shift;
    my $node = shift;
    my $tag = $node->{type};
    $tag =~ s/-.*//;
    return if ($tag =~ /^(br|hr)$/);
    if ($tag eq "wikilink") {
        $self->{output} .= '</a>';
        return;
    }
    $self->{output} .= "</$tag>" .
        ($tag =~ /^(p|hr|table|ul|ol|h\d)$/ ? "\n" : "");
}

sub text_node {
    my $self = shift;
    my $text = shift;
    $self->{output} .= "$text";
}

1;
