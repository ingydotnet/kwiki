package Kwiki::Paths::V1;
use Kwiki::Base -Base;
use Cwd qw(cwd abs_path);

# All directories in the config chain (starting at root).
sub all_paths {
    my $dir = cwd();
    my @paths = ($dir);
    while (1) {
        my $updir = abs_path("$dir/..") or last;
        last if $dir eq $updir;
        $dir = $updir;
        last unless -e "$dir/config.yaml";
        unshift @paths, $dir;
    }
    return @paths;
}

# All filepaths in the chain ending with the given file
sub all_filepaths {
    my $file = shift;
    return ('./config') if $file eq 'config';

    return grep { -e } map "$_/$file", $self->all_paths;
}

# First filepath in the chain ending with the given file
sub first_filepath {
    return scalar $self->all_paths(shift);
}
