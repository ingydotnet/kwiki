package Kwiki::Textile;
use v5.6.1;
use Text::Textile 'textile';
our $VERSION = '0.01';

use constant
    class_id     => 'formatter',
    class_title  => 'Kwiki Textile Formatter';

sub new { bless {} }
sub init {}

sub text_to_html {
    my $self = shift;
    return textile(shift);
}
