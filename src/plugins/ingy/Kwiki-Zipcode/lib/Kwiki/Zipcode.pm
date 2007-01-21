package Kwiki::Zipcode;
use Kwiki::Plugin -Base;
our $VERSION = '0.12';

const class_id => 'zipcode';

sub register {
    my $registry = shift;
    $registry->add(preference => $self->zipcode);
    $registry->add(prerequisite => 'user_preferences');
}

sub zipcode {
    my $p = $self->new_preference('zipcode');
    $p->query('Enter your zipcode.');
    $p->type('input');
    $p->size(5);
    $p->edit('check_zipcode');
    $p->default('');
    return $p;
}

sub check_zipcode {
    my $preference = shift;
    my $value = $preference->new_value;
    return unless length $value;
    $preference->error('Invalid. Must be 5 digits.')
      unless $value =~ /^\d{5}$/;
}
