package Kwiki::RecentChangesRSS;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
our $VERSION = '0.10';

const class_id => 'recent_changes_rss';
const css_file => 'recent_changes.css';
const config_file => 'recent_changes_rss.yaml';

sub register {
    my $registry = shift;
    $registry->add(prerequisite => 'cache');
    $registry->add(action => 'recent_changes_rss');
    $registry->add(toolbar => 'recent_changes_rss_button', 
                   template => 'recent_changes_rss_button.html',
                   show_for => ['recent_changes'],
                  );
}

sub recent_changes_rss {
    my $depth = 15;
    my $pages;
    @$pages = sort { 
        $b->modified_time <=> $a->modified_time 
    } $self->pages->recent_by_count($depth);
    $self->hub->headers->content_type('application/xml; charset=utf-8');
    $self->hub->cache->process(
        sub { $self->generate($pages) }, 'recent_changes_rss', int(time / 120)
    );
}

sub generate {
    require XML::RSS;
    require DateTime;
    my $pages = shift;
    my $rss = new XML::RSS (version => '1.0');
    my $datetime = @$pages 
    ? DateTime->from_epoch( epoch => $pages->[0]->metadata->edit_unixtime )
    : DateTime->now;
    $rss->channel(
        title        => $self->config->site_title,
        link         => $self->config->site_url,
        description  => $self->config->site_description,
        dc => {
            date       => $datetime->iso8601 . '+00:00',
        },
    );

    $self->config->script_name(
        $self->config->site_url . $self->config->script_name
    );
    for my $page (@$pages) {
        my $html = '<![CDATA[' . $page->to_html . ']]>';
        # $self->utf8_decode($html);
        $rss->add_item(
            title       => $page->title,
            link        => $self->config->site_url . '?' . $page->uri,
            description => $html,
            dc => {
                date => DateTime->from_epoch( epoch =>
                    $page->metadata->edit_unixtime )->iso8601 . '+00:00',
                creator => $page->metadata->edit_by,
            }
        );
    }
    $rss->as_string;
}

__DATA__

=head1 NAME 

Kwiki::RecentChangesRSS - Kwiki Recent Changes RSS Plugin

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Brian Ingerson <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2004. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
__config/recent_changes_rss.yaml__
site_description: The Kwiki Wiki
site_url: http://www.kwiki.org/
__template/tt2/recent_changes_rss_button.html__
<a href="[% script_name %]?action=recent_changes_rss" accesskey="c" title="Recent Changes RSS">
[% INCLUDE recent_changes_rss_button_icon.html %]
</a>
__template/tt2/recent_changes_rss_button_icon.html__
Changes RSS
__icons/gnome/template/recent_changes_rss_button_icon.html__
<img src="icons/gnome/image/rss.gif" alt="Changes RSS" />
__icons/gnome/image/rss.gif__
R0lGODlhJAAOAMQAAPrr4NBqJeWEQ8JQBPzj0v+6f+NdBPLCofz36/BjBf+GNfHUwOe9od+ieP/X
tpxISP+jZtRhFOxwHf9yFe3Jsb90SP9wEf98JPRkBZxIAP+aV30zAv/IpD8aAf////9mACH5BAAA
AAAALAAAAAAkAA4AQAX/IMCNZGme6ClpX/tNDlI13iJYymVJQj0oiglGgCAMMK7PhuWCAR6BhaeS
4Ewzg0zGcPA0sFpDUskcI1uYMyZhwFhc6/a4tUxaDoS8Q/O+cAAICAsXLwyARQpzdU0OHo4AFRsJ
Ew1SHg4KFhaVjnuKZR8WBQwbBhcMDBEQFAQAC5EDGqyukRlji00Xum8uFhc5E72/F8Gfdo0UFB4A
Eh8FHgwNDRQRCRAeFA0MFBViSbgvCzJEABsRzwgcEBdp1wgU62ffoBPihpARaAIVygzeAfyw5Zt3
zMODCF0YSHAAwIEDAlcOiHjoRRLBJBKyJPiQIEyEDA8ybDjyIULIByPlDdEZ0KGly5cwY8qUGQIA
Ow==
