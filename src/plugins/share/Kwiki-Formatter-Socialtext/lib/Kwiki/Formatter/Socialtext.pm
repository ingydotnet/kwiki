package Kwiki::Formatter::Socialtext;
use Kwiki::Plugin -Base;

use Socialtext::Mock;
use Socialtext::Formatter;
use Socialtext::Formatter::Viewer;
use Kwiki::CGI;
no warnings 'redefine';

const class_id => 'formatter_socialtext';

sub register {
    my $registry = shift;
    $registry->add(preload => 'formatter_socialtext');
}

sub init {
    $self->hub->config->formatter_class(__PACKAGE__);  
}

sub text_to_html {
    my $text = shift;
    my $hub = Bogus::Hub->new();
    $hub->formatter(Socialtext::Formatter->new());
    my $viewer = Socialtext::Formatter::Viewer->new(hub => $hub);
    return $viewer->text_to_html($text);
}

package Kwiki::CGI;
sub set_default_page_name {
    my $page_name = shift;
    $page_name = '' if $page_name and $page_name =~ /[^$ALPHANUM\_]/;
    $page_name ||= $self->hub->config->main_page;
}

package Socialtext::Page;
sub name_to_id {
    my $name = shift;
    $name = lc($name);
    $name =~ s/[^\w]/_/g;
    $name =~ s/_+/_/g;
    return $name;
}

package Kwiki::Pages;
sub title_to_disposition {
    my $page_name = shift; 
    return (
        qq{title="$page_name"},
        Socialtext::Page->name_to_id($page_name),
    );
}

package Socialtext::Formatter;
sub _add_external_wafl { }

package Bogus::Hub;
use Spoon::Base -base;

field 'formatter';
field 'current_workspace' => -init => 'Bogus::Workspace->new';
field 'pages' => -init => 'Kwiki::Pages->new';
field 'viewer' => -init => 'Socialtext::Formatter::Viewer->new';

package Bogus::Workspace;
use Spoon::Base -base;

const external_links_open_new_window => 0;
const name => 'kwiki';
