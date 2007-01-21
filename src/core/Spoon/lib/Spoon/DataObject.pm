package Spoon::DataObject;
use Spoon::Base -Base;

stub 'class_id';
field 'id';

sub name {
    $self->{name} = shift if @_;
    return $self->{name} if defined $self->name;
    $self->{name} = $self->uri_unescape($self->id);
}
