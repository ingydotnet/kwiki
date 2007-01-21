package Kwiki::Spaces;
use Kwiki::Plugin -Base;
use Kwiki::Installer -base;
use Kwiki ':char_classes';

our $VERSION = '0.01';

const class_id    => 'spaces';
const class_title => 'Spaces';

sub init {
    super;
    my $formatter = $self->hub->load_class('formatter');
    $formatter->table->{forced} = 'Kwiki::Spaces::ForcedLink';
    $formatter->table->{titlehyper} = 'Kwiki::Spaces::TitledLink';
}

sub register {
    my $registry = shift;
    $registry->add(preload => 'spaces');
    $registry->add(hook => 'cgi:set_default_page_name', pre => 'page_name_hook');
}

sub page_name_hook {
    my $hook = pop;
    $hook->code(undef);
    my $page_name = shift;
    $page_name = '' if $page_name and $page_name =~ /[^ $WORD]/;
    $page_name ||= $self->hub->config->main_page;
}

package Kwiki::Spaces::ForcedLink;
use base 'Kwiki::Base';
use base 'Kwiki::Formatter::ForcedLink';
use Kwiki ':char_classes';

const pattern_start => qr/\[\[([ $WORD]+)\]\]/;

sub html {
    $self->matched =~ $self->pattern_start;
    my $target = $1;
    my $link = $target;
    my $script = $self->hub->config->script_name;
    my $text = $self->escape_html( $target );
    my $page = $self->hub->pages->new_from_name($target);
    return $target unless $page;
    my $class = $page->exists
      ? '' : ' class="empty"';
    return qq(<a href="$script?$link"$class>$target</a>);
}

package Kwiki::Spaces::TitledLink;
use base 'Kwiki::Base';
use base 'Kwiki::Formatter::TitledHyperLink';
use Kwiki ':char_classes';

const pattern_start => qr{\[\[([^\|]+)\|([^\]]+)\]\]};

sub html {
    my $text = $self->escape_html($self->matched);
    my ($link, $label) = ($text =~ $self->pattern_start);
    return qq(<a href="$link">$label</a>)
	if $link =~ qr{\w+:(?://|\?)\S+};
    my $page = $self->hub->pages->new_from_name($link);
    return $label unless $page;
    return $page->kwiki_link($label);
}

package Kwiki::Spaces;
