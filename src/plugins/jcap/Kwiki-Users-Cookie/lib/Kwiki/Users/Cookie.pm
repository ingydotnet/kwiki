package Kwiki::Users::Cookie;
use Kwiki::Users -Base;

our $VERSION = "0.01";

const class_title => 'Kwiki users from Cookie lookup';
const user_class => 'Kwiki::User::Cookie';

sub init {
	$self->hub->config->add_file('user_cookie.yaml');
}

package Kwiki::User::Cookie;
use base 'Kwiki::User';
                   
field 'name' => '';
field 'id';

sub process_cookie {
		return shift;
}

sub fetch_user_name_from_cookie { 
		my $cookie_name = shift;
		my $cookie_value = CGI::cookie($cookie_name);
		$cookie_value = $self->process_cookie($cookie_value);
		return $cookie_value;
}

sub set_user_name {
    return unless $self->is_in_cgi;
		
		my $cookie_name = $self->hub->config->user_cookie_name;
		$cookie_name ||= $self->hub->config->user_cookie_default_name;
    
		my $name = '';
    $name = $self->fetch_user_name_from_cookie($cookie_name);
    
		$name ||= $self->hub->config->user_default_name;
    $self->name($name);
}


package Kwiki::Users::Cookie;    
__DATA__


__config/user_cookie.yaml__
user_default_cookie_name: username 
user_default_name: AnonymousGnome
