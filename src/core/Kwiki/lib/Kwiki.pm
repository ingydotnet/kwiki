package Kwiki;
use Spoon 0.22 -Base;
our $VERSION = '0.38';

const config_class => 'Kwiki::Config';

sub process {
    my $hub = $self->load_hub(@_);
    $hub->registry->load;
    $hub->add_hooks;
    $hub->pre_process;
    my $html = $hub->process;
    if (defined $html) {
        $hub->headers->print;
        $self->utf8_encode($html);
        # With mod_perl < 1.27 and Perl >= 5.8.0, STDOUT does not get
        # tied to Apache.pm properly.
        exists $ENV{MOD_PERL}
          ? Apache->request->print($html)
          : print $html;
    }
#     close STDOUT unless $self->using_debug;
    $hub->post_process;
    $self->destroy_hub;
    undef $hub;
    return $self;
}
