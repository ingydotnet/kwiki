package Kwiki::Indexer::Regex;
use strict;
use warnings;
use Kwiki::Indexer qw(-Base);
use mixin 'Kwiki::Installer';

our $VERSION = '0.1.1';

const class_id => 'indexer_regex';
const class_title => 'Perl regex Index Engine';

sub register { }

sub init { }

sub perform_search { 
    my $arg = shift;
    [grep {$_->content =~ m{$arg}i and $_->active} $self->hub->pages->all ];
}

1;
__DATA__

=head1 NAME

Kwiki::Indexer::Regex - Kwiki Indexer Dummy module

=head1 SYNOPSIS

kwiki -add Kwiki::Indexer::Regex

=head1 DESCRIPTION

A dummy indexer class.  Doesn't actually do any indexing.  The perform_search
method performs a regex match against all pages in the store.

The B<perform_search> method is based on Brian Ingerson's Kwiki::Search
plugin.

=head1 AUTHOR

Russell Heilling <chewtoy@s8n.net>

=head1 COPYRIGHT

Copyright (c) 2004. Russell Heilling. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
