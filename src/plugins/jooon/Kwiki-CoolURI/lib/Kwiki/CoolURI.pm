package Kwiki::CoolURI;
use strict;
use warnings;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

our $VERSION = '0.04';

const class_id => 'cool_uri';
const class_title => "Cool URIs don't change";

sub init {
    super;
    $self->hub->template->add_path('plugin/cool_uri/template/tt2');
    my $formatter = $self->hub->load_class('formatter');
    $formatter->table->{forced} = 'Kwiki::CoolURI::ForcedLink';
}

sub register {
    my $registry = shift;
    $registry->add(preload => 'cool_uri');
    $registry->add(hook => 'page:kwiki_link', pre => 'uri_hook');
}

sub uri_hook {
    my $hook = pop;
    $hook->code(undef);
    my ($label) = @_;
    my $page_uri = $self->uri;
    $label = $self->title
      unless defined $label;
    my $class = $self->active
      ? '' : ' class="empty"';
    qq(<a href="$page_uri"$class>$label</a>);
}

package Kwiki::CoolURI::ForcedLink;
use base 'Kwiki::Formatter::ForcedLink';

sub html {
    $self->matched =~ $self->pattern_start;
    my $target = $1;
    my $text = $self->escape_html($target);
    my $class = $self->hub->pages->new_from_name($target)->exists
      ? '' : ' class="empty"';
    return qq(<a href="$target"$class>$target</a>);
}

package Kwiki::CoolURI;
__DATA__

__plugin/cool_uri/template/tt2/home_button.html__
<a href="[% main_page %]" accesskey="h" title="Home Page">
[% INCLUDE home_button_icon.html %]
</a>
