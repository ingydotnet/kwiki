package Kwiki::Users;
use Kwiki::Base -Base;
use mixin 'Kwiki::Installer';

const class_id => 'users';
const class_title => 'Kwiki Users';
const user_class => 'Kwiki::User';

sub init {
    $self->hub->config->add_file('user.yaml');
}

sub all {
    ($self->current);
}

sub all_ids {
    ($self->current->id);
}

#XXX This can be a `field ... -init ...`
sub current {
    return $self->{current} = shift if @_;
    return $self->{current} if defined $self->{current};
    my $user_id = $ENV{REMOTE_USER} || '';
    $self->{current} = $self->new_user($user_id);
}

sub new_user {
    $self->user_class->new(id => shift);
}

package Kwiki::User;
use base 'Kwiki::Base';
                  
field 'id';
field 'name' => '';
        
sub new {
    $self = $self->SUPER::new(@_);
    $self->set_user_name;
    return $self;
}

sub set_user_name {
    return unless $self->is_in_cgi;
    my $name = '';
    $name = $self->preferences->user_name->value
      if $self->preferences->can('user_name');
    $name ||= $self->hub->config->user_default_name;
    $self->name($name);
}

sub preferences {
    return $self->{preferences} = shift if @_;
    return $self->{preferences} if defined $self->{preferences};
    my $preferences = $self->hub->preferences;
    $self->{preferences} =
      $preferences->new_preferences($self->preference_values);
}

sub preference_values { 
    $self->hub->cookie->jar->{preferences} || {};
}

package Kwiki::Users;
__DATA__


__config/user.yaml__
user_default_name: AnonymousGnome
