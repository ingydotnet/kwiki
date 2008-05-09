#!/usr/bin/perl

use pQuery;

PQUERY(map "http://search.cpan.org/~$_/", qw(ingy gugod cdent))
    ->find("table:eq(1) tr")
#     ->eq(1)
#     ->find("tr")
    ->EACH(sub{
        my $i = shift;
        print($i + 1, ") ", $_->length - 1, "\n")
    });
