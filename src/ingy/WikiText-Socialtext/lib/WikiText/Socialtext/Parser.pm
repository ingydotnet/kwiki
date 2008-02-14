package WikiText::Socialtext::Parser;
use strict;
use warnings;
use base 'WikiText::Parser';

# Reusable regexp generators used by the grammar
my $ALPHANUM = '\p{Letter}\p{Number}\pM';

sub create_grammar {
    my $all_phrases = [
#        qw(wafl_phrase asis wiki hyper im b_hyper mail b_mail),
        qw(wikilink tt b i del)
    ];
    my $all_blocks = [
#        qw(wafl_block hr hx wafl_p ul ol indent table p empty_p)
        qw(pre wafl_block hr hx waflparagraph ul ol blockquote table p)
    ];

    return {
        _all_blocks => $all_blocks,
        _all_phrases => $all_phrases,

        top => {
            blocks => $all_blocks,
        },

        wafl_block => {
            match => qr/(?:^\.([\w\-]+)\ *\n)((?:.*\n)*?)(?:\.\1\ *\n|\z)/,
        }, 

        p => {
           match =>  qr/^(            # Capture whole thing
                (?m:
                    ^(?!        # All consecutive lines *not* starting with
                    (?:
                        [\#\-\*]+[\ ] |
                        [\^\|\>] |
                        \.\w+\s*\n |
                        \{[^\}]+\}\s*\n
                    )
                    )
                    .*\S.*\n
                )+
                )
                (\s*\n)*   # and all blank lines after
            /x,
            phrases => $all_phrases,
            filter => sub { chomp },
        },

        pre => {
            match => qr/^(?m:^\.pre\ *\n)((?:.*\n)*?)(?m:^\.pre\ *\n)(?:\s*\n)?/,
        },

        blockquote => {
            match => qr/^((?m:^>.*\n)+)/,
            blocks => $all_blocks,
            filter => sub {
                s/^>\ //gm;
            },
        },

        waflparagraph => {
            match => qr/^\{(.*)\}[\ \t]*\n(?:\s*\n)?/,
            filter => sub {
                my $node = shift;
                my ($function, $options) = split /[: ]/, $node->{text}, 2;
                $options =~ s/\s*(.*?)\s*/$1/;
                $node->{attributes}{function} = $function;
                $node->{attributes}{options} = $options;
                undef $_;
            },
        },

        hx => {
            match => qr/^(\^+) +(.*?)(\s+=+)?\s*?\n+/,
            filter => sub {
                my $node = shift;
                $node->{type} = 'h' . length($node->{1});
                $_ = $node->{2};
            },
        },

        ul => {
            match => re_list('\*'),
            blocks => [qw(ul ol subl li)],
            filter => sub { s/^[\*\#] *//mg },
        }, 

        ol => {
            match => re_list('\#'),
            blocks => [qw(ul ol subl li)],
            filter => sub { s/^[\*\#] *//mg },
        },

        subl => {
            type => 'li',

            match => qr/^(          # Block must start at beginning
                                    # Capture everything in $1
                (.*)\n              # Capture the whole first line
                [\*\#]+\ .*\n      # Line starting with one or more bullet
                (?:[\*\#]+\ .*\n)*  # Lines starting with '*' or '#'
            )(?:\s*\n)?/x,          # Eat trailing lines
            blocks => [qw(ul ol li2)],
        },

        li => {
            match => qr/(.*)\n/,    # Capture the whole line
            phrases => $all_phrases,
        },

        li2 => {
            type => '',
            match => qr/(.*)\n/,    # Capture the whole line
            phrases => $all_phrases,
        },

        hr => {
            match => qr/^--+(?:\s*\n)?/,
        },

        table => {
            match => qr/^(
                (
                    (?m:^\|.*\|\ \n(?=\|))
                    |
                    (?m:^\|.*\|\ \ +\n)
                    |
                    (?ms:^\|.*?\|\n)
                )+
            )(?:\s*\n)?/x,
            blocks => ['tr'],
        },

        tr => {
            match => qr/^((?m:^\|.*?\|(?:\n| \n(?=\|)|  +\n)))/s,
            blocks => ['td'],
        },

        td => {
            match => qr/\|?\s*(.*?)\s*\|\n?/s,
            phrases => $all_phrases,
        },

        wikilink => {
            type => 'a',
            match => qr/
                (?:"([^"]*)"\s*)?(?:^|(?<=[^$ALPHANUM]))\[(?=[^\s\[\]])
                (.*?)
                \](?=[^$ALPHANUM]|\z)
            /x,
            filter => sub {
                my $node = shift;
                $node->{attributes}{target} = $node->{2};
                $_ = $node->{1} || $node->{2};
            },
        },

        b => {
            match => re_huggy(q{\*}),
        },

        tt => {
            match => re_huggy(q{\`}),
        },

        i => {
            match => WikiText::Socialtext::Parser::re_huggy(q{\_}),
        },

        del => {
            match => re_huggy(q{\-}),
        },
    };
}

sub re_huggy {
    my $brace1 = shift;
    my $brace2 = shift || $brace1;

    qr/
        (?:^|(?<=[^{$ALPHANUM}$brace1]))$brace1(?=\S)(?!$brace2)
        (.*?)
        $brace2(?=[^{$ALPHANUM}$brace2]|\z)
    /x;
}

sub re_list {
    my $bullet = shift;
    return qr/^(            # Block must start at beginning
                            # Capture everything in $1
        ^$bullet+\ .*\n     # Line starting with one or more bullet
        (?:[\*\#]+\ .*\n)*  # Lines starting with '*' or '#'
    )(?:\s*\n)?/x,          # Eat trailing lines
}

1;
