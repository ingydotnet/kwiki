package Perldoc::Parser::Kwid;
use strict;
use warnings;
use Perldoc::Base;
use base 'Perldoc::Base';

use XXX;

field 'receiver';
field 'document';

my $punct = '-\\\\=(){}$@%&,.!<>\\[\\]:;?+^\'/';

my @all_phrases = (
    qw(
        link url comment item bold italic tt
        brace_bold brace_italic brace_tt brace_any
    )
);

my $kwid_grammar = {
    top => {
        has   => [ qw'heading verbatim comment para' ],
        begin => qr/^/,
        end   => qr/\Z/,
    },

    verbatim => {
        begin => qr/^(?=[ \t])/m,
        end   => qr/\n(?:\n|(?=[^ \t]))/,
    },

    comment => {
        begin => qr/^#/m,
        end   => qr/\n/,
    },

    item => {
        has   => [ grep {$_ ne 'item'} @all_phrases ],
        begin => qr/^(?:[-+*])+ /m,
        end   => qr/\n/, # (?=[-+*\n])/,
        handle => sub { "li" . (length($_[0]) - 1) },
    },

    heading => {
        has   => [ @all_phrases ],
        begin => qr/^=+ /m,
        end   => qr/^/m,
        handle => sub { "h" . (length($_[0]) - 1) },
    },

    para => {
        has   => [ @all_phrases ],
        begin => qr//,
        end   => qr/\n\n/,
    },

    url => {
        begin => qr{\b\w+://(?:[^,.)\s]|[,.](?!\s))+},
        end   => qr{},
        handle => sub { "a $_[0]" },
    },

    link => {
        has   => [ grep {$_ ne 'link'} @all_phrases ],
        begin => qr/\[ (?: [^\]\|\n]+ \| )?/x,
        end   => qr/\]/,
        handle => sub { $_[0] =~ /.([^\]\|\n]*)/; "a $1" },
    },

    brace_any => {
        has   => \@all_phrases,
        begin => qr{\{+\w+: },
        end   => sub { $_[0] =~ /^(\{+)/; my $len = length($1); qr/\}{$len}/ },
        handle => sub { $_[0] =~ /(\w+)/; $1 },
        nest  => 1,
    },

    directive_any => {
        has   => \@all_phrases,
        begin => qr{^\.\w+\n}m,
        end   => sub { $_[0] =~ /(\w+)/; qr/^!$1/ },
        handle => sub { substr($_[0], 1, -1) },
        nest  => 1,
    },

    bold => {
        has   => [ grep {$_ ne 'bold' and $_ ne 'link'} @all_phrases ],
        begin => qr{(?<=(?:\a|\s))\*(?=[$punct\w])},
        end   => sub { qr{(?<=[$punct\w])\*(?=[$punct]*(?=\Z|\s))} },
    },

    brace_bold => {
        id    => 'bold',
        has   => [ grep {$_ ne 'bold' and $_ ne 'link'} @all_phrases ],
        begin => qr{\{+\*},
        end   => sub { my $len = length($_[0]) - 1; qr/\*\}{$len}/ },
    },

    italic => {
        has   => [ grep {$_ ne 'italic' and $_ ne 'link'} @all_phrases ],
        begin => qr{(?<=(?:\a|\s))\/(?=[$punct\w])},
        end   => sub { qr{(?<=[$punct\w])\/(?=[$punct]*(?=\Z|\s))} },
    },

    brace_italic => {
        id    => 'italic',
        has   => [ grep {$_ ne 'italic' and $_ ne 'link'} @all_phrases ],
        begin => qr{\{+\/},
        end   => sub { my $len = length($_[0]) - 1; qr/\/\}{$len}/ },
    },

    tt => {
        has   => [ grep {$_ ne 'tt' and $_ ne 'link'} @all_phrases ],
        begin => qr{(?<=(?:\a|\s))`(?=[$punct\w])},
        end   => sub { qr{(?<=[$punct\w])`(?=[$punct]*(?=\Z|\s))} },
    },

    brace_tt => {
        id    => 'tt',
        has   => [ grep {$_ ne 'tt' and $_ ne 'link'} @all_phrases ],
        begin => qr{\{+`},
        end   => sub { my $len = length($_[0]) - 1; qr/`\}{$len}/ },
    },
};

compile_grammar($kwid_grammar);

sub compile_grammar {
    my $grammar = shift;
    for my $id (keys %$grammar) {
        my $rule = $grammar->{$id};
        $rule->{id} ||= $id;
        $rule->{has} ||= [];
        my $has = $rule->{has};
        for (my $i = 0; $i < @$has; $i++) {
            my $elem = $has->[$i];
            next if ref $elem;
            my $has_rule = $grammar->{$elem}
              or die "No rule '$elem' in grammar entry '$id'";
            $has->[$i] = $has_rule;
        }
    }
}

sub parse {
    my $self = shift;
    my $grammar = $kwid_grammar;
    # ({id => $id, has => $has, end => $end, handle => $handle,}, ...)
    my @stack;
    my @has = ($grammar->{top});
    my $str = $self->document->read;

    $str = '' unless defined($str);
    pos($str) = 0;

    PARSE: {
        my $candidates = join('|',
            map { "($_)" } (
                (map { $_->{end} } @stack),
                (map { ($_)->{begin} } @has)
            )
        );

        my $pos = pos($str);

        $str =~ /\G(?:(?:\\.)+|.)/gsc
          until $str =~ /\G(?:$candidates)/gc;

        # Now let's find out which ones matched...
        foreach my $idx (1 .. $#+) {
            no strict 'refs';
            defined $$idx or next;

            my $len = $-[$idx] - $pos;
            $self->receiver->text(substr($str, $pos, $len)) if $len > 0;

            if ($idx <= @stack) {
                # For each stack item from the end on, emit "id" handles
                $self->receiver->end($_->{handle})
                  for reverse splice(@stack, $idx - 1);

                @stack or last PARSE;

                # Pop onto the last frame
                @has = @{ $stack[-1]{has} };
                redo PARSE;
            }

            # Now we are at "begin".
            my $parser = $has[ $idx - @stack - 1 ];
            my $id     = $parser->{id};
            my $end    = $parser->{end};
            my $handle = $parser->{handle} || $id;

            $end = $end->($$idx) if ref $end eq 'CODE';
            $handle = $handle->($$idx) if ref $handle eq 'CODE';

            # Grep for nestedness
            my @this_has = ();

          HAS:
            foreach my $has (@{ $parser->{has} }) {
                unless ( ($has)->{nest} ) {
                    foreach my $frame (@stack) {
                        next HAS if $frame->{id} eq ($has)->{id};
                    }
                }
                push @this_has, $has;
            }

            push @stack, {
                id => $id,
                has => [ @this_has ],
                end => $end,
                handle => $handle,
            };
            @has = @this_has;

            $self->receiver->begin($handle);
            redo PARSE;
        }
    }
}

1;

=head1 NAME

Perldoc::Parser::Kwid;

=head1 SYNOPSIS

    # Convert kwid to html:
    use Perldoc::Parser::Kwid;
    use Perldoc::Emitter::HTML;

    my $html = '';
    my $receiver = Perldoc::Emitter::HTML->new->init(stringref => $html);
    my $kwid_text = 'This is Kwid markup';
    my $parser = Perldoc::Parser::Kwid->new(receiver => $receiver)
        ->init(string => $kwid_text);
    $parser->parse;
    print $html;

=head1 DESCRIPTION

Parse Kwid markup and fire events.

=head1 AUTHOR

Audrey Tang <autrijus@cpan.org>
Ingy döt Net <ingy@cpan.org>

Audrey wrote the original code for this parser.

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
