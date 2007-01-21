package Kwiki::OpenSearch::Service;
use strict;
our $VERSION = 0.02;

use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';
use Kwiki ':char_classes';

const class_id    => 'opensearch_service';
const class_title => 'OpenSearch Service';
const cgi_class   => 'Kwiki::OpenSearch::Service::CGI';
const config_file => 'opensearch_service.yaml';

sub register {
    $self->hub->config->add_file($self->config_file);
    my $registry = shift;
    $registry->add(action => "opensearch_service");
    $registry->add(action => "opensearch_description");
}

sub opensearch_service {
    $self->hub->headers->content_type('application/rss+xml');
    $self->template_process(
	"opensearch_rss.xml",
	pages => $self->perform_opensearch_service,
	q     => $self->cgi->q,
    );
}

sub opensearch_description {
    $self->hub->headers->content_type('application/opensearch+xml');
    $self->template_process("opensearch_description.xml");
}

# XXX copied from Kwiki::LiveSearch
sub perform_opensearch_service {
    my $query = $self->cgi->q;
    $query =~ s/[^$WORD\ \-\.\^\$\*\|\:]//g;
    [
	grep {
	    $_->content =~ m{$query}i and $_->active;
	} $self->pages->all
    ]
}

package Kwiki::OpenSearch::Service::CGI;
use Kwiki::CGI '-base';

cgi 'q';

package Kwiki::OpenSearch::Service;
1;
__DATA__


__template/tt2/opensearch_rss.xml__
<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0" xmlns:openSearch="http://a9.com/-/spec/opensearch/1.1/">
<channel>
<title>[% site_title | html %]: [% q | html %]</title>
[% USE kwiki = url(script_name) -%]
<link>[% kwiki(action="search", search_term=q) %]</link>
<description>Kwiki search for [% q | html %]</description>
<openSearch:totalResults>[% pages.size %]</openSearch:totalResults>
<openSearch:startIndex>1</openSearch:startIndex>
<openSearch:itemsPerPage>20</openSearch:itemsPerPage>
[% FOREACH page = pages %]
<item>
<title>[% page.title | html %]</title>
<link>[% script_name %]?[% page.uri %]</link>
</item>
[%- END %]
</channel>
</rss>
__template/tt2/opensearch_description.xml__
<?xml version="1.0" encoding="UTF-8"?>
<OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/">
  <Url type="application/rss+xml" template="[% script_name %]?action=opensearch_service&amp;q={searchTerms}" />
  <ShortName>[% site_title | html %]</ShortName>
  <LongName>[% site_title | html %]</LongName>
  <Description>[% description | html %]</Description>
  [% IF tags %]<Tags>[% tags %]</Tags>[% END %]
  [% IF logo_image.match("https?://") %]<Image>[% logo_image %]</Image>[% END %]
  <Query role="example" searchTerms="[% sample_search %]" />
  <Developer>[% developer | html %]</Developer>
  <Contact>[% contact | html %]</Contact>
  [% IF attribution %]<Attribution>[% attribution %]</Attribution>[% END %]
  [% IF syndication_right %]<SyndicationRight>[% syndication_right %]</SyndicationRight>[% END %]
  [% IF adult_content %]<AdultContent>[% adult_content %]</AdultContent>[% END %]
</OpenSearchDescription>
__config/opensearch_service.yaml__
sample_search: Kwiki
developer: Anonymous Gnome
contact: kwiki@example.com
description:
tags:
attribution:
syndication_right:
adult_content:
