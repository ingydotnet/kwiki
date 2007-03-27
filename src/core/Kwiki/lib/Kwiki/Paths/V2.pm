package Kwiki::Paths::V2;
use Kwiki::Paths -Base;

field 'all_paths_cache';

sub path_values_init {
    my $values = {};
    $values->{template} =
        [
            $self->all_ending('template'),
            $self->all_ending('template/tt2'),
            $self->all_ending('theme/__theme__/template/tt2'),
        ];
    $values->{css} =
        [
            $self->all_ending('css'),
            $self->all_ending('theme/__theme__/css'),
        ];
    $values->{javascript} =
        [
            $self->all_ending('javascript'),
            $self->all_ending('theme/__theme__/javascript'),
        ];
    $values->{images} =
        [
            $self->all_ending('images'),
            $self->all_ending('theme/__theme__/images'),
        ];
    return $values;
}

# All directories in the config chain (starting at root).
sub lookup_chain_init {
    my $paths;
    $paths = [];
    my $seen = {};
    
    my $dir = '.';
    push @$paths, $dir;
    $seen->{$dir} = 1;

    $dir = $ENV{KWIKI_WWW_LOCATION} or return @$paths;
    return @$paths unless -d $dir;
    return @$paths if $seen->{$dir};
    push @$paths, $dir;
    $seen->{$dir} = 1;

    while (-e "$dir/__") {
        $dir = "$dir/__";
        last unless -d $dir;
        last if $seen->{$dir};
        unshift @$paths, $dir;
        $seen->{$dir} = 1;

        my $updir = "$dir/..";
        last unless -d $updir;
        last if $seen->{$updir};
        unshift @$paths, $updir;
        $seen->{$updir} = 1;
    }

    return $paths;
}
