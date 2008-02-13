use strict;
use warnings;
use lib 'lib', '../WikiText/lib';
use Test::More tests => 1;

use WikiText::Socialtext;

my $wikitext = <<'...';
^ Hello

World.
...

my $html = <<'...';
<h1>Hello</h1>
<p>World.</p>
...

my $output = WikiText::Socialtext->new($wikitext)->to_html;

is $output, $html, 'to_html works';
