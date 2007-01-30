package Kwiki::Cache::Formatter;
use Kwiki::Plugin -Base;
use Storable qw(lock_store lock_retrieve);

const class_id => 'cache_formatter';
field cache_path =>
    -init => '$self->plugin_directory . "/" . $self->hub->pages->current->id';

sub register {
    my $registry = shift;
    $registry->add(
        hook => 'formatter:text_to_parsed',
        pre => 'check_cache',
        post => 'save_cache',
    );
}

sub check_cache {
    my $hook = pop;
    my $cache_path = $hook->hub->cache_formatter->cache_path;
    my $page = $hook->hub->pages->current;
    if (-e $cache_path and -M $cache_path <= -M $page->file_path) {
        $hook->cancel;
        my $data = lock_retrieve $cache_path
          or die;
        return $data;
    }
}

sub save_cache {
    my $hook = pop;
    my $data = $hook->returned;
    lock_store $data, $hook->hub->cache_formatter->cache_path
      or die;
    return $data;
}
