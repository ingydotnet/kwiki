package Kwiki::Boot::V010;
use Kwiki::Boot -Base;

use Kwiki;
use Kwiki::Config;
use Kwiki::Hub;

sub init {
    my $config = Kwiki::Config->new('config*.*');
    $self->config($config);

    $self->add_configs_files;
    $self->add_plugins_files;

    my $hub = Kwiki::Hub->new;

    my $kwiki = Kwiki->new;
    $hub->main($kwiki);
    $hub->config($config);

    $self->kwiki($kwiki);
}

sub add_configs_files {
    $self->config->add_path('config');
    $self->config->add_file('config.yaml');
}

sub add_plugins_files {
    $self->config->add_plugins_file('plugins');
}
