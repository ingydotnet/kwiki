package Perldoc::Emitter::HTML;
use strict;
use warnings;
use Perldoc::Base;
use base 'Perldoc::Base';

use HTML::Entities;
my $prev_text;
my $li_level = 0;

field 'document';

my $tag_map = {
    top  => 'body',
    item => 'li',
    para => 'p',
    bold => 'b',
    italic => 'i',
};

sub begin {
    my $self = shift;
    my $type = shift;
    my $tag = $tag_map->{$type} || $type;
    $tag =~ s/ .*//;
    if ($tag =~ s/^li(\d+)/li/) {
        $self->emit_li($1 - $li_level) if $li_level or $1;
        $li_level = $1;
        undef $prev_text;
        return;
    }

    my $output = 
        $tag eq 'comment' ? "<!--\n" :
        $tag eq 'a'       ? '<a href="' :
                            "<$tag>\n";
    $self->document->write($output);
    undef $prev_text;
}

sub end {
    my $self = shift;
    my $type = shift;
    my $tag = $tag_map->{$type} || $type;
    my $output = '';
    if ($tag eq 'comment') {
        $output .= "-->\n";
    }
    elsif ($tag =~ /a (.*)/) {
        no warnings 'uninitialized';
        $output .= $1 unless defined $prev_text;
        $output .= '">';
        $output .= (length($1) ? $1 : $prev_text);
        $output .= '</a>';
    }
    elsif ($tag eq 'p') {
        $self->document->write("</li></ul>\n") for 1..$li_level;
        $li_level = 0;
    }
    elsif ($tag !~ /^li\d+/) {
        $output .= "</$tag>\n"
    }
    $self->document->write($output);
}

sub text {
    my $self = shift;
    my $output = shift;
    $output =~ s/\\(\W)/$1/g;
    decode_entities($output);
    encode_entities($output, '<>&"');
    $prev_text = $output;
    $self->document->write($output);
}

sub emit_li {
    my $self = shift;
    my $level = shift;
    if ($level <= 0) {
        $self->document->write("</li></ul>\n") for $level..-1;
        $self->document->write("</li><li>\n");
    }
    else {
        $self->document->write("<ul><li>\n") for 1..$level;
    }
}

=head1 NAME

Perldoc::Emitter::HTML - HTML Emitter for Perldoc

=head1 SYNOPSIS

    package Perldoc::Emitter::HTML;

=head1 DESCRIPTION

This class receives Perldoc events and produces HTML.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

Audrey wrote the original code for this parser.

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
