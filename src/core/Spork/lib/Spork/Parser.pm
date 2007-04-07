package Spork::Parser;
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
            blocks => $all_blocks,
        },
        center => {
            blocks => $all_blocks,
            match => qr/^\.center\n(.*?\n)(?:.center\n|\z)\n?/s,
        },
        indent => {
            blocks => $all_blocks,
            match => qr/^((?m:^>+.*\n)+\n?)/,
        },
        pre => {
            match => qr/^(( +.*\S.*\n)+)(?m:^ *\n)*/,
        },
        p => {
            phrases => $all_phrases,
            match => qr/^(((?!>).*\S.*\n)+)(?m:^\s*\n)*/,
        },
        ul => {
            blocks => [qw(ul li)],
            match => qr/^((?m:^\*+ .*\n)+)\n*/,
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
    $self->subparse(hilite => parse_phrases => @_);
}

sub handle_b {
    my $self = shift;
    $self->subparse(b => parse_phrases => @_);
}

sub handle_tt {
    my $self = shift;
    $self->subparse(tt => parse_phrases => @_);
}

sub handle_i {
    my $self = shift;
    $self->subparse(i => parse_phrases => @_);
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
