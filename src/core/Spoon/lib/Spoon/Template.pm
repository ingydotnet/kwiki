package Spoon::Template;
use Spoon::Base -Base, 'conf';
use Template;

const class_id => 'template';

field template_object => -init => '$self->create_template_object';

# These 3 methods have been deprecated and now are just delegating.
sub add_path    { $self->hub->paths->add_path(template => @_) }
sub append_path { $self->hub->paths->append_path(template => @_) }
sub remove_path { $self->hub->paths->remove_path(template => @_) }

sub all {
    return ( 
        $self->hub->config->all,
        $self->is_in_cgi ? ($self->hub->cgi->all) : (),
        hub => $self->hub,
    );
}

sub process {
    my $template = shift;
    my @templates = (ref $template eq 'ARRAY')
      ? @$template 
      : $template;
    return join '', map {
        $self->render($_, $self->all, @_)
    } @templates;
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

sub create_template_object {
    require Template;
    # XXX Make template caching a configurable option
    Template->new({
        LOAD_TEMPLATES => [
            Kwiki::Template::TT2::UTF8::Provider->new({
		INCLUDE_PATH => $self->hub->paths->get_path('template'),
            })],
        # INCLUDE_PATH => $self->path,
        TOLERANT => 0,
        COMPILE_DIR => $self->compile_dir,
        COMPILE_EXT => '.ttc',
    });
}

sub compile_dir {
    my $dir = $self->plugin_directory . '/ttc';
    mkdir $dir unless -d $dir;
    return $dir;
}

package Kwiki::Template::TT2::UTF8::Provider;
use base 'Template::Provider';
use Spoon::Base -Base;

sub _load {
    my ($data, $error) = $self->SUPER::_load(@_);
    if (defined $data) {
        $data->{text} = $self->utf8_upgrade($data->{text});
    }
    return ($data, $error);
}
