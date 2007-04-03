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

.center
* foo
** 123
* *hello*
.center

Cool *stuff* is /here/.

xxx
xxx
  yyy
  yyy
xxx

    sub foo {
       ...
    }
