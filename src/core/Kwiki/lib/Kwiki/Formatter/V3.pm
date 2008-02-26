package Kwiki::Formatter::V3;
use Spoon::Base -Base;
use WikiText::Creole::Parser;
use WikiText::HTML::Emitter;

const class_id  => 'formatter';
const class_title => 'Kwiki Formatter';

sub text_to_html {
    my $text = shift;

    my $callbacks = {
        wikilink =>
        sub {
            my $context = shift;
            my $page_id = $context->{attributes}{target};
            my $page = $self->hub->pages->new_from_name($page_id);
            $context->{attributes}{class} = 
                $page->exists ? "" : "empty";
            return '?' . $page_id;
        }
    };

    my $parser = WikiText::Creole::Parser->new(
        receiver => WikiText::HTML::Emitter->new(
            callbacks => $callbacks,
        ),
    );
    return $parser->parse($text);
}
