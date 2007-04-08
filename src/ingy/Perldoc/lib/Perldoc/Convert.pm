package Perldoc::Convert;
use strict;
use warnings;
use base 'Perldoc::Base';
use Perldoc;

sub kwid_to_html {
    my $class = shift;
    my $doc = Perldoc->new(@_);
    $doc->to_html;
}

1;
