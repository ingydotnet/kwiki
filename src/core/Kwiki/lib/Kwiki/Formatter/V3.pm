package Kwiki::Formatter::V3;
use Spoon::Base -Base;
use WikiText::Creole::Parser;
use Document::Emitter::HTML;

const class_id  => 'formatter';
const class_title => 'Kwiki Formatter';

sub text_to_html {
    my $text = shift;

    my $callbacks = {
        wikilink =>
        sub {
            my $context = shift;
            return '?' . $context->{attributes}{target};
        }
    };

    my $parser = WikiText::Creole::Parser->new(
        receiver => Document::Emitter::HTML->new(
            callbacks => $callbacks,
        ),
    );
    return $parser->parse($text);
}
