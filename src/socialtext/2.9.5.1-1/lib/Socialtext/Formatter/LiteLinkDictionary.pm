# @COPYRIGHT@
package Socialtext::Formatter::LiteLinkDictionary;
use base 'Socialtext::Formatter::LinkDictionary';

use strict;
use warnings;

use Class::Field qw'field';

field free         => '%{page_uri}';
field interwiki    => '/lite/page/%{workspace}/%{page_uri}%{section}';
field search_query =>
    '/lite/search/%{workspace}?search_term=%{search_term}';
field category_query =>
    '/lite/changes/%{workspace}/%{category}';
field recent_changes_query => '/lite/changes/%{workspace}';
field category             =>
    '/lite/category/%{workspace}/%{category}';
field weblog             =>
    '/lite/changes/%{workspace}/%{category}';
# special_http and attachment are default

1;
