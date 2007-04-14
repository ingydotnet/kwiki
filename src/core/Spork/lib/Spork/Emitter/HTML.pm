package Spork::Emitter::HTML;
use strict;
use XXX;

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
    '+tt' => "<tt>", 
    '-tt' => "</tt>", 
    '+center' => qq{<div class="center-outer"><div class="center-inner">\n},
    '-center' => "</div></div>\n",
    '+indent' => "<blockquote>\n",
    '-indent' => "</blockquote>\n",
    '+hilite' => qq{<span class="hilite">},
    '-hilite' => "</span>",
    '+color' => qq{<pre>},
    '-color' => "</pre>",
);

sub emit {
    my $self = shift;
    my $ast = shift;
    for my $node (@$ast) {
        if (ref $node) {
            my ($key, $value) = @$node;
            $self->{output} .= $tags{"+$key"} || '';
            my $func = "handle_$key";
            if ($self->can($func)) {
                $self->$func($value);
            }
            else {
                $self->emit($value);
            }
            $self->{output} .= $tags{"-$key"} || '';
            next;
        }
        my $text = $node;
        $text =~ s/^(  +)/"&nbsp;" x length($1)/gem;
        $text =~ s/\n/<br \/>\n/g;
        $self->{output} .= $text;
    }
    return $self->{output};
}

sub handle_pre {
    my $self = shift;
    my $node = shift;
    my $text = $node->[0];
    $text =~ s/</&lt;/g;
    $self->{output} .= $text;
}

sub handle_color {
    require Spork::Hilite;
    my $self = shift;
    my $node = shift;
    my $text = $node->[0];

    my $hilite = Spork::Hilite::Wafl->new;
    $hilite->text($text);
    my $html = $hilite->to_html;
    
    $self->{output} .= $html;
}

1;
