package Kwiki::CachedDisplay;
use Kwiki::Plugin -Base;
our $VERSION = '0.06';

const class_id => 'cached_display';

sub register {
    my $reg = shift;
    $reg->add(hook => 'display:display', pre  => 'check_cached');
}

sub check_cached {
    my $hook = pop;
    my $display = $self;
    $self = $display->hub->cached_display;
    my $page = $self->pages->current;
    return unless $page->exists;
    return if (defined $self->config->can('cached_display_ignore') and
	       grep {$page->id} @{$self->config->cached_display_ignore});
    my $html = io->catfile($self->plugin_directory,$page->id)->utf8;
    my $content;

    my $depup = 0;
    if (defined $self->config->can('cached_display_dependencies')){
	for (@{$self->config->cached_display_dependencies}){
	    my $deppage = $self->pages->new_page($_);
	    $depup = 1 if $deppage->modified_time > $html->mtime;
	}
    }

    if($depup or
       !$html->exists or
       ($page->modified_time > $html->mtime)) {
        my $code = $hook->code;
        $content = $code->($display);
        $html->print($content);
    }
    $content ||= $html->all;
    $hook->cancel;
    return $content;
}
