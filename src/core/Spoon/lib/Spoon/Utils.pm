package Spoon::Utils;
use Spiffy -Base;
const directory_perms => 0755;

sub assert_filepath {
    my $filepath = shift;
    return unless $filepath =~ s/(.*)[\/\\].*/$1/;
    return if -e $filepath;
    $self->assert_directory($filepath);
}

sub assert_directory {
    my $directory = shift;
    require File::Path;
    umask 0000;
    File::Path::mkpath($directory, 0, $self->directory_perms);
}

sub remove_tree {
    my $directory = shift;
    require File::Path;
    umask 0000;
    File::Path::rmtree($directory);
}
