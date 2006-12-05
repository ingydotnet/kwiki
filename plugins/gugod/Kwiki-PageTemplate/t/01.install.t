#!/usr/bin/perl
use strict;
use warnings;
use Kwiki::Test;
use Test::More tests => 1;

my $kwiki = Kwiki::Test->new->init(['Kwiki::PageTemplate']);
ok($kwiki->exists_as_file('config/page_template.yaml'), "configuration file installed");
$kwiki->cleanup;

