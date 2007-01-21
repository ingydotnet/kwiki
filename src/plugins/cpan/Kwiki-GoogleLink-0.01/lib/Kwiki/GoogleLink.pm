package Kwiki::GoogleLink;
use strict;
use warnings;
use Kwiki::Plugin '-Base';

our $VERSION = 0.01;

const class_title => 'Google Search Link';
const class_id => 'google_link';

sub register {
    my $registry = shift;
    $registry->add(wafl => google => 'Kwiki::GoogleLink::Wafl');
}

package Kwiki::GoogleLink::Wafl;
use Spoon::Formatter ();
use base 'Spoon::Formatter::WaflPhrase';

const google_search => 'http://www.google.com/search?q=';

sub html {
    my $search = $self->arguments;
    join('', 
         '<a href="', 
         $self->google_search,
         $self->uri_escape($search), '">',
         $self->html_escape($search), '</a>'
        );
}

1;
