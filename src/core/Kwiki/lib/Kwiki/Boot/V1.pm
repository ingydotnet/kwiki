package Kwiki::Boot::V1;
use Kwiki::Boot::Base -Base;

const main_class => 'Kwiki';
const config_class => 'Kwiki::Config';
const hub_class => 'Kwiki::Hub';

sub add_configs_files {
    $self->config->add_file('config.yaml');
    for my $filepath (glob 'config*.*') {
        $self->config->add_config($filepath, 1);
    }
}

sub add_default_classes {
    my $default = {
        cgi_class => 'Kwiki::CGI',
        command_class => 'Kwiki::Command::V1',
        cookie_class => 'Kwiki::Cookie',
        css_class => 'Kwiki::CSS',
        formatter_class => 'Kwiki::Formatter',
        headers_class => 'Spoon::Headers',
        hooks_class => 'Spoon::Hooks',
        javascript_class => 'Kwiki::Javascript',
        pages_class => 'Kwiki::Pages',
        paths_class => 'Kwiki::Paths::V1',
        preferences_class => 'Kwiki::Preferences',
        registry_class => 'Kwiki::Registry',
        template_class => 'Kwiki::Template::TT2',
        users_class => 'Kwiki::Users',
    };
    $self->SUPER::add_default_classes($default);
}
