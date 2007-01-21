package Kwiki::HanConvert;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
use Encode::HanConvert qw(simple trad);
our $VERSION = '0.01';

const class_id => 'han_convert';
const cgi_class => 'Kwiki::HanConvert::CGI';

sub register {
    my $registry = shift;
    $registry->add(hook => 'display:display', post => 'convert');
    $registry->add(toolbar => 'han_convert_button',
                   template => 'han_convert_button.html');
}

sub convert {
    my $hook = pop;
    my $display = $self;
    $self = $display->hub->han_convert;
    my ($page_content) = $hook->returned;
    my $ret;
    if($self->cgi->mode eq 'trad') {
        $ret = trad($page_content);
    } elsif($self->cgi->mode eq 'simp') {
        $ret = simple($page_content);
    } else {
        $ret = $page_content;
    }
    return $ret;
}

package Kwiki::HanConvert::CGI;
use base 'Kwiki::CGI';
cgi mode => qw(-utf8);

package Kwiki::HanConvert;

__DATA__


__template/tt2/han_convert_button.html__
<a href="[% script_name %]?[% page_uri %]&mode=simp" title="Convert To Simplified Chinese">Simp</a>,
<a href="[% script_name %]?[% page_uri %]&mode=trad" title="Convert To Traditional Chinese">Trad</a>
