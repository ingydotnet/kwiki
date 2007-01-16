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
__DATA__

=head1 NAME

Kwiki::Indexer - A Base Class for Kwiki Indexing Plugins

=head1 SYNOPSIS

kwiki -add Kwiki::Indexer::Subclass

=head1 DESCRIPTION

B<Kwiki::Indexer> is a base class for implementing plugins that index Kwiki
sites.

This distribution ships with an example plugin B<Kwiki::Indexer::Regex>.
This plugin doesn't actually index the site, it simply defines a 
B<perform_search> method that does a regex search across all active pages
in the Kwiki (based the search implemented in Brian Ingerson's Kwiki::Search
plugin).

=head1 AUTHOR

Russell Heilling <chewtoy@s8n.net>

=head1 COPYRIGHT

Copyright (c) 2004. Russell Heilling. All rights reserved.

    This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
