#line 1 "inc/Module/Install/Manifest.pm - /Users/ingy/local/lib/perl5/site_perl/5.8.6/Module/Install/Manifest.pm"
package Module::Install::Manifest;
use Module::Install::Base; @ISA = qw(Module::Install::Base);
$VERSION = '0.01';
use strict;
use warnings;

sub manifest_skip {
    my $self = shift;
    $self->_top->{manifest_skip} = [@_];
}

1;
