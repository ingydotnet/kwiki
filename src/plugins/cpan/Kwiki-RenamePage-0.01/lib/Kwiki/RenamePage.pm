package Kwiki::RenamePage;

use warnings;
use strict;


our $VERSION = '0.01';


use Kwiki::Plugin '-Base';
use mixin 'Kwiki::NewPage';
use mixin 'Kwiki::Installer';

const class_id => 'rename_page';
const cgi_class => 'Kwiki::RenamePage::CGI';
const screen_template =>  'rename_page_content.html';
field 'old_page_name';
field 'old_page_content';
# field 'page_time';


sub register {
    my $registry = shift;
    $registry->add( action => 'rename_page' );
    $registry->add( toolbar => 'rename_page_button',
    			template => 'rename_page_button.html' );
}


sub rename_page {
    my $page = $self->pages->current;
    my $old_name = $self->cgi->old_page_name;
    my $new_name      = $self->cgi->new_page_name;
    $self->old_page_name( $self->cgi->page_name );
    my $error_msg = '';
    my $page_uri;
    if ( $self->cgi->button ) {
        $error_msg = $self->check_page_name or do {
	    my $old_page = $self->pages->new_from_name( $old_name );
            my $new_page = $self->pages->new_from_name( $new_name );
            return $self->redirect( $new_page->uri )
              unless $new_page->is_writable;
	    my $current = $self->pages->current($old_page);
	    my $yanked_content  = $current->content;
	    $current->content("This page has moved to $new_name.");
	    if ( $current->modified_time != $self->cgi->page_time )
	    {
		    return("action=edit_contention;page_name=$current->uri");
	    }
            $current->update->store;
	    my $link = qr/$old_name/;
	    for my $page ( $self->pages->all )
	    {
		    # my $current = $self->pages->current($page);
		    my $content  = $page->content;
		    $content =~ s/$old_name/$new_name (Old name: $old_name)/g;
		    $page->content($content);
		    $page->update->store;
	    }
            $current = $self->pages->current($new_page);
            $current->content($yanked_content);
            $current->update->store;
	    return $self->redirect($current->uri);
          }
    }
    return $self->render_screen( error_msg => $error_msg ) if $error_msg;
    return $self->render_screen( old_page_name => $self->old_page_name, 
    				page_time => $page->modified_time);
}

package Kwiki::RenamePage::CGI;
use Kwiki::CGI '-base';

cgi 'new_page_name';
cgi 'old_page_name';
cgi 'page_name';
cgi 'page_time';

1;

package Kwiki::RenamePage;


1; # End of Kwiki::RenamePage

__DATA__

__template/tt2/rename_page_button.html__
<!-- BEGIN rename_page_button.html -->
[% IF hub.pages.current.is_writable %]
[% rev_id = hub.have_plugin('revisions') ? hub.revisions.revision_id : 0 %]
<a href="[% script_name %]?action=rename_page;page_name=[% page_uri %][% IF rev_id %];revision_id=[% rev_id %][% END %]" accesskey="R" title="Rename Page">
[% INCLUDE rename_page_button_icon.html %]
</a>
[% END %]
<!-- END rename_page_button.html -->
__template/tt2/rename_page_button_icon.html__
<!-- BEGIN rename_page_button_icon.html -->
Rename
<!-- END rename_page_button_icon.html -->
__template/tt2/rename_page_content.html__
<!-- BEGIN rename_page_content.html -->
[% screen_title = 'Rename Page' %]
<form method="post">
<p>Enter a new page name for this page.</p>
<p>OLD NAME: [% self.old_page_name %]</p>
<p>NEW NAME: <input type="text" size="20" maxlength="30" name="new_page_name" value="[% new_page_name %]" />
<input type="submit" name="button" value="RENAME" /></p>
<br />
<br />
<span class="error">[% error_msg %]</span>
<input type="hidden" name="action" value="rename_page">
<input type="hidden" name="old_page_name" value="[% old_page_name %]">
<input type="hidden" name="page_time" value="[% page_time %]">
</form>
<pre>


</pre>
<!-- END rename_page_content.html -->
