package t::TestDocumentTools;
use Test::Base -Base;

use Document::Parser::Creole;
use Document::Viewer::HTML;
use Document::AST::WikiByte;


package t::TestDocumentTools::Filter;
use Test::Base::Filter -base;

sub parse_creole_html {
    my $parser = Document::Parser::Creole->new(
        receiver => Document::Viewer::HTML->new,
    );
    $parser->parse(shift);
}

sub parse_creole_wikibyte {
    my $parser = Document::Parser::Creole->new(
        receiver => Document::AST::WikiByte->new,
    );
    $parser->parse(shift);
}

