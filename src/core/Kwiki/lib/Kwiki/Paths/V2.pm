package Kwiki::Paths::V2;
use Kwiki::Paths -Base;
use Cwd qw(cwd abs_path);

field 'all_paths_cache';

sub path_values_init {
    my $values = {};
    $values->{template} =
        [
            $self->all_files('template'),
            $self->all_files('template/tt2'),
            $self->all_files('theme/__theme__/template/tt2'),
        ];
    return $values;
}

# All directories in the config chain (starting at root).
sub lookup_chain_init {
    my $paths;
    $paths = [];
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

    return $paths;
}
