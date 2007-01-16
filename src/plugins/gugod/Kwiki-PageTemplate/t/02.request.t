#!/usr/bin/perl
use strict;
use warnings;
use Cwd;
use IO::All;
use Kwiki;
use Kwiki::Test;
use IO::Capture::Stdout;
use Test::More skip_all => 'Kwiki::Test wants more features for this';

my $kwiki = Kwiki::Test->new->init(['Kwiki::PageTemplate']);

io->catfile("database","SandBox")->assert->print("
.page_template_fields
name: text
.page_template_fields
.page_template
Name: {field:name}
.page_template
");

$kwiki->request("/?SandBox");

$kwiki->cleanup;


__DATA__

