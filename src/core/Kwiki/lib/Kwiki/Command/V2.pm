package Kwiki::Command::V2;
use Kwiki::Command::Base -Base;

sub handle_new {
    $self->assert_directory(shift, 'Kwiki');
    $self->update_kwiki_env_file;
    $self->apply_kwiki_env_file;
    $self->create_www_link;
    $self->add_new_default_config;
    $self->install('files');
    $self->create_database;
    $self->create_plugin_scratch;
    $self->set_permissions;
    $self->finished_msg;
}

sub create_plugin_scratch {
    $ENV{KWIKI_PLUGIN_SCRATCH_FILEPATH} or return;
    my $plugin = io($ENV{KWIKI_PLUGIN_SCRATCH_FILEPATH}) or return;
    $plugin->mkpath unless $plugin->exists;
}

sub create_database {
    my $target = $ENV{KWIKI_DATABASE_FILEPATH} or return;
    my $source = $self->hub->paths->find_first_filepath('database');
    unless (-d $target) {
        mkdir $target or die;
    }
    system("cp $source/* $target") == 0 or die;
}

sub apply_kwiki_env_file {
    my $env = $self->parse_env(io($self->kwiki_env_path)->all);
    for my $k (keys %$env) {
        next if defined $ENV{$k};
        $ENV{$k} = $env->{$k} if length($env->{$k});
    }
}

sub create_www_link {
    my $flavor_path = $ENV{KWIKI_BASE} . '/flavor/' . $ENV{KWIKI_FLAVOR};
    die "No such directory '$flavor_path'"
        unless -d $flavor_path and -d "$flavor_path/www";
    my $www = $ENV{KWIKI_WWW_FILEPATH} or die;
    io->link("$www/__")->assert->symlink("$flavor_path/www");
}

sub update_kwiki_env_file {
    my $env_file = io($self->kwiki_env_path);
    my $env_text = $env_file->exists 
        ? $env_file->all
        : $self->default_kwiki_env;
    my $env = $self->parse_env($env_text);
    for my $k (keys %ENV) {
        next unless exists $env->{$k};
        my $v = $ENV{$k};
        $v = '' unless defined $v;
        $env_text =~ s/^$k=.*$/$k=$v/m;
    }
    $env_file->print($env_text);
}

sub kwiki_env_path {
    for (qw(_kwiki .ht_kwiki)) {
        return $_ if -e $_;
    }
    return '_kwiki';
}

sub parse_env {
    my $text = shift;
    my $env = {};
    for (split /\n/, $text) {
        $env->{$1} ||= $2 if /^(\w+)\s*=\s*['"]?(.*?)['"]?\s*$/;
    }
    return $env;
}

sub default_kwiki_env {
    return <<'...';
KWIKI_BOOT=V2
KWIKI_LIB_PATH=lib
KWIKI_BASE=
KWIKI_FLAVOR=Vanilla
KWIKI_TEST_CLEAN=0
KWIKI_PLUGIN_SCRATCH_FILEPATH=plugin
KWIKI_DATABASE_FILEPATH=database
KWIKI_WWW_FILEPATH=www
...
}

sub handle_new_view {
    die;
    $self->assert_directory(shift, 'kwiki view');
    die "Parent directory does not look like a Kwiki installation"
      unless -e '../plugins';
    require Cwd;
    my $home = Cwd::cwd();
    $home =~ s/.*\///;
    for my $file (io->updir->all) {
        my $name = $file->filename;
        next if $name eq '.htaccess';
        next if $name eq 'plugins';
        next if $name eq 'registry.dd';
        next if $name eq $home;
        io->link($name)->symlink($file->name);
    }
    my $name = "config_".$home.".yaml";
    io($name);
    io($name)->print(<<END);
#This is the config file especially for your view,
#put the setting only this view here.
#
# Example:
#
# privacy_group:
END

    $self->create_new_view_plugins;
    $self->handle_update;
    print <<END;

New view created. Now edit the $home/plugins file and run 
'kwiki -update' in the '$home' subdirectory.
END
}

sub create_new_view_plugins {
    io('plugins')->print(<<END);
# You can either list all the plugins you want manually, or put '+' and '-' in
# front of the plugins you want to add/remove from ../plugins respectively.
#
# Example:
#
# -Kwiki::Edit
# +Kwiki::Favorites
# +Kwiki::Weather
END
}

sub add_new_default_config {
    $self->hub->config->add_config(
        {
            files_class => 'Kwiki::Files::V2',
        }
    );
}

sub is_kwiki_dir {
    my $dir = shift || '.';
    -d "$dir/plugin" and -f "$dir/registry.dd";
}

sub handle_update {
    die;
    chdir io->dir(shift || '.')->assert->open . '';
    die "Can't update non Kwiki directory!\n"
      unless -d 'plugin';
    $self->install($_) for $self->all_class_ids;
    io->link('lib')->symlink("$ENV{KWIKI_BASE}/lib")
      if defined $ENV{KWIKI_BASE} and not -e 'lib';
    $self->set_permissions;
}

sub handle_update_all {
    die;
    my @dirs = (io->curdir, io->curdir->All_Dirs);
    while (my $dir = shift @dirs) {
        next unless $self->is_kwiki_dir($dir);
        $self->msg('Updating ', $dir->absolute->pathname, "\n");
        $dir->chdir;
        system("kwiki -quiet -update");
    }
}

sub set_permissions {
    my $database = $ENV{KWIKI_DATABASE_FILEPATH} or die;
    my $plugin = $ENV{KWIKI_PLUGIN_SCRATCH_FILEPATH} or die;
    my $umask = umask 0000;
    chmod 0777, $database, $plugin;
    chmod 0666, glob "$database/*";
    chmod 0755, qw(index.cgi);
    umask $umask;
}

sub usage {
    warn <<END . $self->command_usage("  kwiki -%-20s # %s\n");
usage:
  kwiki -new [path]           # Generate a new Kwiki
  kwiki -update [path]        # Update an existing Kwiki
  kwiki -new_view [subdir]    # Create a new view under an existing Kwiki
  kwiki -update_all           # Update all Kwiki dirs under current dir
END
}
