package Spork::Parser;
use strict;
use warnings;
use base 'Document::Parser';
use XXX;

my $ALPHANUM = '\p{Letter}\p{Number}\pM';

#-------------------------------------------------------------------------------
# Public - $parsed = $parser->parse($wikitext);
#-------------------------------------------------------------------------------
sub parse {
    my $self = shift;
    $self->set_grammar;
    $self->set_ast;
    return $self->SUPER::parse(@_);
}

sub set_grammar {
    my $self = shift;
    my $all_phrases = [qw(b i tt hilite)];
    my $all_blocks = [qw(indent center h2 ul pre p)];
    $self->{grammar} = 
    {
        top => {
            contains => $all_blocks,
        },
        center => {
            contains => $all_blocks,
            match => qr/^\.center\n(.*?\n)(?:.center\n|\z)\n?/s,
        },
        indent => {
            contains => $all_blocks,
            match => qr/^((?m:^>+.*\n)+\n?)/,
        },
        pre => {
            match => qr/^(( +.*\S.*\n)+)(?m:^ *\n)*/,
        },
        p => {
            contains => $all_phrases,
            match => qr/^(((?!>).*\S.*\n)+)(?m:^\s*\n)*/,
        },
        ul => {
            contains => [qw(ul li)],
            match => qr/^((?m:^\*+ .*\n)+)\n*/,
        },
        li => {
            contains => $all_phrases,
            match => qr/(.*)\n/,
        },
        h2 => {
            contains => $all_phrases,
            match => qr/^={2}\s+(.*?)\s*\n+/,
        },
        b => {
            contains => $all_phrases,
            match => [
        qr/((?:^|(?<=[^${ALPHANUM}\*]))\*\S[^\*]*\*(?=[^{$ALPHANUM}\*]|\z))/,
                qr/(\{\*.*?\*\})/,
            ],
        },
        i => {
            match => [
        qr/((?:^|(?<=[^${ALPHANUM}\/]))\/\S[^\/]*\/(?=[^{$ALPHANUM}\/]|\z))/,
                qr/(\{\/.*?\/\})/,
            ],
        },
        tt => {
            match => [
        qr/((?:^|(?<=[^${ALPHANUM}`]))`\S[^`]*`(?=[^{$ALPHANUM}`]|\z))/,
                qr/(\{`.*?`\})/,
            ],
        },
        hilite => {
            match => [
        qr/((?:^|(?<=[^${ALPHANUM}\|]))\|\S[^\|]*\|(?=[^{$ALPHANUM}\|]|\z))/,
                qr/(\{\|.*?\|\})/,
            ],
        },
    };
}

sub set_ast {
    my $self = shift;
    $self->{ast} = Spork::AST->new;
}

#-------------------------------------------------------------------------------
# Handler functions
#
# Each element type has a handler too. The handler writes out the begin and
# end events, and controls how the innards are subparsed. Many times the
# handler will mutate the matched text before it is reparsed.
#-------------------------------------------------------------------------------
sub handle_indent {
    my $self = shift;
    $self->subparse(indent => parse_blocks => @_, sub {
        s/^> *//mg;
        s/\n+\z/\n/;
    });
}

sub handle_center {
    my $self = shift;
    $self->subparse(center => parse_blocks => @_);
}

sub handle_h2 {
    my $self = shift;
    $self->subparse(h2 => parse_phrases => @_);
}

sub handle_p {
    my $self = shift;
    $self->subparse(p => parse_phrases => @_, sub { s/\n+\z// });
}

sub handle_pre {
    my $self = shift;
    $self->subparse(pre => parse_phrases => @_, sub {
        while (not /^\S/m) {
            s/^ //gm;
        }
    });
}

sub handle_ul {
    my $self = shift;
    $self->subparse(ul => parse_blocks => @_, sub {
        s/^\* *//mg;
        s/\n+\z/\n/;
    });
}

sub handle_li {
    my $self = shift;
    $self->subparse(li => parse_phrases => @_);
}

sub handle_hilite {
    my $self = shift;
    $self->subparse(hilite => parse_phrases => @_, sub {
        s/^\{?\|(.*)\|\}?$/$1/s;
    });
}

sub handle_b {
    my $self = shift;
    $self->subparse(b => parse_phrases => @_, sub {
        s/^\{?\*(.*)\*\}?$/$1/s;
    });
}

sub handle_tt {
    my $self = shift;
    $self->subparse(tt => parse_phrases => @_, sub {
        s/^\{?`(.*)`\}?$/$1/s;
    });
}

sub handle_i {
    my $self = shift;
    $self->subparse(i => parse_phrases => @_, sub {
        s/^\{?\/(.*)\/\}?$/$1/s;
    });
}

package Spork::AST;
use base 'Document::AST';
use XXX;

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
