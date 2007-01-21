package Kwiki::PageInclude;
use Kwiki::Plugin -Base;
our $VERSION = '0.02';

const class_id => 'page_include';
const class_title => 'Include Other Page';

sub register {
    my $reg = shift;
    $reg->add(wafl => include => 'Kwiki::PageInclude::WaflPhrase');
}

package Kwiki::PageInclude::WaflPhrase; 
use base 'Spoon::Formatter::WaflPhrase';

sub to_html {
    my @args = split(/[\s,]+/,$self->arguments);
    my $ret;
    for(@args) {
        my $page = $self->hub->pages->new_from_name($_);
        $ret .= $self->hub->formatter->text_to_html($page->content);
    }
    return $ret;
}
