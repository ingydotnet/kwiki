package Kwiki::Email;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Email::Valid;
our $VERSION = '0.02';

const class_id => 'email';

sub register {
    my $registry = shift;
    $registry->add(
		preference => 'email',
        object => $self->email,
    );
}

sub email {
    my $p = $self->new_preference('email');
    $p->query('Enter your email address.');
    $p->type('input');
    $p->size(30);
    $p->edit('check_email');
    $p->default('');
    return $p;
}

sub check_email {
    my $preference = shift;
    my $value      = $preference->new_value;
    return unless length $value;
    $preference->error('Invalid Email Adress.')
      unless Email::Valid->address($value);
}

1;
