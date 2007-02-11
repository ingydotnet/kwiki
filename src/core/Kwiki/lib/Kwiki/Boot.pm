package Kwiki::Boot;
use Kwiki::Base -Base;

field 'config';
field 'kwiki';

sub new {
    $self = $self->SUPER::new(@_);
    $self->init();
    return $self;
}

sub class {
    my $class = 'Kwiki::Boot::V010';
    eval "use $class";
    die $@ if $@;
    return $class;
}
