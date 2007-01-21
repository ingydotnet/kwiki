package Kwiki::ParagraphBlocks;
use Kwiki::Plugin -Base;
our $VERSION = '0.12';

const class_id => 'paragraph_blocks';
const class_title => 'Paragraph Blocks';

sub register {
    my $registry = shift;
    $registry->add(wafl => p => 'Kwiki::ParagraphBlocks::Wafl');
}

package Kwiki::ParagraphBlocks::Wafl;
use base 'Spoon::Formatter::WaflBlock';

sub to_html {
    my $block = Kwiki::Formatter::Paragraph->new(
        hub => $self->hub, 
        text => $self->block_text,
    );
    $block->parse_phrases;
    my $html = $block->to_html;
    $html =~ s/.*?<p.*?>\n?(.*)<\/p>.*/$1/s;
    $html =~ s/\n/<br \/>\n/g;
    $html =~ s/^( +)/'&nbsp;' x length($1)/gem;
    return "<p>\n$html</p>";
}
