package Kwiki::DeletePage;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const class_id => 'delete_page';
const cgi_class => 'Kwiki::DeletePage::CGI';

sub register {
    my $registry = shift;
    $registry->add(action => 'delete_page');
    $registry->add(toolbar => 'delete_page_button',
                   template => 'delete_page_button.html',
                   show_for => ['display', 'revisions', 'page_info'],
                  );
}

sub delete_page {
    my $rev = @_ ? shift : $self->cgi->revision_id;
    return $self->purge_revision
      if $rev;
    my $page = $self->get_page;
    io->file($page->file_path)->unlink;
    io->file($page->metadata->file_path)->unlink;
    if ($self->have_plugin('archive')) {
        io($self->hub->archive->file_path($page))->unlink;
    }
    $self->redirect('action=recent_changes');
}

sub get_page {
    my $page = $self->pages->current;
    die "Can't delete main page\n" 
      if $page->title eq $self->config->main_page;
    return $page;
}

sub purge_revision {
    my $rev = int($self->cgi->revision_id);
    if ($rev <= 1) {
        return $self->delete_page(0);
    }
    my $page = $self->pages->current;
    my $archive = $self->hub->archive;
    my $history = $archive->history($page);
    $self->purge_error("History info seems corrupted")
      unless @$history >= $rev and
             $history->[0 - $rev]{revision_id} == $rev and
             $history->[0 - $rev + 1]{revision_id} == ($rev - 1);
    my $rcs_file = $archive->file_path($page);
    my $rev_info = $history->[0 - $rev + 1];
    my $content = $archive->fetch($page, $rev_info->{revision_id});
    my $original_time = $rev_info->{edit_unixtime};
    my $new_page = $self->pages->new_page($page->id);
    $rev_info->{edit_by} ||= '';
    delete $rev_info->{revision_id};
    for my $key (keys %$rev_info) {
        $new_page->metadata->{$key} = $rev_info->{$key};
    }
    unless ($new_page->metadata->{edit_unixtime}) {
        $new_page->metadata->{edit_unixtime} = $original_time;
        $new_page->metadata->{edit_time} = gmtime($original_time);
    }
    if ($new_page->metadata->{edit_by} =~ /^[\d\.]+$/) {
        $new_page->metadata->{edit_by} = 'AnonymousGnome';
    }
    $new_page->content($content);

    $self->shell("rcs -q -u -o1.${rev}: $rcs_file");
    $rev--;
    $self->shell("rcs -q -l1.${rev} $rcs_file");
    $new_page->force(1)->store;
    io($new_page->file_path)->utime($original_time);
    io($new_page->metadata->file_path)->utime($original_time);
    io($rcs_file)->utime($original_time);

    $self->redirect($page->uri);
}

sub shell {
    my $command = shift;
    system($command) == 0 or
      $self->purge_error($command);
}

sub purge_error {
    my $msg = shift || '';
    my $page_title = $self->pages->current->title;
    my $rev = int($self->cgi->revision_id) - 1;
    die "Error purging '$page_title' to revision '$rev': $msg";
}

package Kwiki::DeletePage::CGI;
use Kwiki::CGI -base;

cgi 'revision_id';

package Kwiki::DeletePage;
__DATA__
__template/tt2/delete_page_button.html__
[% rev_id = hub.have_plugin('revision') ? hub.revisions.revision_id : 0 %]
<a href="[% script_name %]?action=delete_page&page_name=[% page_uri %][% IF rev_id %]&revision_id=[% rev_id %][% END %]" accesskey="e" title="Delete This Page">
[% INCLUDE delete_page_button_icon.html %]
</a>
__template/tt2/delete_page_button_icon.html__
 Delete 
__icons/gnome/template/delete_page_button_icon.html__
<img src="icons/gnome/image/delete_page.png" alt="Delete This Page" />
__icons/gnome/image/delete_page.png__
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAACv0lE
QVR42m2TT09TWRyGn9t77+FS+sc7UKhFwX9sgBDHYGLUocYQN7pQx2SSMe40btyYzAcYY1zNer4A
GVdKQiYzJBojoFEn0WAgNLFiKa1UgWlLaW+L3Nvb48ZWFN7N7yTn9z7Je/IehS0SQpjAccMw/hkc
HMQwDCzLIp/PMzc3hxAiCry3bTvJ9xJCHAckIO/cvikLuTeyuL4i87kl+eL5Q/nzxTOyfi+EOFv3
KV/MQ16vd+rvsT+REh48fML0dJzkYoZgoJkL54fZvbsdVfXg8Xi4fOU3hBAHbNtOegB6enqmnk7d
JxLpZv/+XqJDJ9jT2ckPpolo0nk7n8K2HdraTAJBH3+N/IFt2wsAGkAsFiPU2oHP304Nhx+PHKO/
7zCFQpb82grZbA7T3IUQBsVigVhsvhFdqx9G7o5w/eoVvC0dNGmtyIBCayjCvqrNxkaJYqnIxOPH
PH/xknK50gCo9en3+6Kzs3GWV1YJh5txNi2KxTwflkuMjY0yOTlBMplmYSHNu3cpstm128CEUid1
d3fKUChER6iNvV1dGIaGU62hKpus/p8nlf7AQmIJVVPQNZVU+qPyTYSWFoMbN64xOnqP6dfTWFYF
XddYXHxPtVpF1zUGBvqoVEoUCta2CLS3t/5+KvoTQ0OncexPXLp0Dl+LjpQuw8MncV2HgYF+1tfX
KJc3yOUKtwA8jUIoCkazlwMHDxHpDHN08CRtoTDhjgi9vf2YZoBg0IdpBlDVhu0rYCtIUz00GYJD
B7vQhYrf70NVVRRF2dbgBkBKyczMLLVajZqst/ZbSSmxrApS7gCoVl2ePfuP8fF/mZmJ4bpuY8my
1gHIZJZZWlrFcZztj1gqVV6l05lfHz2aZFfQj+KpkEikiccTQI14PEEms0osNk+5/Cnqum6KnSSE
+EUIIQEZDAalrus7/sK6PgPn+CM8KEgF/gAAAABJRU5ErkJggg==
