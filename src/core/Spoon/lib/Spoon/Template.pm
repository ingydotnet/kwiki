package Spoon::Template;
use Spoon::Base -Base, 'conf';
# use Spoon::Base 'conf';
use Template;

const class_id => 'template';
const template_path => [ './template' ];
field path => [];
field config => -init => '$self->hub->config';
field cgi => -init => '$self->hub->cgi';
field template_object =>
      -init => '$self->create_template_object';
conf template_path => [ './template/tt2' ];

sub init {
    $self->add_path(@{$self->template_path});
}

sub all {
    return ( 
        $self->config->all,
        $self->is_in_cgi ? ($self->cgi->all) : (),
        hub => $self->hub,
    );
}

sub add_path {
    for (reverse @_) {
        $self->remove_path($_);
        unshift @{$self->path}, $_;
    }
}

sub append_path {
    for (@_) {
        $self->remove_path($_);
        push @{$self->path}, $_;
    }
}

sub remove_path {
    my $path = shift;
    $self->path([grep {$_ ne $path} @{$self->path}]);
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

sub compile_dir {
    my $dir = $self->plugin_directory . '/ttc';
    mkdir $dir unless -d $dir;
    return $dir;
}
        
sub create_template_object {
    require Template;
    # XXX Make template caching a configurable option
    Template->new({
        LOAD_TEMPLATES => [
            Kwiki::Template::TT2::UTF8::Provider->new({
		INCLUDE_PATH => $self->path,
            })],
        # INCLUDE_PATH => $self->path,
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

package Kwiki::Template::TT2::UTF8::Provider;
use base 'Template::Provider';

sub utf8_upgrade {
    my @list = map pack('U*', unpack 'U0U*', $_), @_;
    return wantarray ? @list : $list[0];
}

sub _load {
    my ($data, $error) = $self->SUPER::_load(@_);
    if (defined $data) {
        $data->{text} = $self->utf8_upgrade($data->{text});
    }
    return ($data, $error);
}
