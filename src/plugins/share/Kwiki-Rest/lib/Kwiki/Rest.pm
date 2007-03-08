package Kwiki::Rest;

use Kwiki::Plugin -Base;

const cgi_class => 'Kwiki::Rest::CGI';

sub register {
    my $registry = shift;
    $registry->add(action => 'rest');
}

sub rest {
    $self->dispatch($self->cgi->path_info);
}

# Create our REST::Application and run it
sub dispatch {
    my $path_info = shift;

    my $rester = Kwiki::Rest::App->new(hub => $self->hub);
    my ($headers, $output) = $rester->run($path_info);
    $self->hub->headers->set_headers($headers);
    return $output;
}

package Kwiki::Rest::App;
use base 'REST::Application::Routes';

$ENV{REST_APP_RETURN_ONLY} = 1;

sub setup {
    my %args = @_;
    $self->{hub} = $args{hub};
    $self->resourceHooks(
        # this could look in the registry for where to go to resolve
        # various stuff. In fact the registry could have the whole table.
        # Other classes could register REST solvers.
        #
        # Or <something>.yaml
        #
        # where we have text/plain below it maybe
        # ought to be text/x.kwiki-wiki
        # We also probably need a fall through
        # PUT of a page probably ought to handle better content types
        '/data/workspaces/:ws/pages/:pname' => {
            'GET' => {
                'text/html' => 'get_page_html',
                'text/plain' => 'get_page_text',
                '*/*' => 'get_page_html'
            },
            'PUT' => 'put_page_text',
        },
        #'/data/workspaces' => 'method',
        '/data/workspaces/:ws/pages' => {
            'GET' => {
                'text/html' => 'get_pages_html',
                'text/plain' => 'get_pages_text',
                '*/*' => 'get_pages_html'
            },
        },
    );

    # pull in request body for PUT and POST
    my $method = $self->getRequestMethod();
    if ($method eq 'POST') {
        $self->{content} = $self->query->param('POSTDATA');
    } elsif ($method eq 'PUT') {
        local $/;
        $self->{content} = <STDIN>;
    }
   
}

sub _page {
    $self->{hub}->pages->new_from_name(shift->{pname});
}

sub put_page_text {
    my $page = $self->_page(shift);

    my $active = $page->active;
    $page->content($self->{content});
    $page->store();
    $self->header(-status => $active ? '204 Updated' : '201 Created');
    return '';
}

sub get_page_html {
    my $page = $self->_page(shift);
    $self->header(
        -status => $page->active ? '200 OK' : '404 Not Found',
        -type => 'text/html'
    );
    return $page->active ? $page->to_html() : 'not found';
}

sub get_page_text {
    my $page = $self->_page(shift);
    $self->header(
        -status => $page->active ? '200 OK' : '404 Not Found',
        -type => 'text/plain'
    );
    return $page->active ? $page->content() : 'not found';
}

sub _pages {
    return $self->{hub}->pages->all_since(999999);
}

sub get_pages_html {
    my @pages = $self->_pages;
    return join '', "<ul>\n" ,
        (map {"<li>" . $_->uri . "</li>\n"} @pages) , "</ul>\n";
}

sub get_pages_text {
    my @pages = $self->_pages;
    return join "\n", map {$_->uri} @pages;
}

sub run {
    # Get resource.
    $self->preRun(); # A no-op by default.
    # $repr is a reference to a scalar
    my $repr = $self->loadResource(@_);
    $self->postRun($repr); # A no-op by default.

    # Get the headers and then add the representation to to the output stream.
    my $headers = {$self->header()};

    return $headers, $$repr;
}

package Kwiki::Rest::CGI;
use Kwiki::CGI -base;

cgi 'path_info';
