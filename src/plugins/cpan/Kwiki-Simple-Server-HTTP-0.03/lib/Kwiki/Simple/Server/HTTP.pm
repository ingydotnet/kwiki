package Kwiki::Simple::Server::HTTP;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
use HTTP::Server::Simple::Kwiki;
our $VERSION = '0.03';

const class_id => 'simple_server_http';
const config_file => 'simple_server_http.yaml';

sub register {
    my $register = shift;
    $register->add(command => 'start',
                   description => 'Start a stand-alone kwiki http server');
}

sub handle_start {
    my $port = shift || $self->hub->config->simple_server_http_port;
    $self->destroy_hub;
    my $server = HTTP::Server::Simple::Kwiki->new($port);
#     $server->background();
#     warn $$, "\n";
    $server->run();
}

__DATA__


__config/simple_server_http.yaml__
simple_server_http_port: 8080
