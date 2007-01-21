package Kwiki::Template::TT2::UTF8;
use Kwiki::Template::TT2 -Base;
use Kwiki::Template::TT2::UTF8::Provider;

our $VERSION = '0.02';

sub create_template_object {
    require Template;
    # XXX Make template caching a configurable option
    Template->new({
        LOAD_TEMPLATES => [
            Kwiki::Template::TT2::UTF8::Provider->new({
		INCLUDE_PATH => $self->path,
            })],
        TOLERANT => 0,
        COMPILE_DIR => $self->compile_dir,
        COMPILE_EXT => '.ttc',
    });
}
