package Kwiki::Paths::V1;
use Kwiki::Base -Base;

sub all_filepaths {
    my $filepath = shift;
    if ($filepath eq 'config') {
        return ('./config');
    }
    my @paths;
    push @paths, $filepath if -f $filepath;
    while (1) {
        $filepath = "../$filepath";
        last unless -f $filepath;
        unshift @paths, $filepath;
    }
    return @paths;
}
