use t::TestYAML;

use YAML2::Parser;
use t::TestParserReceiver;

my $parser = YAML2::Parser->new(
    receiver => t::TestParserReceiver->new(),
);

delimiters '===', '+++';
plan tests => 1;

filters {
    yaml => 'parse_yaml_to_events',
};

run_is yaml => 'events';

sub parse_yaml_to_events {
    $parser->parse($_);
}

__DATA__

=== Scalar
+++ yaml
--- 42

+++ events
stream_start
document_start
scalar 42
document_end
stream_end
