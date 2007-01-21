# $Id: RecentChangesRSS.pm,v 1.21 2005/11/06 23:47:58 peregrin Exp $
package Kwiki::RecentChangesRSS;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-base';
use POSIX qw(strftime);
use Time::Local;
our $VERSION = '0.07';

const class_id        => 'RecentChangesRSS';
const class_title     => 'RecentChangesRSS';
const screen_template => 'rss_screen.xml';
const config_file     => 'rss.yaml';

sub register {
    my $registry = shift;
    $registry->add( action => 'RecentChangesRSS' );
    $registry->add(
        toolbar  => 'rss_button',
        template => 'rss_button.html',
    );
}

sub RecentChangesRSS {
    use XML::RSS;

    my $display_the_page = $self->config->rss_display_page;

    my %channel_info = (
        link           => $self->config->rss_link,
        copyright      => $self->config->rss_copyright,
        language       => $self->config->rss_language,
        description    => $self->config->rss_description,
        title          => $self->config->rss_title,
        docs           => $self->config->rss_docs,
        generator      => $self->config->rss_generator,
        managingEditor => $self->config->rss_managingEditor,
        webMaster      => $self->config->rss_webMaster,
        category       => $self->config->rss_category,
        image          => $self->config->rss_image,
    );
    my $rss = new XML::RSS( version => '2.0' );
    while ( my ( $key, $value ) = each %channel_info ) {
        $rss->channel( $key => $value );
    }

    my $depth = $self->config->rss_depth;

    my $pages;
    @$pages = sort { $b->modified_time <=> $a->modified_time; }
        $self->pages->all_since( $depth * 1440 );

    $ENV{SERVER_PROTOCOL} =~ m!^(\w+)/!;
    my $protocol = $1;
    foreach my $page (@$pages) {

    #
    # Because we are using RSS 2.0, we are forced to put the author/creator in
    # either the title or description.  Putting the author/creator in <author>
    # is not valid RSS 2.0 because it must include an email address, which we
    # currently don't have for each user.  Perhaps future versions of Kwiki
    # will force users to have an email address.
    # Note: RSS 1.0 does not have this restriction -- it can use <dc:creator>.
    #
        my ( $title, $description );
        if ($display_the_page) {
            $title = $page->title
                . " (last edited by "
                . $page->metadata->edit_by . ")";
            $description = '<![CDATA[' . $page->to_html . ']]>',;
        }
        else {
            $title       = $page->title;
            $description = "Last edited by " . $page->metadata->edit_by;
        }

        $rss->add_item(
            title       => $title,
            description => $description,
            link        => $self->config->rss_link . '?' . $page->uri,
            pubDate     => strftime(
                "%a, %d %b %Y %T %Z",
                localtime( $page->modified_time )
            ),
        );
    }

   #
   # lastBuildDate is the time the content last changed, therefore the time of
   # the latest wiki page...
   # However $@pages is the array of pages since $depth * 1440 and so will be
   # undefined if no page has changes since $depth * 1440.  Otherwise we skip
   # it.
    $rss->channel(
        lastBuildDate => strftime(
            "%a, %d %b %Y %T %Z",
            localtime( $pages->[0]->modified_time )
        )
        )
        if $pages->[0];

    # Set the correct Content-Type header

    $self->hub->headers->content_type('application/xml');

    $self->render_screen(
        xml          => $rss->as_string,
        screen_title => "Changes in the last $depth " . $depth == 1
        ? "day"
        : "days",
    );

}

1;

__DATA__

__config/rss.yaml__
rss_title: a title goes here
rss_description: a short description goes here
rss_link: http://configure.me/
rss_docs: http://blogs.law.harvard.edu/tech/rss
rss_generator: Kwiki::RecentChangesRSS/XML::RSS 0.07
rss_depth: 7
rss_language: en-US
rss_copyright:
rss_managingEditor:
rss_webMaster:
rss_category:
rss_cloud:
rss_ttl:
rss_image:
rss_rating:
rss_textInput:
rss_skipHours:
rss_skipDays:
rss_display_page: 0
__template/tt2/rss_button.html__
<!-- BEGIN rss_button.html -->
<a href="[% script_name %]?action=RecentChangesRSS" accesskey="c" title="RSS">
[% INCLUDE rss_button_icon.html %]
</a>
<!-- END rss_button.html -->
__template/tt2/rss_button_icon.html__
<!-- BEGIN rss_button_icon.html -->
<img src="[% rss_icon %]" alt="rss" />
<!-- END rss_button_icon.html -->
__template/tt2/rss_screen.xml__
[% xml %]
__xml.png__
iVBORw0KGgoAAAANSUhEUgAAACQAAAAOBAMAAAC1GaP7AAAAMFBMVEU9GgL1sYOeQgLmhkL22sfd
XQfcdC/7yaf+/Pt+MgLDUgbupHL+gi7+ZgP+lE/OZiLJkrvQAAAAAWJLR0QAiAUdSAAAAJlJREFU
eNpjdDdgQAX/Gd9+QBP6w8SAAYBC/1YzcBdYr2eYvYG7ACTEAhQ98JVb9vRvBoG/DD+gqhga2Jmd
GRhbYBqBqhjEWPZfYvgg/kEIbhYQsDYw2As0IIxn+PXHCOic/xuQhBYYsScw/A8GCv0xEYA4guf9
BCCLGajRvdwA4ohrN/de7bjAwKrwVYmhg4EBi4cYFDA8BACwrCv4QvvgfAAAAABJRU5ErkJggg==
