package Kwiki::DMOZLink;

use warnings;
use strict;

use Kwiki::Plugin '-Base';

our $VERSION = 0.01;

const class_title => 'DMOZ Search Link';
const class_id => 'dmoz_link';

sub register {
    my $registry = shift;
    $registry->add(wafl => dmoz => 'Kwiki::DMOZLink::Wafl');
}

package Kwiki::DMOZLink::Wafl;
use Spoon::Formatter;
use base qw(Spoon::Formatter::WaflPhrase);

const dmoz_search => 'http://search.dmoz.org/cgi-bin/search?search=';

sub html {
    my $search = $self->arguments;
    join('', 
	 '<a href="', 
          $self->dmoz_search, 
          $self->uri_escape($search), '">',
	  $self->html_escape($search), '</a>'
 	);
}

1;
