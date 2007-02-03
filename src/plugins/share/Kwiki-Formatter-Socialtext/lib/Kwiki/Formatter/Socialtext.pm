package Kwiki::Formatter::Socialtext;
use Kwiki::Formatter -Base;

use Socialtext::Formatter;
use Socialtext::Formatter::Viewer;

sub text_to_html {
    my $text = shift;
    # we know this will blow up, fix it later
    $self->hub->formatter(Socialtext::Formatter->new());
    my $viewer = Socialtext::Formatter::Viewer->new(hub => $self->hub);
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
