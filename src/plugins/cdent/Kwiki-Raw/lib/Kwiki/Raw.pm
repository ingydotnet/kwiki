package Kwiki::Raw;
use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';

const class_id             => 'raw';
const cgi_class            => 'Kwiki::Raw::CGI';

our $VERSION = '0.02';

sub register {
    my $registry = shift;
    $registry->add(action => 'raw');
    $registry->add(toolbar => 'raw_button',
                   template => 'raw_button.html',
                   show_for => 'display',
               );
}

sub raw {
    if ($self->cgi->page_name) {
        $self->hub->headers->content_type('text/plain');
        $self->hub->pages->new_from_name($self->cgi->page_name)->content;
    } else {
        $self->render_screen(
            error_msg => 'raw requires page_name',
        );
    }
}

package Kwiki::Raw::CGI;
use Kwiki::CGI -base;

cgi page_name => -utf8;

package Kwiki::Raw

__DATA__

__template/tt2/raw_button.html__
<!-- BEGIN raw_button -->
<a href="[% script_name %]?action=raw;page_name=[% page_name %]" title="Raw
Wikitext">
[% INCLUDE raw_button_icon.html %]
</a>
<!-- END raw_button -->
__template/tt2/raw_button_icon.html__
Raw
