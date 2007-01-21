package Spoon::Plugin;
use Spoon::Base -Base;

sub class_title_prefix { () }

sub class_id {
    my $package = ref $self;
    $package =~ s/.*:://;
    lc($package);
}

sub class_title {
    join ' ', map {
        s/(.*)/\u$1/;
        $_;
    } $self->class_title_prefix, split '_', $self->class_id;
}

sub register {
    $self->hub->registry->add(action => $self->class_id, 'process')
      if $self->can('process');
    return $self;
}
