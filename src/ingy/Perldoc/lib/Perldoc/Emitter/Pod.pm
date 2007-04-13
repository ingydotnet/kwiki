package Perldoc::Emitter::Pod;
use strict;
use warnings;
use Perldoc::Base -base;

sub emit {
    my $self = shift;
    my $ast = shift;
    my $output = '';
    for my $node (@$ast) {
        if (ref $node) {
            my ($key, $value) = @$node;
            my $func = "handle_$key";
            $output .= $self->$func($value);
        }
        else {
            $output .= $node;
        }
    }
    return $output;
}

sub handle_top {
    require Perldoc;
    my $self = shift;
    my $inner = $self->emit(shift);
    return <<"...";
=for perldoc
This POD generated by Perldoc-$Perldoc::VERSION.
DO NOT EDIT. Your changes will be lost.

$inner=cut
...
}

sub handle_h1 {
    my $self = shift;
    my $inner = $self->emit(shift);
    return "=head1 $inner\n\n"
}

sub handle_p {
    my $self = shift;
    my $inner = $self->emit(shift);
    return "$inner\n\n"
}

sub handle_pre {
    my $self = shift;
    my $array = shift;
    my $text = shift @$array;
    $text =~ s/^/    /gm;
    return "$text\n"
}

1;
