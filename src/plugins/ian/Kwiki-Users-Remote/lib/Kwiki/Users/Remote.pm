package Kwiki::Users::Remote;
use strict;
use warnings;

use Kwiki::Users -Base;

our $VERSION = "0.04";

const class_title => 'Kwiki users from HTTP authentication';
const user_class  => 'Kwiki::User::Remote';

package Kwiki::User::Remote;
use base 'Kwiki::User';

sub name {
    exists $ENV{REMOTE_USER}
        ? $ENV{REMOTE_USER}
        : $self->hub->config->user_default_name;
}

sub id {
    exists $ENV{REMOTE_USER}
        ? $ENV{REMOTE_USER}
        : $self->hub->config->user_default_name;
}
