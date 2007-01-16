package Kwiki::PageInfo;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const class_id => 'page_info';
const max => 100;
const config_file => 'page_info.yaml';
const cgi_class => 'Kwiki::PageInfo::CGI';

sub register {
    my $registry = shift;
    $registry->add(prerequisite => 'revisions');
    $registry->add(action => 'page_info');
    $registry->add(action => 'page_info_blacklist');
    $registry->add(toolbar => 'page_info_button',
                   template => 'page_info_button.html',
                   show_for => ['display'],
                  );
}

sub page_info {
    my $page = $self->pages->current;
    my $history = $self->hub->archive->history($page);
    my $total_revs = @$history;
    splice(@$history, $self->max) if $total_revs > $self->max;
#     @$history = reverse @$history;
    for my $rev (@$history) {
        my $content = $self->hub->archive->fetch($page, $rev->{revision_id});
        $rev->{content} = $self->html_escape($content);
    }
    $self->render_screen(
        total_revs => $total_revs,
        revisions => $history,
    );
}

sub can_blacklist {
    my $blacklist = $self->config->page_info_blacklist
      or return;
    -e $blacklist;
}

sub page_info_blacklist {
    io($self->config->page_info_blacklist)->appendln($self->cgi->ip_address);
}

package Kwiki::PageInfo::CGI;
use Kwiki::CGI -base;

cgi 'ip_address';

package Kwiki::PageInfo;

__DATA__
__template/tt2/page_info_button.html__
[% rev_id = hub.revisions.revision_id %]
<a href="[% script_name %]?action=page_info&page_name=[% page_uri %]"
accesskey="e" title="Page Info">
[% INCLUDE page_info_button_icon.html %]
</a>
__template/tt2/page_info_button_icon.html__
 Page Info 
__icons/gnome/template/page_info_button_icon.html__
<img src="icons/gnome/image/page_info.png" alt="Page Info" />
__icons/gnome/image/page_info.png__
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAAU0lE
QVR42mNgQAUxJNLUBzCTCxgYGP5jwQXEuuA/DOzfvx/OhhpCmguQNJLkAhSX4LOZCYcLiHXpqAvw
AELRSNBkQgmJeBfgSMoUh24MMZJEZWUAyPRiqzvc0gsAAAAASUVORK5CYII=
__template/tt2/page_info_content.html__
<h3>
<a href="[% script_name %]?[% page_uri %]">[% page_title %]</a> - [% total_revs %] Revisions
</h3>
[% FOR rev = revisions %]
<hr>
<a href="[% script_name %]?action=delete_page&page_name=[% page_uri %]&revision_id=[% rev.revision_id %]">
<img style="border:0" src="icons/gnome/image/delete_page.png" alt="Page Info" />
</a>
<a href="[% script_name %]?action=revisions&page_name=[% page_uri %]&revision_id=[% rev.revision_id %]">
<b>#</b>:&nbsp;[% rev.revision_id %]
</a>
<b>Author</b>:&nbsp;[% rev.edit_by %]
<b>Date</b>:&nbsp;[% rev.edit_time %]
<b>From</b>:&nbsp;
[%- IF hub.page_info.can_blacklist -%]
[% FOR ip_address = rev.edit_address.split(', ') %]
<a href="#blacklist-this-ip-address" title="Blacklist [% ip_address %]" onclick="add_to_blacklist('[% ip_address %]'); return false">[% ip_address %]</a>
[% END %]
<script type="text/javascript">
function add_to_blacklist(ip) {
    if (confirm('Really Blacklist ' + ip + '?')) {
        iframe = document.getElementsByTagName("iframe")[0]
        iframe.src = '[% script_name %]?' +
                     'action=page_info_blacklist&' +
                     'ip_address=' + ip
     }
}
</script>
<iframe height="0" width="0" frameborder="0"></iframe>
[%- ELSE -%]
[% rev.edit_address %]
[% END %]
<pre>
[% rev.content %]
</pre>
[% END %]
__config/page_info.yaml__
page_info_blacklist: plugin/access_blacklist/blacklist
