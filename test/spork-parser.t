#!/usr/bin/perl
use strict;
use lib 'lib';
use Spork::Parser;
use Spork::Emitter::HTML;
use XXX;

my $text = do {local $/; <DATA>};
my $ast = Spork::Parser->new->parse($text);
my $html = Spork::Emitter::HTML->new->emit($ast);
print $html;

__END__
== This is a test

* foo
** 123
* *hello*

Cool *stuff* is /here/.

    sub foo {
       ...
    }
