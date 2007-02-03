package Kwiki::Formatter::Socialtext;
use Kwiki::Formatter -Base;

use Socialtext::Formatter;
use Socialtext::Formatter::Viewer;

sub text_to_html {
    my $text = shift;
    my $hub = Bogus::Hub->new();
    $hub->formatter(Socialtext::Formatter->new());
    my $viewer = Socialtext::Formatter::Viewer->new(hub => $hub);
    return $viewer->text_to_html($text);
}

no warnings 'redefine';

sub Socialtext::Page::name_to_id {
    return '';
}

sub Kwiki::Pages::title_to_disposition {
    return "bugger off";
}

sub Socialtext::Formatter::_add_external_wafl { }

package Bogus::Hub;
use Spoon::Base -base;

field 'formatter';
field 'current_workspace' => -init => 'Bogus::Workspace->new';
field 'pages' => -init => 'Kwiki::Pages->new';

package Bogus::Workspace;
use Spoon::Base -base;

const external_links_open_new_window => 0;
