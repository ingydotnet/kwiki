package Kwiki::Autoformat;
use strict;
use warnings;

use Kwiki::Plugin -Base;
use Kwiki::Installer -mixin;

our $VERSION = 0.03;

const class_title => 'Text autoformat';
const class_id => 'autoformat';

sub register {
    my $registry = shift;
    $registry->add(wafl => auto => 'Kwiki::Autoformat::Wafl');
    $registry->add(wafl => autoformat => 'Kwiki::Autoformat::Wafl');
}

package Kwiki::Autoformat::Wafl;
use base 'Spoon::Formatter::WaflBlock';

sub to_html {
    require Text::Autoformat;
    my $text = Text::Autoformat::autoformat($self->block_text);
    $text =~ s/\n+//s;
    return "<pre>$text</pre>";
}

package Kwiki::Autoformat;
