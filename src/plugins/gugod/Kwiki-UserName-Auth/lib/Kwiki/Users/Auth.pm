package Kwiki::Users::Auth;
use Kwiki::Users -Base;
our $VERSION = "0.02";

const class_id => 'users';
const class_title => 'Kwiki users registered online';
const user_class => 'Kwiki::User::Auth';

package Kwiki::User::Auth;
use base 'Kwiki::User';

field 'name';
field 'email';

sub set_user_name {
    return unless $self->is_in_cgi;
    my $users = $self->hub->session->load->param("users_auth");
    $users && $users->{name} or return;
    $self->name($self->utf8_decode($users->{name}));
    $self->email($self->utf8_decode($users->{email}));
}

package Kwiki::Users::Auth;
