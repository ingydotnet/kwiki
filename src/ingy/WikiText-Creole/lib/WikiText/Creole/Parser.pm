package WikiText::Creole::Parser;
use base 'Document::Parser';

sub create_grammar {
    my $all_blocks = [
        'pre', 'table',
        'h6', 'h5', 'h4', 'h3', 'h2', 'h1',
        'ul', 'ol', 'hr', 'p',
    ];

    my $all_phrases = [
        'b', 'i', 'tt', 'br', 'wikilink',
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
                    [\=\|]          # Headings and tables
                ))
                .*\S.*\n)+          # Otherwise, collect non-empty lines
            )
            (?:\s*\n)?              # Eat trailing newlines
            /x,
            phrases => $all_phrases,
            filter => sub { chomp },
        },
        pre => {
            match => qr/^\{\{\{\n(.*?\n)\}\}\}\n+/s,
        },
        table => {
            match => qr/^((\|.*\n)+)\n*/,
            blocks => ['tr'],
        },
        tr => {
            match => qr/^(\|.*\n)/,
            blocks => ['td'],
            filter => sub { s/\|\s*$// },
        },
        td => {
            match => qr/^\|([^\|]*)/,
            phrases => $all_phrases,
            filter => sub { s/^\s*(.*?)\s*$/$1/ },
        },
        h1 => {
            match => re_header(1),
        },
        h2 => {
            match => re_header(2),
        },
        h3 => {
            match => re_header(3),
        },
        h4 => {
            match => re_header(4),
        },
        h5 => {
            match => re_header(5),
        },
        h6 => {
            match => re_header(6),
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
            match => qr/^ *----\s*\n/,
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
        wikilink => {
#            type => 'a',
            match => qr/\[\[(.*?)\]\]/,
            filter => sub {
                $_[0]->{attributes}{target} =
                    s/(.*?)\s*\|\s*(.*)/$2/ ? $1 : $_;
            },
        },

    };
}

# Reusable regexp generators used by the grammar
my $ALPHANUM = '\p{Letter}\p{Number}\pM';

sub regexp {
    my $brace1 = shift;
    my $brace2 = shift || $brace1;

    return qr/
        ${brace1}       # Opening phrase markup
        (.*?)           # Capture content in $1
        ${brace2}       # Closing phrase markup
    /x;
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
