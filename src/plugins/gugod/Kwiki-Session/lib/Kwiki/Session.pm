package Kwiki::Session;
use Kwiki::Plugin -Base;
use CGI::Session;

our $VERSION = '0.01';

const class_id => 'session';
const class_title => 'Session';

field session => -init => '$self->load_session()';

sub load {
    $self->session
}

sub load_session {
    my $jar     = $self->hub->cookie->read("Session");
    my $session = CGI::Session->new(undef, $jar->{id} || undef,
				    {Directory=>$self->plugin_directory});
    $self->hub->cookie->write("Session", { id => $session->id() } );
    return $session;
}
