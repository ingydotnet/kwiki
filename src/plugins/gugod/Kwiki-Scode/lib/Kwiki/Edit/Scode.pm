package Kwiki::Edit::Scode;
use Kwiki::Edit -Base;
use mixin 'Kwiki::Installer';
our $VERSION = '0.01';

const class_title => 'Edit With Scode support';
const cgi_class => 'Kwiki::Edit::Scode::CGI';

field 'code';

sub save {
    my $page = $self->pages->current;
    $page->content($self->cgi->page_content);
    if ($page->modified_time != $self->cgi->page_time) {
        my $page_uri = $page->uri;
        return $self->redirect("action=edit_contention&page_name=$page_uri");
    }
    $page->update->store if $self->scode_granted;
    return $self->redirect($page->uri);
}

sub scode_granted {
    my $scode = $self->hub->scode;
    my $answer = $scode->scode_get($self->cgi->code);
    $answer == $self->cgi->captcha;
}

sub edit {
    my $scode = $self->hub->scode;
    srand int (time/10)+$$;
    my $code = int rand($scode->scode_tmp());
    $code++;
    $scode->scode_create($code);
    $self->code($code);
    super;
}

package Kwiki::Edit::Scode::CGI;
use base 'Kwiki::CGI';

cgi 'page_content' => qw(-utf8 -newlines);
cgi 'revision_id';
cgi 'page_time';
cgi 'code';
cgi 'captcha';

package Kwiki::Edit::Scode;

__DATA__


__template/tt2/edit_button.html__
<!-- BEGIN edit_button.html -->
[% rev_id = hub.revisions.revision_id %]
<a href="[% script_name %]?action=edit&page_name=[% page_uri %][% IF rev_id %]&revision_id=[% rev_id %][% END %]" accesskey="e" title="Edit This Page">    

[% INCLUDE edit_button_icon.html %]
</a>
<!-- END edit_button.html -->
__template/tt2/edit_button_icon.html__
<!-- BEGIN edit_book_button_icon.html -->
Edit
<!-- END edit_book_button_icon.html -->
__template/tt2/edit_content.html__
<!-- BEGIN edit_content.html -->
<script language="JavaScript" type="text/JavaScript"><!--
function clear_default_content(content_box) {
    if (content_box.value == '[% default_content %]') {
        content_box.value = '';
    }
}
--></script>
[% IF button == edit_preview_button_text %]
[% preview_content %]
<hr />
[% END %]
<form method="POST">
<input type="submit" name="button" value="[% edit_save_button_text %]" />
<input type="submit" name="button" value="[% edit_preview_button_text %]" />
<br />
<input type="hidden" name="code" value="[% self.code %]" />

<img src="[% script_name %]?action=captcha&code=[% self.code %]" />
<input type="text" maxlength="6" name="captcha" size="50" value="" />
<p class="description">Please enter the code as seen in the image above to post your comment.</p>

<br />
<input type="hidden" name="action" value="edit" />
<input type="hidden" name="page_name" value="[% page_uri %]" />
<input type="hidden" name="page_time" value="[% page_time %]" />
<textarea name="page_content" rows="25" cols="80" onfocus="clear_default_content(this)">
[%- page_content -%]
</textarea>
</form>
<!-- END edit_content.html -->
