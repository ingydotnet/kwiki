package Kwiki::RecentChangesRSS;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';
our $VERSION = '0.10';

const class_id => 'recent_changes_rss';
const class_title => 'Recent Changes';
const css_file => 'recent_changes.css';

sub register {
    my $registry = shift;
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
    $self->hub->load_class('cache')->process(
        sub { $self->generate($pages) }, 'recent_changes_rss', int(time / 300)
    );
}

sub generate {
    require XML::RSS;
    my $pages = shift;
    my $rss = new XML::RSS (version => '1.0');
    $rss->channel(
        title        => $self->config->site_title,
        link         => $self->config->site_url,
        description  => $self->config->site_description,
#         dc => {
#             date       => '2000-08-23T07:00+00:00',
#             subject    => $self->config->site_title,
#             creator    => 'scoop@freshmeat.net',
#             publisher  => 'scoop@freshmeat.net',
#             rights     => 'Copyright 1999, Freshmeat.net',
#             language   => 'en-us',
#         },
#         syn => {
#             updatePeriod     => "hourly",
#             updateFrequency  => "1",
#             updateBase       => "1901-01-01T00:00+00:00",
#         },
#         taxo => [
#             'http://dmoz.org/Computers/Internet',
#             'http://dmoz.org/Computers/PC'
#         ]
    );

#     $rss->image(
#         title  => "freshmeat.net",
#         url    => "http://freshmeat.net/images/fm.mini.jpg",
#         link   => "http://freshmeat.net",
#         dc => {
#             creator  => "G. Raphics (graphics at freshmeat.net)",
#         },
#     );
    
    for my $page (@$pages) {
        $rss->add_item(
            title       => $page->name,
            link        => $self->config->site_url . '?' . $page->uri,
            content => $page->to_html,
        );
    }
}

1;

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
<!-- BEGIN recent_changes_rss_button.html -->
<a href="[% script_name %]?action=recent_changes_rss" accesskey="c" title="Recent Changes RSS">
[% INCLUDE recent_changes_rss_button_icon.html %]
</a>
<!-- END recent_changes_rss_button.html -->
__template/tt2/recent_changes_rss_button_icon.html__
<!-- BEGIN recent_changes_rss_button_icon.html -->
Changes RSS
<!-- END recent_changes_rss_button_icon.html -->
__icons/gnome/template/recent_changes_button_rss_icon.html__
<!-- BEGIN recent_changes_rss_button_icon.html -->
<img src="icons/gnome/image/rss.gif" alt="Changes RSS" />
<!-- END recent_changes_rss_button_icon.html -->
__icons/gnome/image/rss.gif__
