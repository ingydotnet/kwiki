package Kwiki::Paths;
use Kwiki::Base -Base;

field path_values => -init => '$self->path_values_init';
field lookup_chain => -init => '$self->lookup_chain_init';

sub get_path {
    my $type = shift;
    my $path = $self->path_values->{$type} or
        die "Can't get path for type '$type'";
    return $path;
}

# All filepaths in the chain ending with the given file
sub all_files {
    my $file = shift;
    return grep { -e $_ } map "$_/$file", @{$self->lookup_chain};
}

sub add_path {
    my $type = shift;
    for (reverse @_) {
        $self->remove_path($type, $_);
        unshift @{$self->path_values->{$type}}, $_;
    }
}

sub append_path {
    my $type = shift;
    for (@_) {
        $self->remove_path($type, $_);
        push @{$self->path_values->{$type}}, $_;
    }
}

sub remove_path {
    my $type = shift;
    my $path = shift;
    $self->path_values->{$type} = [
        grep {$_ ne $path} @{$self->path_values->{$type}}
    ];
}

# Terminology
#
# path -
# base -
# dir -
# location -
# filepath -
# 

