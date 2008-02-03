package Document::Parser::Creole;
use base 'Document::Parser';

sub create_grammar {
    my $all_blocks = [
        'h6', 'h5', 'h4', 'h3', 'h2', 'h1',
        'ul', 'ol', 'hr', 'table', 'p',
    ];

    my $all_phrases = [
        'b', 'i', 'tt', 'br',
    ];

    return {
        # These two lines are for introspection and potential dynamic
        # grammar modification.
        _all_blocks => $all_blocks,
        _all_phrases => $all_phrases,

        # Parsing starts at the "top" level document
        top => {
            blocks => $all_blocks,  # A document consists of top level blocks
        },
        p => {
            match => qr/^           # Blocks must start at beginning
            (                       # Capture paragraph in $1
                ((?!(               # Stop at certain blocks
                    ?:[\#\-\*]+\    #   Lists
                |
                    [\^\|\>]        # Headings and indents
                |
                    \.\w+\s*\n)     # Wafl blocks
                )
                .*\S.*\n)+          # Otherwise, collect non-empty lines
            )
            (?:\s*\n)?              # Eat trailing newlines
            /x,
            phrases => $all_phrases,
            filter => sub { chomp },
        },
        h1 => {
            match => re_header(1),
            phrases => $all_phrases,
        },
        h2 => {
            match => re_header(2),
            phrases => $all_phrases,
        },
        h3 => {
            match => re_header(3),
            phrases => $all_phrases,
        },
        h4 => {
            match => re_header(4),
            phrases => $all_phrases,
        },
        h5 => {
            match => re_header(5),
            phrases => $all_phrases,
        },
        h6 => {
            match => re_header(6),
            phrases => $all_phrases,
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
            phrases =>$all_phrases,
        },
        li2 => {
            type => '',
            match => qr/(.*)\n/,    # Capture the whole line
            phrases =>$all_phrases,
        },
        hr => {
            match => qr/\ *----\ *\n/,
        },
        
        b => {
            phrases => $all_phrases,
            match => regexp('\*\*'),
        },
        i => {
            phrases => $all_phrases,
            match => regexp('\/\/'),
        },
        tt => {
            match => regexp('{{{', '}}}'),
        },
        br => {
            match => qr/\\\\/,
        },
    };
}

# Reusable regexp generators used by the grammar
my $ALPHANUM = '\p{Letter}\p{Number}\pM';

sub re_huggy {
    my $brace1 = shift;
    my $brace2 = shift || $brace1;

    return qr/
        (?:^|(?<=[^${ALPHANUM}${brace1}]))  # Start or non-alpha to the left
        ${brace1}                           # Opening phrase markup
        (\S[^${brace2}]*)                   # Capture phrase content in $1
        ${brace2}                           # Closing phrase markup
        (?=[^{$ALPHANUM}${brace2}]|\z)      # End or non-alpha to the right
    /x;
}

sub re_bracket {
    my $markup = shift;
    return qr/
        \{$markup       # Open curly + markup-char
        (.*?)           # Capture content in $1
        $markup\}       # Markup-char + closed curly
    /xs;
}

sub re_header {
    my $level = shift;
    return qr/^         # Block must begin at position 0
        \={$level}      # Proper number of '=' chars
        \ *             # 0 or more spaces (I wish this was 1 or more)
        (.*?)           # Capture header content in $1
        (?:\ *\={$level})?  # Possible ending markers
        \s*\n           # Eat trailing whitespace and newlines
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
