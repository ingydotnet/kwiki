package Kwiki::Boot::V3;
use Spoon::Boot::Base -Base;

const main_class => 'Kwiki';
const config_class => 'Kwiki::Config';
const hub_class => 'Kwiki::Hub';

sub kwiki { $self->main(@_) }

sub add_configs_files {
    # TODO Get all config locations from hub->paths
    $self->config->add_file('config.yaml');
    my $config = $ENV{KWIKI_LOCAL_CONFIG_LOCATION};
    $self->config->add_config($config, 1)
        if $config and -f $config;
}

sub add_default_classes {
    my $default = {
        cgi_class => 'Kwiki::CGI',
        command_class => 'Kwiki::Command::V2',
        cookie_class => 'Kwiki::Cookie',
        css_class => 'Kwiki::CSS',
        formatter_class => 'Kwiki::Formatter::V3',
        headers_class => 'Spoon::Headers',
        hooks_class => 'Spoon::Hooks',
        images_class => 'Kwiki::Images',
        javascript_class => 'Kwiki::Javascript',
        pages_class => 'Kwiki::Pages',
        paths_class => 'Kwiki::Paths::V2',
        preferences_class => 'Kwiki::Preferences',
        registry_class => 'Kwiki::Registry',
        template_class => 'Spoon::Template',
        users_class => 'Kwiki::Users',
    };
    $self->SUPER::add_default_classes($default);
}
