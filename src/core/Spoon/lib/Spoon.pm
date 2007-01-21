package Spoon;
use Spoon::Base -Base;
our $VERSION = '0.24';

const class_id => 'main';

sub load_hub {
    $self->destroy_hub;
    my $hub = $self->hub(@_);
    $hub->main($self);
    $self->init;
    return $hub;
}
