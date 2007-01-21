package Kwiki::Command::Edit;
use Kwiki::Plugin -Base;
our $VERSION = '0.01';

const class_id => 'command_edit';
const class_title => '';

sub register {
    my $reg = shift;
    $reg->add(command => 'edit',
              description => 'Edit Kwiki pages from command-line'
             );
}

sub handle_edit {
    my $page_name = shift or die "Usage: kwiki -edit page_name\n";
    my $page = $self->pages->new_page($page_name);
    my $time = $page->modified_time;
    my $tmp = io("edit-$page_name-tmp-$$");
    $tmp < io($page->file_path);
    system("$ENV{EDITOR} $tmp");
    if ($page->modified_time != $time) {
        die("Page was modified, save as file $tmp\n");
    }
    $self->hub->users->current->name($ENV{USER});
    $page->content($tmp->all);
    $page->update->store;
    $tmp->unlink;
}
