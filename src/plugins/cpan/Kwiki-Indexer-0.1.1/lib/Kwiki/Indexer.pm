package Kwiki::Indexer;
use strict;
use warnings;
use Kwiki::Plugin qw(-Base);
use mixin 'Kwiki::Installer';

our $VERSION = '0.1.1';

const class_id => 'indexer';

sub register {
    my $registry = shift;
    $registry->add(page_hook_store => 'index');
}

sub init {
    $self->use_class('pages');
    if ($self->empty) {
	$self->generate;
	$self->index;
    }
}

sub empty {
    io($self->plugin_directory)->empty;
}

sub generate {
    my $dir = $self->plugin_directory;
    umask 0000;
    chmod 0777, $dir;
}

sub index { }

sub perform_search { }

1;
