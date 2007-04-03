package Spork::Emitter::HTML;
use strict;
# use XXX;

sub new { bless { output => '' }, shift }

my %tags = (
    '+h2' => "<h2>", 
    '-h2' => "</h2>\n", 
    '+ul' => "<ul>\n", 
    '-ul' => "</ul>\n", 
    '+li' => "<li>", 
    '-li' => "</li>\n", 
    '+p' => "<p>", 
    '-p' => "</p>\n", 
    '+pre' => "<pre>\n", 
    '-pre' => "</pre>\n", 
    '+b' => "<b>", 
    '-b' => "</b>", 
    '+i' => "<i>", 
    '-i' => "</i>", 
);

sub emit {
    my $self = shift;
    my $ast = shift;
    for my $node (@$ast) {
        if (ref $node) {
            my ($key) = keys %$node;
            print $tags{"+$key"};
            $self->emit($node->{$key});
            print $tags{"-$key"};
            next;
        }
        print $node;
    }
    return $self->{output};
}


1;
