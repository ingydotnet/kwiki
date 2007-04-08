package Spork::Formatter::Kwid;
use Spork::Formatter -Base;

sub formatter_classes {
    (
        (
            map { 
                s/^Spork::Formatter::Inline$/Spork::Formatter::Kwid::Inline/;
                $_; 
            } super
        ),
    );
}  

const all_phrases => [qw(wafl_phrase asis strong em u tt hyper)];

################################################################################
package Spork::Formatter::Kwid::Inline;
use base 'Spork::Formatter::Inline';
use Kwiki ':char_classes';
const formatter_id => 'tt';
const pattern_start => qr/(^|(?<=[^$ALPHANUM]))\`/;
const pattern_end => qr/\`(?=[^$ALPHANUM]|\z)/;

__DATA__

=head1 NAME

Spork::Formatter::Kwid - Kwid Formatter for Spork

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Brian Ingerson <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
