package Spoon::Config;
use Spoon::Base -Base;

const class_id => 'config';
field plugin_classes => [];

sub all {
    return %$self;
}

sub add_file {
    my $file = shift;
    for my $dir ($self->hub->paths->all_filepaths('config')) {
        my $filepath = "$dir/$file";
        $self->add_config($filepath, @_)
          if -f $filepath;
    }
}

sub add_config {
    my $config = shift;
    my $override = shift || 0;
    my $hash = ref $config
    ? $config
    : $self->hash_from_file($config);
    for my $key (keys %$hash) {
        field $key;
        if ($override || not defined $self->{$key}) {
            $self->{$key} = $hash->{$key};
        }
    }
    return $hash;
}

sub hash_from_file {
    my $config = shift;
    die "Invalid name for config file '$config'\n"
      unless $config =~ /\.(\w+)$/;
    my $extension = lc("$1"); # quotes fix 5.8.0 perl bug
    my $method = "parse_${extension}_file";
    -f $config ? $self->$method($config) : {};
}

sub parse_file {
    $self->parse_yaml_file(@_);
}

sub parse_yaml_file {
    my $file = shift;
    $self->parse_yaml(io($file)->utf8->all);
}

sub parse_yaml {
    my $yaml = shift;
    my $hash = {};
    my $latest_key = '';
    for (split /\n/, $yaml) {
        next if (/^#/);
        if (/^-\s*(.*)$/) {
            $hash->{$latest_key} = [] unless ref $hash->{$latest_key};
            push @{$hash->{$latest_key}}, $1;
        }
        elsif (/(.*?)\s*:\s+(.*?)\s*$/ or /(.*?):()\s*$/) {
            $hash->{$1} = $2;
            $latest_key = $1;
        }
    }
    return $hash;
}

sub add_plugins_file {
    my $file = shift;
    my $used = {};
    my $classes = $self->plugin_classes;
    $used->{$_} = 1 for @$classes;
    
    my @plugins = grep {
        s/^([\+\-]?[\w\:]+)\s*$/$1/;
    } io($file)->slurp;

    for my $class (@plugins) {
        if ($class =~ s/^\-//) {
            if ($used->{$class}) {
                delete $used->{$class};
                @$classes = grep { $_ ne $class } @$classes;
            }
        }
        else {
            $class =~ s/^\+//;
            unless ($used->{$class}) {
                push @$classes, $class;
                $used->{$class} = 1;
            }
        }
    }

    $self->plugin_classes($classes);
}
