package Kwiki::Files::V2;
use Kwiki::Base -Base;
use mixin 'Kwiki::Installer';

const class_id => 'files';
const class_title => 'Kwiki Files';

__DATA__

__index.cgi__
#!/usr/bin/perl
use strict;
BEGIN {
    my $fh;
    for (qw(kwiki.env .ht-kwiki.env)) { open $fh, $_ and last }
    do { $ENV{$1} ||= $2 if /^(\w+)\s*=\s*['"]?(.*?)['"]?\s*$/ } for <$fh>;
}
use lib grep { -e } split /:/, $ENV{KWIKI_LIB_PATH} || 'lib';
use Kwiki::Boot;
Kwiki::Boot->debug->boot->kwiki->process;
