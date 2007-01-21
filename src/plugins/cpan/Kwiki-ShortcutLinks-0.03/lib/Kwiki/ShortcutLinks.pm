package Kwiki::ShortcutLinks;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-base';

#use Kwiki::ShortcutLinks::Config;

our $VERSION = 0.03;

const class_title => 'Shortcut Links';
const class_id    => 'shortcut_links';

field shortcuts => undef;

sub register {
    my $registry = shift;

    my %config = Kwiki::ShortcutLinks::Config->new->all;
    
    foreach my $key (keys %config) {
	$registry->add(wafl => $key => 'Kwiki::ShortcutLinks::Wafl');
	$registry->add(shortcut_links => $key => $config{$key});
    }
}

package Kwiki::ShortcutLinks::Wafl;
use Spoon::Formatter ();
use base 'Spoon::Formatter::WaflPhrase';

sub html {
    my $text = $self->arguments;
    my $key  = $self->method;
    my $shortcut = $self->hub->registry->lookup->{shortcut_links}{$key}[1];

    my ($url_prefix, $link_prefix) = ($shortcut =~ /^(\S+)\s*(.*)?$/);
    my ($url_param,  $link_text)   = ($text =~ /\A(.+?)(?:\|(.*))?\Z/);

    $link_text ||= ($link_prefix ? "$link_prefix " : '')
                 . $self->html_escape($url_param);

    my $url = $url_prefix;
    $url_param = $self->uri_escape($url_param);
    $url .= "%s" unless ($url =~ /%s/);
    $url =~ s/%s/$url_param/g;

    qq{<a href="$url">$link_text</a>};
}

package Kwiki::ShortcutLinks::Config;
use Spoon::Config '-Base';

const class_title => 'Shortcut Links Configuration';
const class_id => 'shortcut_links_config';
const config_file => 'shortcuts.yaml';

sub default_configs { $self->config_file }
sub default_config  { return { }; }

package Kwiki::ShortcutLinks;

1;

__DATA__


__!shortcuts.yaml__
google: http://www.google.com/search?q=
googleuk: http://www.google.co.uk/search?q=
__!extra_shortcuts.yaml__
# Cut-n-paste into shortcuts.yaml as needed
# Thanks to Alexander Goller for these
acron: http://www.chemie.de/tools/acronym.php3?language=e&acronym=%s
altavista: http://www.altavista.com/cgi-bin/query?pg=q&kl=XX&stype=stext&q=%s
cpan: http://search.cpan.org/search?mode=all&query=%s
ctan: http://www.ctan.org/tools/filesearch?action=/search/&filename=%s
dmoz: http://search.dmoz.org/cgi-bin/search?search=%s
docbook: http://www.docbook.org/tdg/en/html/%s.html
foldoc: http://foldoc.doc.ic.ac.uk/foldoc/foldoc.cgi?query=%s
freshmeat: http://freshmeat.net/search/?q=%s
google: http://www.google.com/search?q=%s&ie=UTF-8&oe=UTF-8
googlegroups: http://groups.google.com/groups?oi=djq&as_q=%s
googleimages: http://images.google.com/images?q=%s
googlefl: http://www.google.com/search?q=%s&btnI=I%27m+Feeling+Lucky&ie=UTF-8&oe=UTF-8
googlenews: http://news.google.com/news?q=%s&ie=UTF-8&oe=UTF-8
imdb: http://imdb.com/Find?%s
dict: http://dict.leo.org/?search=%s
sourceforge: http://sourceforge.net/search/?type_of_search=soft&exact=0&words=%s
wikipedia: http://www.wikipedia.org/w/wiki.phtml?search=%s&go=Go
