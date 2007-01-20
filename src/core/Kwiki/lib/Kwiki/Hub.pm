package Kwiki::Hub;
use Spoon::Hub -Base;

sub action {
    $self->cgi->action || 
    ($self->config->can('default_action') && $self->config->default_action) ||
    'display';
}
