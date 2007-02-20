package Kwiki::Command::V2;
use Kwiki::Command::Base -Base;

sub handle_new {
    $self->assert_directory(shift, 'Kwiki');
    $self->add_new_default_config;
    $self->install('files');
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
            files_class => 'Kwiki::Files::V2',
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

sub set_permissions {
    my $umask = umask 0000;
    chmod 0777, qw(database plugin);
    chmod 0666, qw(database/HomePage);
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
