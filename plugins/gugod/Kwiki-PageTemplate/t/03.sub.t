#!/usr/bin/perl
use strict;
use warnings;
use Kwiki::PageTemplate;
use Test::More qw(no_plan);

# Test independent codes

### extract_display_block
my $display_block = Kwiki::PageTemplate->extract_display_block(qq{
.page_template_display
Random 
.page_template_display
});

like($display_block,qr/Random/,"extract_display_block");

### extract_fields
my $fields = Kwiki::PageTemplate->extract_fields(qq{
.page_template_fields
name: text
address: text
.page_template_fields
});

is_deeply($fields,{name => 'text', address => 'text'}, "extract_fields");

