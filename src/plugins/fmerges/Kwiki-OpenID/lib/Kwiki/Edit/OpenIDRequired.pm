package Kwiki::Edit::OpenIDRequired;
use strict;

our $VERSION = 0.01;

use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';

const class_id => 'EditOpenIDRequired';
const class_title => 'Require OpenID to edit';

sub register {
    my $registry = shift;
    $registry->add(action => 'edit_noOpenID');
    $registry->add(hook   => 'edit:edit', pre => 'require_openid');
}

sub require_openid {
    my $hook = pop;
    my $req  = $self->hub->load_class('EditOpenIDRequired');
    my $page = $self->pages->current;
    if (! $req->have_OpenID) {
        my $page_uri = $page->uri;
        $hook->cancel;
        return $self->redirect("action=edit_noOpenID&page=$page_uri");
    }
}

sub have_OpenID {
    my $name = $self->hub->users->current->name
            || $self->hub->users->current->oi_url;
    return defined $name;
}

sub edit_noOpenID {
    return $self->render_screen(
        content_pane => 'edit_noOpenID.html',
    );
}

1;

__DATA__

__template/tt2/edit_noOpenID.html__
<!-- BEGIN edit_noOpenID.html -->
<div class="error">
<p>
This web site does not allow anonymous editing.
Please <a href="[% script_name _ "?action=login_openid;page=" _ hub.cgi.page %]">login via OpenID</a> first.
</p>
<p>
</p>
</div>
<!-- END edit_noOpenID.html -->
__template/tt2/edit_button.html__
<!-- BEGIN edit_button.html -->
[% IF hub.pages.current.is_writable %]
[% rev_id = hub.have_plugin('revisions') ? hub.revisions.revision_id : 0 %]
<a href="[% script_name %]?action=edit&page_name=[% page_uri %][% IF rev_id %]&r
evision_id=[% rev_id %][% END %]" accesskey="e" title="Edit This Page">
[% INCLUDE edit_button_icon.html %]
</a>
[% END %]
<!-- END edit_button.html -->
