package Kwiki::Infobox;


use Kwiki::Plugin -Base;
our $VERSION = '0.03';

const class_id => 'infobox';
const class_title => 'Kwiki Infobox';

sub register {
    my $registry = shift;
    $registry->add(wafl => infoblock => 'Kwiki::Infobox::WaflBlock');
    $registry->add(wafl => infoblock_right => 'Kwiki::Infobox::WaflBlockRight');
    $registry->add(wafl => infobox => 'Kwiki::Infobox::WaflPhrase');
    $registry->add(wafl => infobox_right => 'Kwiki::Infobox::WaflPhraseRight');
}

sub html {
    my $content = $self->pages->current->content;
    my $html;
    while($content =~ /{infobox:\s*(.+)\s*}/g) {
	my $boxpage = $self->pages->new_page($1)->content;
	$html .= "<div class=\"infobox\">".
	    $self->hub->formatter->text_to_html($boxpage)
		. "</div>";
    }

    while($content =~ /\n.infoblock\n(.+\n).infoblock/sg) {
	$html .= "<div class=\"infoblock\">" .
	    $self->hub->formatter->text_to_html($1)
		. "</div>";
    }
    return $html;
}

sub left { $self->html(@_) };

sub right {
    my $content = $self->pages->current->content;
    my $html;
    my ($box) = $content =~ /{infobox_right:\s*(.+)\s*}/;
    if($box) {
	my $boxpage = $self->pages->new_page($box)->content;
	$html .= "<div class=\"infobox\">".
	    $self->hub->formatter->text_to_html($boxpage)
		. "</div>";
    }

    my ($block) = $content =~ /\n.infoblock_right\n(.+\n).infoblock/s;
    if($block) {
	$html .= "<div class=\"infoblock\">" .
	    $self->hub->formatter->text_to_html($block)
	    . "</div>";
    }
    return $html;
}

package Kwiki::Infobox::WaflPhrase;
use base 'Spoon::Formatter::WaflPhrase';
sub to_html {'';}

package Kwiki::Infobox::WaflPhraseRight;
use base 'Spoon::Formatter::WaflPhrase';
sub to_html {'';}

package Kwiki::Infobox::WaflBlock;
use base 'Spoon::Formatter::WaflBlock';
sub to_html {'';}

package Kwiki::Infobox::WaflBlockRight;
use base 'Spoon::Formatter::WaflBlock';
sub to_html {'';}
