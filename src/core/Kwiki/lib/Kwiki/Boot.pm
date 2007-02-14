package Kwiki::Boot;
use Kwiki::Base -Base;

field 'config';
field 'kwiki';

sub new {
    $self = $self->SUPER::new(@_);
    $self->init();
    return $self;
}

sub init {
    for my $type (qw(main config hub)) {
        my $method = "${type}_class";
        my $class = $self->$method;
        eval "use $class; 1" or die $@;
    }

    my $config = $self->config_class->new(@_);
    $self->config($config);

    my $hub = $self->hub_class->new;

    my $main = $self->main_class->new;
    $hub->main($main);
    $hub->config($config);

    $self->kwiki($main);
}

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
