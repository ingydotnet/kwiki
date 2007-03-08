package Spoon::Headers;
use Spoon::Base -Base;

field status => '200 OK';
field content_type => 'text/html';
field charset => 'UTF-8';
field expires => 'now';
field pragma => 'no-cache';
field cache_control => 'no-cache';
field redirect => '';

sub print {
    my $headers = $self->get;
    $self->utf8_encode($headers);
    print $headers;
}

sub set_headers {
    my $headers = shift;
    for my $key (keys %$headers) {
        my $method = $key;
        $method =~ s/^-//;
        $method = 'content_type' if $method eq 'type';
        $self->$method($headers->{$key})
          if $self->can($method);
    }
}

sub get {
    $self->redirect
    ? CGI::redirect($self->redirect_value)
    : CGI::header($self->value);
}

sub redirect_value {                                                           
    (                                                                          
        $self->hub->cookie->set_cookie_headers,                                
        -location => $self->redirect,                                          
    );                                                                         
}                                                                              

sub value {
    (
        -status => $self->status,
        $self->hub->cookie->set_cookie_headers,
        -charset => $self->charset,
        -type => $self->content_type,
        -expires => $self->expires,
        -pragma => $self->pragma,
        -cache_control => $self->cache_control,
        -last_modified => $self->last_modified,
    );
}

sub last_modified {
    scalar gmtime;
}
