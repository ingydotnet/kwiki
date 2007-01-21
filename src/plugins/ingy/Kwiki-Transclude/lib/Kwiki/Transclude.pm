package Kwiki::Transclude;
use Kwiki::Plugin -Base;
use Kwiki::Installer -base;

our $VERSION = '0.12';

const class_id => 'transclude';
const css_file => 'transclude.css';

sub register {
    my $registry = shift;
    $registry->add(prerequisite => 'cache');
    $registry->add(wafl => transclude => 'Kwiki::Transclude::WAFL');
}

package Kwiki::Transclude::WAFL;
use base 'Spoon::Formatter::WaflPhrase';
use HTML::TreeBuilder;
use LWP::Simple;
use URI;

my $cache_timeout = '1800';
sub to_html {
    my ($url, $info) = $self->parse_arguments;
    my $html = $self->hub->cache->process(
        sub {
            $self->get_transclusion($url, $info);
        },
        $self->hub->transclude->class_id, $url, $self->arguments,
        {-timeout => $cache_timeout},
    );
    return $self->hub->template->process('transclude.html',
        html => $html,
        url => $url,
    );
}

sub get_transclusion {
    my ($url, $info) = @_;
    my $content = $self->lwp_get($url)
      or return;
    my $tree = HTML::TreeBuilder->new_from_content($content)
      or return;
    my $element;
    if ($info->{tag}) {
        $element = $self->find_tag($info, $tree)
          or return;
    }
    else {
        my $body = $self->find_tag({tag => 'body'}, $tree)
          or return;
        $element =
            $self->find_tag({tag => 'wiki'}, $body) ||
            $self->find_tag({tag => 'div', 
                             attr => 'class', 
                             value => 'wiki'}, $body) ||
            $self->find_tag({tag => 'div', 
                             attr => 'id', 
                             value => 'content_pane'}, $body) ||
            $body;
    }
            
    my $html = $element ? $element->as_HTML : '';
    $tree->delete;
    return $self->fixup($html, $url);
}

sub fixup {
    my ($html, $url) = @_;
    my $u = URI->new($url);
    my $host_uri = $u->scheme . '://' . $u->host;
    my $path_uri = $u->scheme . '://' . $u->host . $u->path;
    # Get uri from url
    $html =~ s/((?:action|href|background)=")([\/\"])/$1$host_uri$2/g;
    $html =~ s/((?:action|href|background)=")(?!(?:https?|ftp):)/$1$path_uri/g;
    return $html;
}

sub find_tag {
    my ($info, @elements) = @_;
    my @found = grep $self->match_elem($info, $_), @elements;
    return shift(@found)
      if @found;
    for my $element (@elements) {
        my @sub_elements = grep ref, $element->content_list;
        return unless @sub_elements;
        my $found = $self->find_tag($info, @sub_elements);
        return $found if $found;
    }
    return;
}

sub match_elem {
    my ($info, $elem) = @_;
    my $tag = $info->{tag} or return;
    $tag eq $elem->tag or return;
    my $attr = $info->{attr} or return 1;
    return ($elem->attr($attr) eq $info->{value});
}

sub lwp_get {
    LWP::Simple::get(shift);
}

sub parse_arguments {
    my ($url, $text) = split /\s+/, $self->arguments, 2;

    if ($url =~ /^\w+$/) {
        $url = CGI::url(-full => 1) . "?$url";
    }
    elsif ($url =~ /^(\w+):(\w+)$/) {
        $url = "http://$1.kwiki.org/index.cgi?$2";
    }

    my $info = {};
    for (split(/\s+/, $text)) {
        if (/(.*)=(.*)/) {
            my ($attr, $value) = ($1, $2);
            $value =~ s/^["']?(.*?)["']?$/$1/;
            $info->{attr} = $attr;
            $info->{value} = $value;
        }
        else {
            $info->{tag} = $_;
        }
    }

    return ($url, $info);
}

package Kwiki::Transclude;
__DATA__


__template/tt2/transclude.html__
<div class="transclude">
Content from <a href="[% url %]">[% url %]</a>:<br /><br />
[% html %]
</div>
__css/transclude.css__
.transclude {
    background-color: #eee;
    top-margin: .5em;
}
