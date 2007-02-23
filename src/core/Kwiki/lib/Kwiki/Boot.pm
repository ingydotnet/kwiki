package Kwiki::Boot;
use Kwiki::Base -Base;

sub boot {
    return $self->class->new;
}

sub class {
    my $type = $ENV{KWIKI_BOOT} || 'V1';
    my $class = "Kwiki::Boot::$type";
    eval "use $class";
    die $@ if $@;
    return $class;
}
