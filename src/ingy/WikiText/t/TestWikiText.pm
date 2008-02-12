package t::TestWikiText;
use Test::Base -Base;

use WikiText::Sample::Parser;
use WikiText::HTML::Emitter;
use WikiText::WikiByte::Emitter;

package t::TestWikiText::Filter;
use Test::Base::Filter -base;

sub parse_sample_html {
    my $parser = WikiText::Sample::Parser->new(
        receiver => WikiText::HTML::Emitter->new,
    );
    $parser->parse(shift);
}

sub parse_sample_wikibyte {
    my $parser = WikiText::Sample::Parser->new(
        receiver => WikiText::WikiByte::Emitter->new,
    );
    $parser->parse(shift);
}

