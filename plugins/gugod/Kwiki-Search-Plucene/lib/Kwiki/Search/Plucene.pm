package Kwiki::Search::Plucene;
use Kwiki::Search -Base;
use Plucene::Simple;
our $VERSION = '0.01';

field plucy => {},
    -init => q{Plucene::Simple->open($self->index_path)};

sub register {
    super;
    my $reg = shift;
    $reg->add(hook => 'page:store', post => 'update_index');
}

sub perform_search {
    [map {$self->pages->new_page($_)} $self->plucy->search($self->cgi->search_term)]
}

sub index_path {
    $self->plugin_directory . '/plucene_index';
}

sub update_index {
    my $plugin = $self->hub->search;
    $plugin->plucy->add($self->id => {text => $self->content});
    $plugin->plucy->optimize;
}

=head1 NAME

Kwiki::Search::Plucene - Plucene powered Kwiki search engine

=head1 DESCRIPTION

This plugin is intend to be an alternative of Kwiki::Search, which use
a simple 'grep' upon search, and will be slow after the number of
pages grow larger and larger.

It use L<Plucene::Simple> to index page content upon saving.  Plucene is
a Perl port of the Lucene search engine.

=head1 COPYRIGHT

Copyright 2005 by Kang-min Liu <gugod@gugod.org>.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See <http://www.perl.com/perl/misc/Artistic.html>

=cut
