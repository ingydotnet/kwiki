package Kwiki::Search::Spotlight;
use Kwiki::Search -Base;
our $VERSION = '0.01';

sub register {
    super;
    my $reg = shift;
    $reg->add(hook => 'page:store', post => 'update_index');
}

sub update_index {
    my $search = $self->hub->search;
    my $page_name = $self->id;
    my $dir = $search->plugin_directory;
    io($dir)->mkpath;
    system "/bin/cp database/${page_name} ${dir}/${page_name}.txt";
}

sub perform_search {
    my $search = $self->cgi->search_term;
    my $dir = io($self->plugin_directory)->absolute;
    [ map {
        s/$dir\///;
        s/\.txt$//;
        $self->hub->pages->new_page($_);
    } split(/\n/,`/usr/bin/mdfind -onlyin $dir "$search"`)];
}
