package Kwiki::Paths::V1;
use Kwiki::Paths -Base;

sub path_values_init {
    my $values = {};
    $values->{css} = 
        $self->hub->config->{css_path} ||
        [ 'css' ];
    $values->{javascript} = 
        $self->hub->config->{javascript_path} ||
        [ 'javascript' ];
    $values->{template} = 
        $self->hub->config->{template_path} ||
        [ './template/tt2' ];
    $values->{images} = 
        $self->hub->config->{image} ||
        [ '.' ];
    return $values;
}

sub lookup_chain_init {
    my $dir = '.';
    my $paths = [$dir];
    while (1) {
        $dir = "$dir/..";
        last unless -e "$dir/config.yaml";
        last unless -e "$dir/plugins";
        unshift @$paths, $dir;
        last unless io('plugins')->all =~ /^[+-]/m;
    }
    return $paths;
}

sub all_ending {
    return ('./config') if $_[0] eq 'config';
    $self->SUPER::all_ending(@_);
}
