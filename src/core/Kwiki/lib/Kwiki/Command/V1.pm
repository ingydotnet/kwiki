package Kwiki::Command::V1;
use Kwiki::Command::Base -Base;

sub handle_new {
    $self->assert_directory(shift, 'Kwiki');
    $self->add_new_default_config;
    $self->install('files');
    $self->install('config');
    $self->create_registry;
    # XXX a method should return this list of plugin class_ids
    $self->install('display');
    $self->install('edit');
    $self->install('formatter');
    $self->install('users');
    $self->install('pages');
    $self->install('theme');
    $self->install('toolbar');
    $self->install('status');
    $self->install('widgets');
    io('plugin')->mkdir;
    io('registry.dd')->unlink;
    io->link('lib')->symlink("$ENV{KWIKI_BASE}/lib")
      if defined $ENV{KWIKI_BASE};
    $self->set_permissions;
    $self->finished_msg;
}

sub handle_new_view {
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
            display_class => 'Kwiki::Display',
            edit_class => 'Kwiki::Edit',
            files_class => 'Kwiki::Files::V1',
            theme_class => 'Kwiki::Theme::Basic',
            toolbar_class => 'Kwiki::Toolbar',
            status_class => 'Kwiki::Status',
            widgets_class => 'Kwiki::Widgets',
        }
    );
}

sub is_kwiki_dir {
    my $dir = shift || '.';
    -d "$dir/plugin" and -f "$dir/registry.dd";
}

sub handle_update {
    chdir io->dir(shift || '.')->assert->open . '';
    die "Can't update non Kwiki directory!\n"
      unless -d 'plugin';
    $self->create_registry;

    $self->hub->config->add_config(
        {
            files_class => 'Kwiki::Files::V1',
        }
    );

    $self->install($_) for $self->all_class_ids;
    io->link('lib')->symlink("$ENV{KWIKI_BASE}/lib")
      if defined $ENV{KWIKI_BASE} and not -e 'lib';
    $self->set_permissions;
}

sub handle_update_all {
    my @dirs = (io->curdir, io->curdir->All_Dirs);
    while (my $dir = shift @dirs) {
        next unless $self->is_kwiki_dir($dir);
        $self->msg('Updating ', $dir->absolute->pathname, "\n");
        $dir->chdir;
        system("kwiki -quiet -update");
    }
}

sub handle_add {
    $self->update_plugins('+', @_);
}

sub handle_remove {
    $self->update_plugins('-', @_);
}

sub update_plugins {
    die "This operation must be performed inside a Kwiki installation directory"
      unless -f $self->hub->config->plugins_file;
    my $mode = shift;
    return $self->usage unless @_;
    my $plugins_file = $self->hub->config->plugins_file;
    my $plugins = io($plugins_file);
    my @lines = $plugins->chomp->slurp;
    for my $module (@_) {
        eval "require $module;1" or die $@ or
          ($module = "Kwiki::$module" and eval "require $module;1") or
            die "Invalid module '$module'";
        if ($mode eq '+') {
            next if grep /^$module$/, @lines;
            push @lines, $module;
            next;
        }
        @lines = grep {$_ ne $module} @lines;
    }
    $plugins->println($_) for @lines;
    $plugins->close;
    $self->hub->config->add_plugins_file($plugins_file);
    $self->handle_update;
}

sub handle_install {
    die "This operation must be performed inside a Kwiki installation directory"
      unless -f $self->hub->config->plugins_file;
    return $self->usage unless @_;
    require Cwd;
    $self->cpan_setup;
    my @modules = @_;
    for my $module (@_) {
        $self->fake_install($module);
        my $home = Cwd::cwd();
        my $rc = CPAN::Shell->expand('Module', $module);
        if (not defined $rc) {
            die "WARNING - Can't install $module\nStopping...\n";
        }
        $rc->install;
        chdir $home;
    }
    $self->update_plugins('+', @modules);
}

sub cpan_setup {
    no warnings;
    require CPAN;
#     require CPAN::Config;
    my $lib = io->dir('lib')->absolute;
    $ENV{PERL_MM_OPT} = "INSTALLSITELIB=$lib PREFIX=$lib"
      if $lib->exists;
    CPAN::Config->load;
    $CPAN::Config_loaded = 1;
    my $cpan_dir = io->dir('.cpan')->rel2abs;
    $CPAN::Config->{cpan_home} =
    $CPAN::Config->{build_dir} = $cpan_dir;
    $CPAN::Config->{keep_source_where} = 
      io->catdir($cpan_dir, 'sources')->name;
}

sub fake_install {
    return unless -d 'lib';
    my $module = shift;
    $module =~ s/::/\//g;
    $module .= '.pm';
    my $file = io->catfile('lib', $module);
    $file->assert->touch
      unless -f $file->name;
}

sub set_permissions {
    my $umask = umask 0000;
    chmod 0777, qw(database plugin);
    chmod 0666, qw(database/HomePage);
    chmod 0755, qw(index.cgi);
    umask $umask;
}

sub create_registry {
    my $registry = $self->hub->registry;
    my $registry_path = $registry->registry_path;
    $self->msg("Generating Kwiki Registry '$registry_path'\n");
    $registry->update;
    if ($registry->validate) {
        $registry->write;
    }
    $self->hub();
    
    $self->hub->registry->load;
}

sub usage {
    warn <<END . $self->command_usage("  kwiki -%-20s # %s\n");
usage:
  kwiki -new [path]           # Generate a new Kwiki
  kwiki -update [path]        # Update an existing Kwiki
  kwiki -add Kwiki::Foo       # Add a plugin
  kwiki -remove Kwiki::Foo    # Remove a plugin
  kwiki -install Kwiki::Foo   # Download and install a plugin
  kwiki -new_view [subdir]    # Create a new view under an existing Kwiki
  kwiki -update_all           # Update all Kwiki dirs under current dir
END
}
