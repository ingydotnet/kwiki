package Kwiki::Boot::V010;
use Kwiki::Boot -Base;

const main_class => 'Kwiki';
const config_class => 'Kwiki::Config';
const hub_class => 'Kwiki::Hub';

sub init {
    $self->SUPER::init('config*.*');
    $self->add_default_classes;
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

sub add_default_classes {
    $self->config->add_config({
        cgi_class => 'Kwiki::CGI',
        command_class => 'Kwiki::Command',
        config_class => 'Kwiki::Config',
        cookie_class => 'Kwiki::Cookie',
        css_class => 'Kwiki::CSS',
        files_class => 'Kwiki::Files',
        formatter_class => 'Kwiki::Formatter',
        headers_class => 'Spoon::Headers',
        hooks_class => 'Spoon::Hooks',
        hub_class => 'Kwiki::Hub',
        javascript_class => 'Kwiki::Javascript',
        pages_class => 'Kwiki::Pages',
        preferences_class => 'Kwiki::Preferences',
        registry_class => 'Kwiki::Registry',
        template_class => 'Kwiki::Template::TT2',
        users_class => 'Kwiki::Users',
    });
}

