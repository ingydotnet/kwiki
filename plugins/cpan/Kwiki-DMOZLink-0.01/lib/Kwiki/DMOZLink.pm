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

=head1 NAME

Kwiki::DMOZLink - Create a link to DMOZ.org from your Kwiki

=head1 Version

Version 0.01

=head1 Synopsis

Creates a link to search DMOZ.org for the term.

For example:

    Search DMOZ for: (dmoz:Kwiki)


=head1 Author

Steve Peters, C<< <steve@fisharerojo.org> >>

=head1 Credit

Michael Gray's useful Kwiki::GoogleLink gave me much of the inspiration (and 
code) for this module.  See C<http://www.kwiki.org/index.cgi?KwikiGoogleLinkPlugin>

=head1 TODO

This needs more tests for me to feel really comfortable with.  

=head1 Bugs

Please report any bugs or feature requests to
C<bug-kwiki-dmozlink@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

=head1 Copyright & License

Copyright 2004 Steve Peters, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
