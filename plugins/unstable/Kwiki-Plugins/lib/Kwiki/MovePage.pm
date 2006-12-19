package Kwiki::MovePage;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const class_id => 'move_page';
const config_file => 'move_page.yaml';

sub register {
    my $registry = shift;
    $registry->add(action => 'move_page');
    $registry->add(toolbar => 'move_page_button',
                   template => 'move_page_button.html',
                   show_for => ['display'],
                  );
}

sub move_page {
    my $page = $self->pages->current;
    my $id = $page->id;
    my $target = $self->config->move_target
      or die "MovePage not configured";
    my $source = io->curdir->absolute->pathname;
    if (not -e "$target/database/$id") {
        rename("$source/database/$id", "$target/database/$id");
        rename("$source/plugin/archive/$id,v", "$target/plugin/archive/$id,v");
        rename("$source/plugin/page_metadata/$id", 
               "$target/plugin/page_metadata/$id");
    }
    $self->redirect('action=search');
}

package Kwiki::MovePage;
__DATA__
__config/move_page.yaml__
move_target:
__template/tt2/move_page_button.html__
[% rev_id = hub.revisions.revision_id %]
<a href="[% script_name %]?action=move_page&page_name=[% page_uri %][% IF
rev_id %]&revision_id=[% rev_id %][% END %]" accesskey="e" title="Move This Page">
[% INCLUDE move_page_button_icon.html %]
</a>
__template/tt2/move_page_button_icon.html__
 Move 
__icons/gnome/template/move_page_button_icon.html__
<img src="icons/gnome/image/move_page.png" alt="Move This Page" />
__icons/gnome/image/move_page.png__
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAFo9M/3AAAABGdBTUEAALGPC/xhBQAAAAZiS0dE
AAAAAAAA+UO7fwAAAAlwSFlzAAALEgAACxIB0t1+/AAAAAd0SU1FB9MCDg8FII8kc8IAAAFASURB
VHjapZI7TwJBFIW/IcRHMMZCGxN7k7Gz8lfQ+Q8sbGxtrU3oLCysbagsTNTGhMTEhoLgY8n6nojA
qqAsBARyLXQRcXfFeJIp7mPOnHMy0AO9k8qKVwhuvSGAJgjam6qepuBXRLIXeUlbhuX15NdG2jLd
QvWRy2dPDnaT3QUhGF0CbRtHMva9rG3tBRvYSKYkkMJHy4cNv2mpYPBE9t/yfULCHEQBHisurXYH
2zjk7hyW4gs/6Z1yVfaPLQnLxXcY4R+Q/tOLUsEIICosxAHTCFXwKxQgacswPTlObHSY2MgQTy8u
xWeXcrVOtd7EqdR4rTU4uy6wubr47QtEATU/O6OBk9xtkamJMZRSvLU7NFsdao0W2csHEitxgDng
NEyRBsQ2jpzfFCWxfegFqP/s/yhzJYPkoAYIUIURvAMSQqAmiCruwwAAAABJRU5ErkJggg==
