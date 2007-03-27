package Kwiki::Paths;
use Kwiki::Base -Base;

# All the different types of paths
field path_values => -init => '$self->path_values_init';

# All directories in the config chain (starting at root).
field lookup_chain => -init => '$self->lookup_chain_init';

sub get_path {
    my $type = shift;
    $self->path_values->{$type} or
        die "Can't get path for type '$type'";
}

# All filepaths in the chain ending with the given file
sub all_files {
    my $file = shift;
    return grep { -e $_ } map "$_/$file", @{$self->lookup_chain};
}

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


# Terminology
#
# path -
# base -
# dir -
# location -
# filepath -
# 

