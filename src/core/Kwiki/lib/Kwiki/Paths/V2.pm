package Kwiki::Paths::V2;
use Kwiki::Base -Base;
use Cwd qw(cwd abs_path);

field 'all_paths_cache';

# All directories in the config chain (starting at root).
sub all_paths {
    my $paths;
#     delete $self->{all_paths_cache} if @_;
#     $paths = $self->all_paths_cache;
#     return @$paths if ref $paths;
    $paths = [];
#     $self->all_paths_cache($paths);
    my $seen = {};
    
    my $dir = cwd();
    push @$paths, $dir;
    $seen->{$dir} = 1;

    $dir = $ENV{KWIKI_WWW_LOCATION} or return @$paths;
    $dir = abs_path($dir) or return @$paths;
    return @$paths unless -d $dir;
    return @$paths if $seen->{$dir};
    push @$paths, $dir;
    $seen->{$dir} = 1;

    while (-e "$dir/__") {
        $dir = abs_path("$dir/__");
        last unless -d $dir;
        last if $seen->{$dir};
        unshift @$paths, $dir;
        $seen->{$dir} = 1;

        my $updir = abs_path("$dir/..");
        last unless -d $updir;
        last if $seen->{$updir};
        unshift @$paths, $updir;
        $seen->{$updir} = 1;
    }

    return @$paths;
}

# All filepaths in the chain ending with the given file
sub all_filepaths {
    my $file = shift;
    return grep { -e $_ } map "$_/$file", $self->all_paths(@_);
}

# First filepath in the chain ending with the given file
sub first_filepath {
    my @all = $self->all_paths(@_);
    return $all[-1];
}
