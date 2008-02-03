package t::TestDocumentTools;
use Test::Base -Base;

use WikiText::Creole::Parser;
use Document::Emitter::HTML;
use Document::Emitter::WikiByte;


package t::TestDocumentTools::Filter;
use Test::Base::Filter -base;

sub parse_creole_html {
    my $parser = WikiText::Creole::Parser->new(
        receiver => Document::Emitter::HTML->new,
    );
    $parser->parse(shift);
}

sub parse_creole_wikibyte {
    my $parser = WikiText::Creole::Parser->new(
        receiver => Document::Emitter::WikiByte->new,
    );
    $parser->parse(shift);
}

