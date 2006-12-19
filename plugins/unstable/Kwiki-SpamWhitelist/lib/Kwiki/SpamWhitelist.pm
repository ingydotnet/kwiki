package Kwiki::SpamWhitelist;
use Kwiki::Plugin -Base;
use Kwiki::Formatter;

const class_id => 'spam_whitelist';

sub register {
    my $registry = shift;
    $registry->add(preload => $self->class_id);
}

package Kwiki::SpamWhitelist::Mixin;
use mixin 'Spoon::IndexList';
use IO::All;

sub spam_link {
    my ($url, $title) = @_;
    return unless $url =~ s/^https?:\/\/([^\/]+)/spam:\/\/$1/i;
    my $domain = $1;
    my $whitelist = 
      $self->hub->spam_whitelist->plugin_directory . '/whitelist';
    my $index = $self->index_list($whitelist);
    my $ok = eval { $index->{$domain} };
    return 'spam' if $@;
    return if $ok;
#     return if $index->{$domain};
    my $spam_link = qq{<span style="font-weight: bold; background-color: red">&lt;$url&gt;</span>};
    $spam_link = qq{<span>$title</span>$spam_link}
      unless $title =~ /^http/i;
    return $spam_link;
}

package Kwiki::Formatter::TitledHyperLink;
use mixin 'Kwiki::SpamWhitelist::Mixin';
no warnings;

sub html {
    my $text = $self->escape_html($self->matched);
    my ($title1, $target, $title2) = ($text =~ $self->pattern_start);
    $title1 = '' unless defined $title1;
    $title2 = '' unless defined $title2;
    $target =~ s{^\w+:(?!//)}{};
    my $title = $title1 . ' ' . $title2;
    $title =~ s/^\s*(.*?)\s*$/$1/;
    $title = $target 
      unless $title =~ /\S/;
    return $self->spam_link($target, $title) ||
           qq(<a href="$target">$title</a>);
}

package Kwiki::Formatter::HyperLink;
use mixin 'Kwiki::SpamWhitelist::Mixin';

sub html {
    my $text = $self->escape_html($self->matched);
    return $text if $text =~ s/^!//;
    return qq(<img src="$text" />)
      if $text =~ /(?:jpe?g|gif|png)$/i;
    my $target = $text;
    return $self->spam_link($target, $text) ||
           qq(<a href="$target">$text</a>);
}
