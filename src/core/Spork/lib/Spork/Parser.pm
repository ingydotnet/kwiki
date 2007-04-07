package Spork::Parser;
use strict;
use warnings;
use base 'Document::Parser';

sub set_grammar {
    my $self = shift;
    my $all_phrases = [qw(b i tt hilite)];
    my $all_blocks = [qw(indent center h2 ul pre p)];
    $self->{grammar} = 
    {
        top => {
            blocks => $all_blocks,
        },
        center => {
            blocks => $all_blocks,
            match => qr/^\.center\n(.*?\n)(?:.center\n|\z)\n?/s,
        },
        indent => {
            blocks => $all_blocks,
            match => qr/^((?m:^>+.*\n)+\n?)/,
            filter => sub { s/^> *//mg; s/\n+\z/\n/ },
        },
        pre => {
            match => qr/^(( +.*\S.*\n)+)(?m:^ *\n)*/,
            filter => sub { while (not /^\S/m) { s/^ //gm } },
        },
        p => {
            phrases => $all_phrases,
            match => qr/^(((?!>).*\S.*\n)+)(?m:^\s*\n)*/,
            filter => sub { s/\n+\z// },
        },
        ul => {
            blocks => [qw(ul li)],
            match => qr/^((?m:^\*+ .*\n)+)\n*/,
            filter => sub { s/^\* *//mg; s/\n+\z/\n/; },
        },
        li => {
            phrases => $all_phrases,
            match => qr/(.*)\n/,
        },
        h2 => {
            phrases => $all_phrases,
            match => qr/^={2}\s+(.*?)\s*\n+/,
        },
        b => {
            phrases => $all_phrases,
            match => [re_huggy('\*'), qr/(\{\*.*?\*\})/ ],
        },
        i => {
            match => [re_huggy('\/'), qr/(\{\/.*?\/\})/ ],
        },
        tt => {
            match => [re_huggy('`'), qr/(\{`.*?`\})/ ],
        },
        hilite => {
            match => [re_huggy('\|'), qr/(\{\|.*?\|\})/ ],
        },
    };
}

my $ALPHANUM = '\p{Letter}\p{Number}\pM';

sub re_huggy {
    my $brace1 = shift;
    my $brace2 = shift || $brace1;

    return qr/
        (?:^|(?<=[^${ALPHANUM}${brace1}]))
        ${brace2}(\S[^${brace2}]*)${brace2}
        (?=[^{$ALPHANUM}${brace2}]|\z)
    /x;
}

sub set_ast {
    my $self = shift;
    $self->{ast} = Spork::AST->new;
}

package Spork::AST;
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
