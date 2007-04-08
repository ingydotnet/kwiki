package Perldoc::Emitter::Pod;
use strict;
use warnings;
use Perldoc::Base;
use base 'Perldoc::Base';

my $prev_text;

field 'document';

sub begins {
    my $self = shift;
    my $tag = shift;
    $tag =~ s/ .*//;
    my $output = 
        $tag eq 'comment' ? "<!--\n" :
        $tag eq 'a'       ? '<a href="' :
                            "<$tag>\n";
    $self->document->write($output);
    undef $prev_text;
}

sub ends {
    my $self = shift;
    my $tag = shift;
    my $output = '';
    if ($tag eq 'comment') {
        $output .= "-->\n";
    }
    elsif ($tag =~ /a (.*)/) {
        $output .= $1 unless defined $prev_text;
        $output .= '">';
        $output .= (length($1) ? $1 : $prev_text);
        $output .= '</a>';
    }
    else {
        $output .= "</$tag>\n"
    }
    $self->document->write($output);
}

sub text {
    my $self = shift;
    my $output = shift;
    $output =~ s/\\(.)/$1/g;
    decode_entities($output);
    encode_entities($output, '<>&"');
    $prev_text = $output;
    $output .= "\n";
    $self->document->write($output);
}

=head1 NAME

Perldoc::Emitter::Pod - Pod Emitter for Perldoc

=head1 SYNOPSIS

    package Perldoc::Emitter::Pod;

=head1 DESCRIPTION

This class receives Perldoc events and produces Pod.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

Audrey wrote the original code for this parser.

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
