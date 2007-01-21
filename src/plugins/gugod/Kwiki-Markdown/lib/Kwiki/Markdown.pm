package Kwiki::Markdown;
use v5.6.1;
use Text::Markdown 'markdown';
our $VERSION = '0.01';

use constant
    class_id     => 'formatter',
    class_title  => 'Kwiki Markdown Formatter';

sub new { bless {} }
sub init {}

sub text_to_html {
    my $self = shift;
    return markdown(shift);
}
