package Kwiki::Boot::V1;
use Kwiki::Boot::Base -Base;

const main_class => 'Kwiki';
const config_class => 'Kwiki::Config';
const hub_class => 'Kwiki::Hub';

sub init {
    $self->SUPER::init;
    $self->add_default_classes;
    $self->add_configs_files;
    $self->add_plugins_files;
}

sub add_configs_files {
    $self->config->add_file('config.yaml');
    for my $filepath (glob 'config*.*') {
        $self->config->add_override_filepath($filepath);
    }
}

sub add_plugins_files {
    my $plugins_used = {};
    my $plugin_classes = [];
    for my $file ($self->hub->paths->all_filepaths('plugins')) {
        my @plugins = grep {
            s/^([\+\-]?[\w\:]+)\s*$/$1/;
        } io($file)->slurp;
        for my $class (@plugins) {
            if ($class =~ s/^\-//) {
                if ($plugins_used->{$class}) {
                    delete $plugins_used->{$class};
                    @$plugin_classes = grep { $_ ne $class } @$plugin_classes;
                }
            }
            else {
                $class =~ s/^\+//;
                unless ($plugins_used->{$class}) {
                    push @$plugin_classes, $class;
                    $plugins_used->{$class} = 1;
                }
            }
        }
    }
    $self->config->plugin_classes($plugin_classes);
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
