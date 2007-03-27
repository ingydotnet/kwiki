package Spork::Boot;
use Spoon::Base -Base;

sub boot {
    return $self->class->new;
}

sub class {
    my $type = $ENV{SPORK_BOOT} || 'V1';
    my $class = "Spork::Boot::$type";
    eval "use $class";
    die $@ if $@;
    return $class;
}
