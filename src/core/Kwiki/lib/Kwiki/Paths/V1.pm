package Kwiki::Paths::V1;
use Kwiki::Paths -Base;
use Cwd qw(cwd abs_path);

sub path_values_init {
    my $values = {};
    $values->{template} = 
        $self->hub->config->{template_path} ||
        [ './template/tt2' ];
    return $values;
}

# All directories in the config chain (starting at root).
sub lookup_chain_init {
    my $dir = cwd();
    my $paths = [$dir];
    while (1) {
        my $updir = abs_path("$dir/..") or last;
        last if $dir eq $updir;
        $dir = $updir;
        last unless -e "$dir/config.yaml";
        last unless -e "$dir/plugins";
        unshift @$paths, $dir;
        last unless io('plugins')->all =~ /^[+-]/m;
    }
    return $paths;
}

# All filepaths in the chain ending with the given file
sub all_files {
    my $file = shift;
    return ('./config') if $file eq 'config';
    return grep { -e } map "$_/$file", @{$self->lookup_chain};
}

