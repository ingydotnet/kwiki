package Spoon::Template::TT2;
use Spoon::Template -Base;

field template_object =>
      -init => '$self->create_template_object';

sub compile_dir {
    my $dir = $self->plugin_directory . '/ttc';
    mkdir $dir unless -d $dir;
    return $dir;
}
        
sub create_template_object {
    require Template;
    # XXX Make template caching a configurable option
    Template->new({
        INCLUDE_PATH => $self->path,
        TOLERANT => 0,
        COMPILE_DIR => $self->compile_dir,
        COMPILE_EXT => '.ttc',
    });
}

sub render {
    my $template = shift;

    my $output;
    my $t = $self->template_object;
    eval {
        $t->process($template, {@_}, \$output) or die $t->error;
    };
    die "Template Toolkit error:\n$@" if $@;
    return $output;
}
