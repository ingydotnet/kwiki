use t::TestDocumentTools tests => 1;

use Document::Parser::Creole;
use Document::Viewer::HTML;;

# no_diff;
spec_file 't/lists.data';

filters {
    creole => 'parse_creole',
};

sub parse_creole {
    my $parser = Document::Parser::Creole->new(
        receiver => Document::Viewer::HTML->new,
    );
    $parser->parse($_);
}

run_is creole => 'html';
