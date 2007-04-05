package Document::Parser;
use strict;
use warnings;
use XXX;

#-------------------------------------------------------------------------------
# Parser object constructor/initializer
#-------------------------------------------------------------------------------
sub new {
    my $class = shift;
    return bless { @_ }, ref($class) || $class;
}

#-------------------------------------------------------------------------------
# Public - $parsed = $parser->parse($wikitext);
#-------------------------------------------------------------------------------
sub parse {
    my $self = shift;
    $self->{input} = shift;
    $self->parse_blocks('top');
    return $self->{ast}->content;
}

#-------------------------------------------------------------------------------
# Parse input into a series of blocks. With each iteration the parser must
# match a block at position 0 of the text, and remove that block from the
# input reparse it further. This continues until there is no input left.
#-------------------------------------------------------------------------------
sub parse_blocks {
    my $self = shift;
    my $container_type = shift;
    my $types = $self->{grammar}{$container_type}{contains};
    while (my $length = length $self->{input}) {
        for my $type (@$types) {
            my $matched = $self->find_match(matched_block => $type) or next;
            substr($self->{input}, 0, $matched->{end}, '');
            $self->handle_match($type, $matched);
            last;
        }
        die $self->reduction_error
            unless length($self->{input}) < $length;
    }
    return;
}

#-------------------------------------------------------------------------------
# This code parses a chunk into interleaved pieces of plain text and
# phrases. It repeatedly tries to match every possible phrase and
# then takes the match closest to the start. Everything before a
# match is written as text. Matched phrases are subparsed according
# to their rules. This continues until the input is all eaten.
#-------------------------------------------------------------------------------
sub parse_phrases {
    my $self = shift;
    my $container_type = shift;
    my $types = $self->{grammar}{$container_type}{contains};
    while (length $self->{input}) {
        my $match;
        for my $type (@$types) {
            my $matched = $self->find_match(matched_phrase => $type) or next;
            if (not defined $match or $matched->{begin} < $match->{begin}) {
                $match = $matched;
                $match->{type} = $type;
                last if $match->{begin} == 0;
            }
        }
        if (! $match) {
            $self->{ast}->text_node($self->{input});
            last;
        }
        my ($begin, $end, $type) = @{$match}{qw(begin end type)};
        $self->{ast}->text_node(substr($self->{input}, 0, $begin))
          unless $begin == 0;
        substr($self->{input}, 0, $end, '');
        $type = $match->{type};
        $self->handle_match($type, $match);
    }
    return;
}

sub find_match {
    my ($self, $matched_func, $type) = @_;
    my $matched;
    if (my $regexp = $self->{grammar}{$type}{match}) {
        if (ref($regexp) eq 'ARRAY') {
            for my $re (@$regexp) {
                if ($self->{input} =~ $re) {
                    $matched = $self->$matched_func;
                    last;
                }
            }
            return unless $matched;
        }
        else {
            return unless $self->{input} =~ $regexp;
            $matched = $self->$matched_func;
        }
    }
    else {
        my $func = "match_$type";
        next unless $self->can($func);
        $matched = $self->$func or return;
    }
    return $matched;
}

sub handle_match {
    my ($self, $type, $match) = @_;
    my $func = "handle_$type";
    $self->$func($match);
}

sub subparse {
    my ($self, $type, $func, $match, $filter) = @_;
    $self->{ast}->begin_node($type);
    my $parser = $self->new(
        grammar => $self->{grammar},
        ast => $self->{ast}->new,
        input => $filter
        ? do { $_ = $match->{text}; &$filter(); $_ }
        : $match->{text},
    );
    $parser->$func($type);
    $self->{ast}->insert($parser->{ast});
    $self->{ast}->end_node($type);
}

#-------------------------------------------------------------------------------
# Helper functions
#
# These are the odds and ends called by the code above.
#-------------------------------------------------------------------------------

sub reduction_error {
    my $self = shift;
    return ref($self) . qq[ reduction error for:\n"$self->{input}"];
}

sub matched_block {
    my $begin = defined $_[2] ? $_[2] : $-[0];
    die "All blocks must match at position 0"
      if "$begin" ne "0";

    return +{
        text => ($_[1] || $1),
        end => ($_[3] || $+[0]),
    };
}

sub matched_phrase {
    return +{
        text => ($_[1] || $1),
        begin => (defined $_[2] ? $_[2] : $-[0]),
        end => ($_[3] || $+[0]),
    };
}

package Document::AST;

sub new {
    my $class = shift;
    return bless { output => [], @_ }, ref($class) || $class;
}

sub content {
    my $self = shift;
    return $self->{output};
}

sub insert {
    my $self = shift;
    my $ast = shift;
    die;
    # $self->{output} .= $ast->{output};
}

sub begin_node {
    my $self = shift;
    my $tag = shift;
    die;
    # $self->{output} .= "+$tag\n";
}

sub end_node {
    my $self = shift;
    my $tag = shift;
    $tag =~ s/-.*//;
    $self->{output} .= "-$tag\n";
}

sub text_node {
    my $self = shift;
    my $text = shift;
    die;
    # $self->{output} .= " $text\n";
}

1;
