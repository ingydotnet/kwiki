package Kwiki::SisterSites;
use Kwiki::Plugin -Base;
our $VERSION = '0.10';

const class_id => 'sister_sites';
const class_title => 'Kwiki Sister Sites';

sub register {
    my $registry = shift;
    $registry->add(action => 'sister_sites_index');
}

sub sister_sites_index {
    $self->hub->headers->content_type('text/plain');
    $self->hub->cache->process(
        sub { $self->result }, $self->class_id, int(time / 3600)
    );
}

sub result {
    join '', map {
        $self->config->site_url . '?' . $_->id . ' ' . $_->title . "\n";
    } $self->pages->all; 
}
