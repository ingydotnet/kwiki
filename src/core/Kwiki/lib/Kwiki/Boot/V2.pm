package Kwiki::Boot::V2;
use Kwiki::Boot::Base -Base;

const main_class => 'Kwiki';
const config_class => 'Kwiki::Config';
const hub_class => 'Kwiki::Hub';

sub init {
    $self->add_default_classes;
    $self->add_configs_files;
    $self->add_plugins_files;
}

sub add_configs_files {
    # TODO Get all config locations from hub->paths
    $self->config->add_path('config');
    $self->config->add_file('config.yaml');
}

sub add_plugins_files {
    # TODO Get all plugins files from hub->paths
    $self->config->add_plugins_file('plugins');
}

sub add_default_classes {
    my $default = {
        cgi_class => 'Kwiki::CGI',
        command_class => 'Kwiki::Command::V2',
        cookie_class => 'Kwiki::Cookie',
        css_class => 'Kwiki::CSS',
        formatter_class => 'Kwiki::Formatter',
        headers_class => 'Spoon::Headers',
        hooks_class => 'Spoon::Hooks',
        javascript_class => 'Kwiki::Javascript',
        pages_class => 'Kwiki::Pages',
        paths_class => 'Kwiki::Paths::V2',
        preferences_class => 'Kwiki::Preferences',
        registry_class => 'Kwiki::Registry',
        template_class => 'Kwiki::Template::TT2',
        users_class => 'Kwiki::Users',
    };
    $self->SUPER::add_default_classes($default);
}
