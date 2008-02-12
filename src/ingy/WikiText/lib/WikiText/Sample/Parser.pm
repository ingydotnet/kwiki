package WikiText::Sample::Parser;
use base 'WikiText::Parser';

sub create_grammar {
    my $all_blocks = [ 'h1',  'h2', 'h3', 'p' ];

    my $all_phrases = [ 'b', 'i' ];

    return {
        # Parsing starts at the "top" level document
        top => {
            blocks => $all_blocks,  # A document consists of top level blocks
        },
        p => {
            match => qr/^           # Blocks must start at beginning
            (                       # Capture paragraph in $1
                ((?!(?:             # Stop at certain blocks
                    [\=]            # Headings
                ))
                .*\S.*\n)+          # Otherwise, collect non-empty lines
            )
            (?:\s*\n)?              # Eat trailing newlines
            /x,
            phrases => $all_phrases,
            filter => sub { chomp },
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
        b => {
            phrases => $all_phrases,
            match => phrase("'''"),
        },
        i => {
            phrases => $all_phrases,
            match => phrase("''"),
        },
    };
}

# Reusable regexp generators used by the grammar
sub phrase {
    my $brace1 = shift;
    my $brace2 = shift || $brace1;

    return qr/
        ${brace1}       # Opening phrase markup
        (.*?'*)           # Capture content in $1
        ${brace2}       # Closing phrase markup
    /x;
}

sub re_header {
    my $level = shift;
    return qr/^         # Block must begin at position 0
        \={$level}      # Proper number of '=' chars
        \ +             # 1 or more spaces
        (.*?)           # Capture header content in $1
        \s*\n           # Eat trailing whitespace and newlines
    /x;
}

1;

=head1 NAME

WikiText::Sample::Parser - A Parser For Sample Markup

=head1 SYNOPSIS

    use WikiText::Sample::Parser;
    
=head1 DESCRIPTION

This module turns Sample markup text into parse events end sends them to
a receiver.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
