package Kwiki::AnchorLink;
use Kwiki::Plugin -Base;
our $VERSION = '0.03';

const class_id => 'anchor_link';
const class_title => 'Anchor Link';

sub register {
    my $registry = shift;
    $registry->add(wafl => anchor => 'Kwiki::AnchorLink::Point');
    $registry->add(wafl => anchorlink => 'Kwiki::AnchorLink::Ref');
}


package Kwiki::AnchorLink::Ref;
use base 'Spoon::Formatter::WaflPhrase';

sub to_html {
    my ($anchor,$title) = split(/\s+/,$self->arguments,2);
    $title ||= $anchor;
    return qq{<a href="#$anchor">$title</a>};
}

package Kwiki::AnchorLink::Point;
use base 'Spoon::Formatter::WaflPhrase';

sub to_html {
    my $anchor_name = $self->arguments;
    return qq{<a name="$anchor_name"></a>};
}
