use strict;
use warnings;
use Test::More tests => 8;
use Kwiki::Test;

use lib '../lib';

# so init in Kwiki::Purple is followed
$ENV{GATEWAY_INTERFACE} = 1;

my $kwiki = Kwiki::Test->new->init(['Kwiki::Purple::Sequence',
    'Kwiki::Purple']);

# do it again to active hooks
$kwiki = Kwiki::Test->new;
$kwiki->add_plugins(['Kwiki::Purple::Sequence', 'Kwiki::Purple']);
my $hub = $kwiki->hub;

# store a page
{
    my $pages = $hub->pages;
    my $page = $pages->new_from_name('PurplePage');
    $page->content("\n\n== This is header one\n\nThis is paragraph two\n\n" .
        "* this is list one\n* this is list two\n\n");
    $page->store;
}

# check raw retrieval
{
    my $purple = $hub->purple;
    my $content1 = $purple->retrieve_node(1, 'raw');
    my $content2 = $purple->retrieve_node(2, 'raw');
    my $content3 = $purple->retrieve_node(3, 'raw');
    my $content4 = $purple->retrieve_node(4, 'raw');

    like($content1,
        qr{This is header one},
        'got right raw node one');
    like($content2,
        qr{This is paragraph two},
        'got right raw node two');
    like($content3,
        qr{this is list one},
        'got right raw node three');
    like($content4,
        qr{this is list two},
        'got right raw node four');
}

# check html retrieval
{
    my $purple = $hub->purple;
    my $content1 = $purple->retrieve_node(1, 'html');
    my $content2 = $purple->retrieve_node(2, 'html');
    my $content3 = $purple->retrieve_node(3, 'html');
    my $content4 = $purple->retrieve_node(4, 'html');

    # this extra space before the non breaking space is a 
    # less than good thing...but is necessary for the time
    # being for a variety of reasons
    like($content1,
        qr{<span class="transclusion">This is header one},
        'got right html node one');
    like($content2,
        qr{<span class="transclusion">This is paragraph two},
        'got right html node two');
    like($content3,
        qr{<span class="transclusion">this is list one},
        'got right html node three');
    like($content4,
        qr{<span class="transclusion">this is list two},
        'got right html node four');
}

$kwiki->cleanup;
