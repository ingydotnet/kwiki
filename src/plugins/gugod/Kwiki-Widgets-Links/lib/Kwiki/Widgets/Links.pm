package Kwiki::Widgets::Links;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
our $VERSION = '0.01';

const class_id => 'widgets_links';
const class_title => 'Links widget';
const config_file => 'widgets_links.yaml';

sub register {
    my $registry = shift;
    $registry->add(widget => 'widgets_links',
		   template => 'widgets_links.html');
}

sub get_links {
    my @l = @{$self->hub->config->widgets_links};
    map { { title => $l[$_], url => $l[$_+1] } } map { $_ * 2 } 0..$#l/2;
}

__DATA__


__template/tt2/widgets_links.html__
<div id="widgets_links">
<h4>Links</h4>
<ul>
[% FOREACH l = hub.widgets_links.get_links %]
<li><a href="[% l.url %]">[% l.title %]</a></li>
[% END %]
</ul>
</diV>
__config/widgets_links.yaml__
widgets_links:
- Kwiki
- http://kwiki.org
- Perl
- http://perl.org
- CPAN
- http://cpan.org
