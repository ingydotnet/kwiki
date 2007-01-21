package Kwiki::DisableWikiNames;

use 5.008005;
use strict;
use warnings;

use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

our $VERSION = '0.02';

const class_id => 'disable_wiki_names';
const class_title => "Disable WikiNames auto markup";

sub init {
    super;
}

sub register {
    my $registry = shift;
    $registry->add(preload => 'disable_wiki_names');
    $registry->add(hook => 'page:kwiki_link', pre => 'dwn_uri_hook');
}

sub dwn_uri_hook {   ## Adopted from Kwiki::CoolURI
    my $hook = pop;
    $hook->code(undef);
    my ($label) = @_;
    my $page_uri = $self->uri;
    if(!defined $label) {
      qq($page_uri);
    } else {
      my $class = $self->active? '' : ' class="empty"';
      qq(<a href="$page_uri"$class>$label</a>);
    }
}

1;
