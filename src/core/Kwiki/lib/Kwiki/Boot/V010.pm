package Kwiki::Boot::V010;
use Kwiki::Boot -Base;

const main_class => 'Kwiki';
const config_class => 'Kwiki::Config';
const hub_class => 'Kwiki::Hub';

sub init {
    $self->SUPER::init('config*.*');
    $self->add_configs_files;
    $self->add_plugins_files;
}

sub add_configs_files {
    $self->config->add_path('config');
    $self->config->add_file('config.yaml');
}

sub add_plugins_files {
    $self->config->add_plugins_file('plugins');
}
