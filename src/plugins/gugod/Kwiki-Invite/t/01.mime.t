#!/usr/bin/perl
# -*- mode: cperl -*-

use strict;
use IO::All;
use Kwiki::Test;
use Test::More;
use Kwiki::Invite;

plan tests => 2;

my $kwiki = Kwiki::Test->new->init(['Kwiki::Invite']);

$kwiki->hub->invite->debug(1);
$kwiki->hub->invite->debug_io();
my $m = $kwiki->hub->invite->mail_it("he\@blah.com","she\@blah.com","Invite You","Just come\nhere.");

ok($m->as_string);

$m = $kwiki->hub->invite->post;
ok($m->as_string);

print $m->as_string;

$kwiki->cleanup;
