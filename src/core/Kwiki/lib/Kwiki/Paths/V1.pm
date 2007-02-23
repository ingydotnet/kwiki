package Kwiki::Paths::V1;
use Kwiki::Base -Base;

sub lookup_path {
    my $type = shift;
    if ($type eq 'config') {
        return ['./config'];
    }
    die "Invalid type '$type' for lookup_path";
}
