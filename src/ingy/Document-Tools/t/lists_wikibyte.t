use t::TestDocumentTools tests => 2;

use Document::Parser::Creole;
use Document::AST::WikiByte;

# no_diff;
spec_file 't/lists.data';

filters {
    creole => 'parse_creole',
};

sub parse_creole {
    my $parser = Document::Parser::Creole->new(
        receiver => Document::AST::WikiByte->new,
    );
    $parser->parse($_);
}

run_is creole => 'wikibyte';
