package Spoon::Paths;
use Spoon::Base -Base;

# All the different types of paths
field path_values => -init => '$self->path_values_init';

# All directories in the config chain (starting at root).
field lookup_chain => -init => '$self->lookup_chain_init';

# All filepaths in the chain ending with the given file
sub all_ending {
    my $file = shift;
    my $path = shift || $self->lookup_chain;
    return grep { -e $_ } map "$_/$file", @$path;
}

sub find_file {
    my ($type, $file) = @_;
    my $path = $self->get_path($type);
    my @files = $self->all_ending($file, $path);
    return pop @files;
}

sub get_path {
    my $type = shift;
    $self->path_values->{$type} or
        die "Can't get path for type '$type'";
}

# TODO - Rename to add_to_path, append_to_path, remove_from_path
sub add_path {
    $self->remove_path(@_);
    my $type = shift;
    unshift @{$self->path_values->{$type}}, @_;
}

sub append_path {
    $self->remove_path(@_);
    my $type = shift;
    push @{$self->path_values->{$type}}, @_;
}

sub remove_path {
    my $type = shift;
    for my $path (@_) {
        $self->path_values->{$type} =
            [ grep {$_ ne $path} @{$self->path_values->{$type}} ];
    }
}
