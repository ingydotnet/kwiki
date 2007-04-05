package Spork::Boot::V1;
use Spoon::Boot::Base -Base;

const main_class => 'Spork';
const config_class => 'Spork::Config';
const hub_class => 'Spork::Hub';

sub add_configs_files {
    $self->config->add_file('config.yaml');
    for my $filepath (glob 'config*.*') {
        $self->config->add_config($filepath, 1);
    }
}

sub add_default_classes {
    my $default = {
        command_class => 'Spork::Command',
        config_class => 'Spork::Config',
        formatter_class => 'Spork::Formatter',
        hooks_class => 'Spoon::Hooks',
        hub_class => 'Spork::Hub',
        paths_class => 'Spork::Paths',
        registry_class => 'Spork::Registry',
        slides_class => 'Spork::Slides',
        template_class => 'Spork::Template::TT2',

        # For Kwiki Plugins:
        cache_class => 'Kwiki::Cache',
        cgi_class => 'Kwiki::CGI',
        css_class => 'Kwiki::CSS',
        javascript_class => 'Kwiki::Javascript',
        kwiki_command_class => 'Kwiki::Command::V1',
        pages_class => 'Kwiki::Pages',
        preferences_class => 'Kwiki::Preferences',
    };
    $self->SUPER::add_default_classes($default);
}
