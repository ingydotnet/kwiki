package Spoon::MetadataObject;
use Spoon::DataObject -Base;

const class_id => 'metadata';

sub parse_yaml_file {
    $self->hub->config->parse_yaml_file(shift);
}

sub print_yaml_file {
    my $file = shift;
    my $hash = shift;
    my $yaml = '';
    for my $key ($self->sort_order) {
        my $value = $hash->{$key};
        $value = '' unless defined $value;
        $yaml .= "$key: $value\n";
    }
    $yaml =~ s/\s+(?=\n)//g;
    io($file)->utf8->print($yaml);
    return $self;
}

sub from_hash {
    my $hash = shift;
    exists $hash->{$_} and $self->$_($hash->{$_})
      for $self->sort_order;
    return $self;
}

sub to_hash {
    my $hash = {};
    $hash->{$_} = $self->$_
      for $self->sort_order;
    return $hash;
}

sub update {
    return $self;
}
