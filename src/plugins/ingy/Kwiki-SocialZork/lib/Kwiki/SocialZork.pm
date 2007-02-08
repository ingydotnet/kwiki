# ToDo
#

# Save backlinks
# Split page with content
# * move to socialzork.kwiki.org
# * takahashi
# * multiuser
#
package Kwiki::SocialZork;
use Kwiki::Plugin -Base;
use JSON::Syck;
use YAML::Syck;
use Socialtext::Resting;

const class_id => 'social_zork';
const cgi_class => 'Kwiki::SocialZork::CGI';
field rest => -init => '$self->create_rest';

sub register {
    my $registry = shift;
    $registry->add(preload => 'social_zork');
    $registry->add(action => 'display');
    $registry->add(action => 'load_page');
    $registry->add(action => 'get_text');
    $registry->add(action => 'save_text');
}

sub init {
    super;
    $self->hub->javascript->add_file('Ajax.js');
    $self->hub->javascript->add_file('JSON.js');
    $self->hub->javascript->add_file('SocialZork.js');
}

sub display {
    my $page = $self->pages->new_from_name($self->config->main_page);
    $self->template->process($self->screen_template,
        current_page_id => $self->config->main_page,
        site_title => 'SocialZork',
    );
}

sub get_text {
    my $page_id = $self->cgi->page_nid;
    my $page_path = $self->plugin_directory . '/' . $page_id;
    my $page = io($page_path);
    my $return = $page->exists ? $page->all : '';
    $page = $self->hub->pages->new_page($page_id);
    if ($page->exists) {
        $return .= "----\n" . $page->content;
    }
    return $return;
}

sub save_text {
    my $page_id = $self->cgi->page_nid;
    my $page_path = $self->plugin_directory . '/' . $page_id;
    my $page = io($page_path);
    my $content = $self->cgi->content;
    my ($yaml, $wiki) = split(/----\n/, $content, 2);
    eval {
        my $data = YAML::Syck::Load($yaml);
        $page->print($yaml);
        $self->save_backlinks($data, $page_id);
        if ($wiki) {
            $page = $self->hub->pages->new_page($page_id);
            $page->content($wiki);
            $page->store_content();
        }
    };
    return $@ ? "not ok:\n$@" : "ok";
}

my %reverse = (qw(
    N S
    S N
    E W
    W E
    NW SE
    SE NW
    NE SW
    SW NE
));
sub save_backlinks {
    my $data = shift;
    my $back_id = shift;
    my $controls = $data->{controls} or return;
    for my $direction (keys %$controls) {
        my $page_id = $controls->{$direction};
        my $page_path = $self->plugin_directory . '/' . $page_id;
        my $page = io($page_path);
        my $data2 = $page->exists ? YAML::Syck::LoadFile($page_path) : {};
        $data2 ||= {};
        $data2->{controls}{$reverse{$direction}} = $back_id;
        $page->print(YAML::Syck::Dump($data2));
    }
}

sub load_page {
    my $page_id = $self->cgi->page_nid;
    my $payload = {};
    my $page = $self->hub->pages->new_page($page_id);
    if ($page->exists) {
        $payload->{local_html} = $page->to_html;
    }
    my $page_path = $self->plugin_directory . '/' . $page_id;
    if (-e $page_path) {
        my $hash;
        eval {
            $hash = YAML::Syck::LoadFile($page_path);
        };
        if ($hash) {
            for my $k (keys %$hash) {
                $payload->{$k} = $hash->{$k};
            }
        }
    }
    my $Rester = Socialtext::Resting->new(
        username => $self->config->social_zork_username,
        password => $self->config->social_zork_password,
        server   => $self->config->social_zork_server,
    );
    $Rester->workspace($self->config->social_zork_workspace);
    $Rester->accept('text/html');
    my $page_html = $Rester->get_page($page_id);
    unless ($page_html =~ /not found$/) {
        $payload->{socialtext_html} = $page_html;
    } 
    
    return JSON::Syck::Dump($payload);
}

BEGIN { $INC{'Kwiki/Theme/SocialZork.pm'} = 'Kwiki/Theme/SocialZork.pm' }
package Kwiki::Theme::SocialZork;
use Kwiki::Theme -Base;

const theme_id => 'social_zork';
const class_title => 'SocialZork Theme';

package Kwiki::SocialZork::CGI;
use Kwiki::CGI -Base;;

cgi 'page_nid';
cgi 'content' => qw(-utf8 -newlines);

1;
