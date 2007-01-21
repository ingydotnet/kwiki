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
