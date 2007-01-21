package Kwiki::Test;
use Spiffy -Base;
use Kwiki;
use IO::All;
use Cwd;

const 'base_dir' => Cwd::abs_path(".") . "/kwiki";

our $VERSION = '0.03';

sub init {
    my $plugins = shift;
    $self->make_directory;
    $self->install_new_kwiki;
    if ($plugins) {
        $self->add_plugins($plugins);
    }
    return $self;
}

sub initialize_plugins {
    my @plugins = @{$self->hub->registry->lookup->{plugins}};
    foreach my $plugin (@plugins) {
        my $class = $plugin->{id};
        $self->hub->$class->init;
    }
}

sub reset_hub {
    undef($self->{hub});
    $self->hub;
}

sub hub {
    return $self->{hub} if $self->{hub};
    chdir($self->base_dir) || die "unable to chdir to ", $self->base_dir,
        "$!\n";;
    my @configs = qw(config.yaml -plugins plugins);
    my $hub = Kwiki->new->load_hub(@configs);
    $self->{hub} = $hub;
}

sub make_directory {
    mkdir($self->base_dir) || warn "unable to mkdir ", $self->base_dir, "\n";
}

sub install_new_kwiki {
    # we've already chdir'd
    $self->hub->command->process(qw(-quiet -new .));
    # reset the hub
    undef($self->{hub});
}

sub add_plugins {
    my $plugins = shift;
    $self->hub->command->quiet(1);
    $self->hub->command->handle_add(@$plugins);
    $self->initialize_plugins;
}

sub cleanup {
    io($self->base_dir)->rmtree unless $ENV{KWIKI_TEST_DIRTY};
}

# Utlity stuff
# some of this is obvious, but doing it in here in case
# there are change dirs and the like that we'd like to do

sub exists_as_file {
    -f shift;
}

sub exists_as_dir {
    -d shift;
}
