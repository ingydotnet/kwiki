package Kwiki::Users::OpenID;
use strict;

our $VERSION = '0.02';

use Kwiki::Users '-Base';

const class_id    => 'users';
const class_title => 'Kwiki users from OpenID authentication';
const user_class  => 'Kwiki::User::OpenID';

sub init {
    $self->hub->config->add_file('openid.yaml');
    return unless $self->is_in_cgi;
    io($self->plugin_directory)->mkdir;
}

sub current {
    return $self->{current} = shift if @_;
    return $self->{current} if defined $self->{current};
    $self->{current} = $self->new_user();
}

sub new_user {
    $self->user_class->new();
}

package Kwiki::User::OpenID;
use base qw(Kwiki::User);

field 'oi_url';
field 'page';
field 'url';
field 'icon';
field 'fn';
field 'name';
field 'email';
field 'nickname';

sub set_user_name {
    return unless $self->is_in_cgi;
    my $cookie = $self->hub->cookie->jar->{openid};
    unless($cookie && $cookie->{oi_url}) {
        $self->name($self->hub->config->user_default_name);
        # without authentication...
        return;
    }
    for my $key (qw/oi_url url icon name email nickname fn/) {
        $self->$key($cookie->{$key});
    }
}

package Kwiki::Users::OpenID;

1;

__DATA__

__config/openid.yaml__
script_name: http://localhost/index.cgi
