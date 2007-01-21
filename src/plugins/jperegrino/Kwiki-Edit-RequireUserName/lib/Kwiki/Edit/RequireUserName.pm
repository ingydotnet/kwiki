package Kwiki::Edit::RequireUserName;

use warnings;
use strict;
use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';

our $VERSION = '0.02';

const class_id => 'EditRequireUserName';
const class_title => 'Require UserName to edit';

sub register {
  my $registry = shift;
  $registry->add(action   => 'edit_noUserName');
  $registry->add(hook => 'edit:edit', pre => 'require_username');

}

sub require_username {
  my $hook = pop;
  my $req_username_obj = $self->hub->load_class('EditRequireUserName');
  my $page = $self->pages->current;
  if (! $req_username_obj->have_UserName) {
    my $page_uri = $page->uri;
    $hook->cancel();		# don't bother calling Kwiki::Edit::edit
    return $self->redirect("action=edit_noUserName&page_name=$page_uri");
  }
}

sub have_UserName {
  my $current_name   = $self->hub->users->current->name ||
    die "Can't determine current UserName";
  my $anonymous_name = $self->config->user_default_name ||
    die "Can't determine local name of anonymous user";  # set in
                                                         # config/user.yaml
  return ($current_name ne $anonymous_name);
}

sub edit_noUserName {
    return $self->render_screen(
        content_pane => 'edit_noUserName.html',
    );
}

1;

__DATA__

__template/tt2/edit_noUserName.html__
<!-- BEGIN edit_noUserName.html -->
<div class="error">
<p>
This web site does not allow anonymous editing.  Please go to <a
href="?action=user_preferences">User Preferences</a> button and create
a UserName for yourself.
</p>
<p>
</p>
</div>
<!-- END edit_noUserName.html -->
__template/tt2/edit_button.html__
<!-- BEGIN edit_button.html -->
[% IF hub.pages.current.is_writable %]
[% rev_id = hub.have_plugin('revisions') ? hub.revisions.revision_id : 0 %]
<a href="[% script_name %]?action=edit&page_name=[% page_uri %][% IF rev_id %]&revision_id=[% rev_id %][% END %]" accesskey="e" title="Edit This Page">
[% INCLUDE edit_button_icon.html %]
</a>
[% END %]
<!-- END edit_button.html -->
