package Kwiki::ColumnBlocks;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-Base';
our $VERSION = '0.01';

const class_id => 'column_blocks';
const class_title => 'Column Blocks';
const css_file => 'column_blocks.css';

sub register {
    my $registry = shift;
    $registry->add(wafl => columns => 'Kwiki::ColumnBlocks::WaflBlock');
    $registry->add(wafl => column => 'Kwiki::Columns::WaflBlock');
}

package Kwiki::ColumnBlocks::WaflBlock;
use base 'Spoon::Formatter::WaflBlock';

const contains_blocks => [qw(wafl_block)];

sub to_html {
    return join '',
      qq{<table class="columns_mode"><tr class="columns_mode">\n},
      map({$_->to_html}
          grep({ref $_ and $_->method eq "column"} @{$self->units})),
      qq{</tr></table>\n};
}


package Kwiki::Columns::WaflBlock;
use base 'Spoon::Formatter::WaflBlock';

sub contains_blocks {
    $self->hub->formatter->all_blocks;
}

sub to_html {
    return join '',
      qq{<td valign="top" class="columns_mode">\n},
      map({ref $_?$_->to_html:$_} @{$self->units}),
      qq{</td>\n};
}

1;

package Kwiki::ColumnBlocks;
__DATA__
