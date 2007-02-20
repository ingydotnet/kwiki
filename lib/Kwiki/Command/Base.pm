package Kwiki::Command::Base;
use Spoon::Command -Base;

sub finished_msg {
    warn "\nKwiki software installed! Point your browser at this location.\n\n";
}

sub assert_directory {
    chdir io->dir(shift || '.')->assert->open->name;
    my $noun = shift;
    my @any_files = grep {
        not /^\.[\\\/]?(lib|Makefile|\.svn)$/
    } io('.')->all;
    die "Can't make new $noun in a non-empty directory\n"
      if @any_files;
}

sub install {
    my $class_id = shift;
    my $object = $self->hub->$class_id
      or return;
    return unless $object->can('extract_files');
    my $class_title = $self->hub->$class_id->class_title;
    $self->msg("Extracting files for $class_title:\n");
    $self->hub->$class_id->quiet($self->quiet);
    $self->hub->$class_id->extract_files;
    $self->msg("\n");
}

sub all_class_ids {
    my @all_modules;
    for my $key (keys %{$self->hub->config}) {
        push @all_modules, $self->hub->config->{$key}
          if $key =~ /_class/;
    }
    push @all_modules, @{$self->hub->config->{plugin_classes} || []};
    map {
        eval "require $_; 1"
        ? $_->can('extract_files')
          ? do {
              my $class_id = $_->class_id;
              $self->hub->config->add_config({"${class_id}_class" => $_});
              ($_->class_id)
          }
          : ()
        : ();
    } @all_modules;
}

sub handle_compress {
    require Spoon::Installer;
    Spoon::Installer->new->compress_lib(@_);
}

