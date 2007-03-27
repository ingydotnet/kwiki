package Kwiki::Images;
use Kwiki::WebFile -Base;

const class_id => 'images';

sub get_url {
    my $image = shift or return;
    $self->hub->paths->find_file(images => $image);
}
