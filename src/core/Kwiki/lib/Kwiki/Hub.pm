package Kwiki::Hub;
use Spoon::Hub -Base;

sub action {
    $self->cgi->action || 
    ($self->config->can('default_action') && $self->config->default_action) ||
    'display';
}

sub unknown_action {
    my $action = shift;
    return $self->headers->redirect($self->unknown_action_url);
}

sub unknown_action_url {
    return $self->config->{unknown_action_url} || 'index.cgi?404';
}
