package Spork::Formatter2;
use Spoon::Base -Base;
use Spork::Parser;
use Spork::Emitter::HTML;
use XXX;

sub text_to_html {
    my $text = shift;
    my $ast = Spork::Parser->new->parse($text);
    return Spork::Emitter::HTML->new->emit($ast);
}
