package Kwiki::PreformattedBlocks;
use Kwiki::Plugin -Base;
our $VERSION = '0.11';

const class_id => 'preformatted_blocks';

sub register {
    my $registry = shift;
    $registry->add(wafl => pre => 'Kwiki::PreformattedBlocks::Wafl');
}

package Kwiki::PreformattedBlocks::Wafl;
use base 'Spoon::Formatter::WaflBlock';

sub to_html {
    join '',
      qq{<pre class="formatter_pre">\n},
      $self->block_text,
      "</pre>\n";
}
