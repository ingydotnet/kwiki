# @COPYRIGHT@
package Socialtext::Formatter::LinkDictionary;

use strict;
use warnings;

=head1 NAME

Socialtext::Formatter::LinkDictionary - A system for formatting links in a workspace

=head1 SYNOPSIS

    # set the viewer's link dictionary
    $hub->viewer->link_dictionary(
        Socialtext::Formattr::LinkDictionary->new()
    );

=head1 DESCRIPTION

A Link Dictionary provides the information necessary to turn a piece of
wikitext that represents a link into HTML of the correct form. Wikitext
includes several types of links within one workspace or between workspaces,
the LinkDictionary formats all of these.

This is the default LinkDictionary, it is designed to be subclassed to allow
alternate HTML outputs from the various link types.

=cut
use Class::Field qw'field';

=head1 LINK TYPES

=head2 free

A free link is a link from one page in a workspace to another page in the
same workspace. See L<Socialtext::Formatter::FreeLink>.

=cut
field free      => 'index.cgi?%{page_uri}';

=head2 interwiki

An interwiki link is a link from one page in a workspace to a page in
a different workspace. It is also used to make anchored links within
and between pages. See L<Socialtext::Formatter::InterWikiLink>.

=cut
field interwiki => '/%{workspace}/index.cgi?%{page_uri}%{section}';

=head2 search_query, category_query, recent_chages_query

Some forms of wikitext create a link to a set of search, category
or recent changes results. 

=cut
field search_query =>
    '/%{workspace}/index.cgi?action=search;search_term=%{search_term}';
field category_query =>
    '/%{workspace}/index.cgi?action=weblog_display;category=%{category}';
field recent_changes_query => '/%{workspace}/index.cgi?action=recent_changes';

=head2 special_http

Wikitext of the form http:text (without the // or host) is used to make
links to actions in workspaces.

=cut
field special_http         => '%{arg1}';

=head2 category

Links to the category display page.

=cut
field category             =>
    '/%{workspace}/index.cgi?action=category_display;category=%{category}';

=head2 weblog

Links to weblog display.

=cut
field weblog =>
    '/%{workspace}/index.cgi?action=weblog_display;category=%{category}';

=head2 attachment

{file} and {image} links to attachments.

=cut
field attachment =>
    '/%{workspace}/index.cgi/%{filename}?action=attachments_download;page_name=%{page_uri};id=%{id}';

=head1 METHODS

=head2 new

Create a new link dictionary object. The object has fields as described
above.

=cut
sub new {
    my $invocant = shift;
    my $class = ref($invocant) || $invocant;
    my $self = { @_ };
    return bless $self, $class;
}

=head2 clone

Take an existing LinkDictionary and make a copy of it, so it can be modified
for other uses. See L<Socialtext::Pages>.

=cut
# from programming perl 3
sub clone {
    my $model = shift;
    my $self  = $model->new(%$model, @_);
    return $self;
}

=head2 format_link

This is where the action happens. Different classes in the formatter
call format_link with parameters that are replaced in the system.
See L<Socialtext::Formatter::WaflPhrase> for examples.

=cut
sub format_link {
    my $self = shift;
    my %p    = @_;

    my $method        = $p{link};
    my $format_string = $self->$method;

    # replace the fields in the format string
    # REVIEW: Is this the right or best way to do this?
    $format_string =~ s/%{(\w+)}/$p{$1} || ''/ge;

    return $format_string;
}

=head1 AUTHOR

Socialtext, Inc., <code@socialtext.com>

=head1 COPYRIGHT & LICENSE

Copyright 2006 Socialtext, Inc., All Rights Reserved.

=cut


1;
