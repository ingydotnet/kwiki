package Kwiki::Doolittle;
use Kwiki::Plugin -Base;

const class_id => 'doolittle';

sub register {
    my $registry = shift;
    $registry->add( preload => 'doolittle' );
}

use Kwiki::CGI;
package Kwiki::CGI;
use Kwiki ':char_classes';
no warnings 'redefine';
sub set_default_page_name {
    my $page_name = shift;
    $page_name = '' if $page_name and $page_name =~ /[^$ALPHANUM\-]/;
    $page_name ||= $self->hub->config->main_page;
}
