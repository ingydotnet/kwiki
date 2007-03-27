package Kwiki::CSS;
use Kwiki::WebFile -Base;

const class_id => 'css';

# XXX - Why is this here?
sub _append_file {
    my $file = shift;
    my $files = $self->files;
    @$files = grep { not /\/$file$/ } @$files;
    unshift @$files, $file;
}
