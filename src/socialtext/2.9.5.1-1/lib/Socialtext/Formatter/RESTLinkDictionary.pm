# @COPYRIGHT@
package Socialtext::Formatter::RESTLinkDictionary;

use warnings;
use strict;

use base 'Socialtext::Formatter::LinkDictionary';

use Class::Field qw'field';

field free      => '%{page_uri}';
field interwiki =>
    '/data/workspaces/%{workspace}/pages/%{page_uri}%{section}';
field search_query => '/data/workspaces/%{workspace}/pages?q=%{search_term}';
field category_query => '/data/workspaces/%{workspace}/tags/%{category}/pages';

# REVIEW: What's the right count, is any count at all right?
field recent_changes_query =>
    '/data/workspaces/%{workspace}/pages?order=newest;count=50';

field category     => '/data/workspaces/%{workspace}/tags/%{category}/pages';
field weblog       => '/data/workspaces/%{workspace}/tags/%{category}/pages';
field attachment => '/data/workspaces/%{workspace}/attachments/%{page_uri}:%{id}/files/%{filename}';

# REVIEW: this is for http:text which is just weird so we let it ride, with
# a slight adjustment
sub special_http {
    my $self = shift;
    return '/%{workspace}/' . $self->SUPER::special_http();
}


1;
