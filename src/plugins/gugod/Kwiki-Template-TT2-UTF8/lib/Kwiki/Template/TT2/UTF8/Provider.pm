package Kwiki::Template::TT2::UTF8::Provider;
use base qw(Template::Provider);
our $VERSION = '0.01';

sub utf8_upgrade {
    my @list = map pack('U*', unpack 'U0U*', $_), @_;
    return wantarray ? @list : $list[0];
}

sub _load {
    my $self = shift;
    my ($data, $error) = $self->SUPER::_load(@_);
    if(defined $data) {
        $data->{text} = utf8_upgrade($data->{text});
    }
    return ($data, $error);
}

1;
