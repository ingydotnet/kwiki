package Kwiki::HtmlBlocks;
use Kwiki::Plugin -Base;
our $VERSION = '0.11';

const class_id => 'html_blocks';

sub register {
    my $registry = shift;
    $registry->add(wafl => html => 'Kwiki::HtmlBlocks::Wafl');
}

package Kwiki::HtmlBlocks::Wafl;
use base 'Spoon::Formatter::WaflBlock';

sub to_html {
    $self->block_text;
}
