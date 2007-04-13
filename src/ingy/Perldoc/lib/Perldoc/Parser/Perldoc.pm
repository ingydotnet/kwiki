## Parse Perldoc Information from a Perl Module
#
# This module parses various bits of information from a Perl module and
# returns them as a hash.
#
# Copyright (c) 2007. Ingy döt Net <ingy@ingy.net>. All rights reserved.
#
# Licensed under the same terms as Perl itself.

package Perldoc::Parser::Perldoc;
use strict;
use warnings;
use Perldoc::Base -base;
use Perldoc::Fold;

field 'input_file';
field 'input_buffer';
field 'block';
field 'context';
field stash => {};

## Synopsis:
#
#     my $hash = Perldoc::Parser::Perldoc->new(
#         input_file => 'lib/Foo.pm,
#     )->parse;

sub parse {
    my $self = shift;
    $self->input_buffer(\ io($self->input_file)->all);
    $self->fold_blocks;
    while ($self->get_next_block) {
        $self->trim_block;
        $self->parse_class_header or
        $self->parse_named_block or
        $self->parse_sub_header or
        die "Can't parse the following block:\n$self->{block}";
    }
    return $self->stash;
}

sub parse_class_header {
    my $self = shift;
    my $context = $self->context;
    return unless $context =~ /^package\s+([\w\:]+)/;
    my $stash = $self->stash;
    my $package = $1;
    $self->get_author_stuff unless $stash->{author}{name};
    $self->get_license unless $stash->{copyright}{license};
    $stash->{module}{name} = $package;
    $stash->{module}{title} ||= $self->get_first_line;
    $stash->{module}{description} ||= $self->get_entire_block;
    $stash->{free_text} .= $self->get_entire_block;
    return 1;
}

sub parse_named_block {
    my $self = shift;
    my $block = $self->block;
    $$block =~ s/^\s*(\w.*):\s*\n//
      or return;
    my $name = lc($1);
    $name =~ s/[^\w]/_/g;
    $name =~ s/_+/_/g;
    $name =~ s/^_?(.*?)_?/$1/;
    $self->stash->{$name} = $self->get_entire_block;
    return 1;
}

sub parse_sub_header {
    my $self = shift;
    my $context = $self->context;
    return unless $context =~ /^sub\s+(\w+)/;
    my $stash = $self->stash;
    return 1;
}

sub get_author_stuff {
    my $self = shift;
    my $block = $self->block;
    $$block =~ s/^Copyright \(c\) (.*)\.\s+(.*)\.\s+All rights reserved\.\s*\n//m
      or return;
    my $stash = $self->stash;
    $stash->{copyright}{years} = $1;
    my $author = $2;
    if ($author =~ /(.*?)\s*<(.*)>/) {
        $stash->{author}{name} = $1;
        $stash->{author}{email} = $2;
    }
    else {
        $stash->{author}{name} = $2;
    }
}

sub get_license {
    my $self = shift;
    my $block = $self->block;
    $$block =~ s/^Licensed under the same terms as Perl itself\.\s*\n//m
      or return;
    my $stash = $self->stash;
    $stash->{copyright}{license} = 'perl-artistic';
}

sub get_entire_block {
    my $self = shift;
    $self->trim_block;
    my $block = $self->block;
    $$block =~ s/(.*)//s;
    return $1 || '';
}

sub get_first_line {
    my $self = shift;
    my $block = $self->block;
    $$block =~ s/\s*(.*?)\s*\n//;
    return $1 || '';
}

sub trim_block {
    my $self = shift;
    my $block = $self->block;
    $$block =~ s/^\s+\n//;
    $$block =~ s/\s+$/\n/;
}

sub get_next_block {
    my $self = shift;
    my $text = $self->input_buffer;
    $$text =~ s/
        (
            ^\#\#(?:\ |$).*\n           # Starting comment line
            (?:\#(?:\ |$).*\n)*         # more comment lines
            (?:\#\#\ *\n(?!\#))?        # trailing comment line
        )
        (?:\s*\n)?                      # blank lines
        (
            package\s.*\n               # package line
        |
            sub\s.*\}\s*\n              # one line sub
        |
            sub\s.*\n                   # subroutine
            (?:[^\}].*\n)*
            \}
        |
            (?:field|const)\s.*\n       # Class::Field definitions
        )?
    /$2/mx or return;
    $self->context($2 || '');
    my $block = $1;
    $block =~ s/^\#\#? ?//gm;
    $self->block(\$block);
    return 1;
}

sub fold_blocks {
    my $self = shift;
    my $text = $self->input_buffer;
    Perldoc::Fold->fold_blocks($text);
    Perldoc::Fold->unfold_comment_blocks($text);
}

1;
