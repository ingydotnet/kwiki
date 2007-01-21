package Kwiki::CSS;
use Kwiki::WebFile -Base;

const class_id => 'css';
const default_path_method => 'css_path';

conf css_path => [ 'css' ];

sub _append_file {
    my ($files, $file_path) = @_;
    unshift @$files, $file_path;
}
