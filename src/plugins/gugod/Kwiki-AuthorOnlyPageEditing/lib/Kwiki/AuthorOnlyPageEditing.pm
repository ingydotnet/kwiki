package Kwiki::AuthorOnlyPageEditing;
use Kwiki::Plugin -Base;
our $VERSION = '0.01';

const class_id => 'aope';
const cgi_class => 'Kwiki::AuthorOnlyPageEditing::CGI';

sub register {
    my $registry = shift;
    $registry->add(hook => 'page:store', pre => 'check_token');
    $registry->add(hook => 'edit:edit', post => 'modify_form');
}

sub modify_form {
    my $hook = pop;
    my $page_name = $self->cgi->page_name;
    my $edit = $self;
    $self = $edit->hub->aope;

    my $page = $self->pages->new_from_name($page_name);
    my ($king) = $hook->returned;
    unless(-f $page->file_path && !$self->token_path($page)->exists) {
        $king =~ s{(<textarea[^>]*?>)}
            {<span>Page token:</span><input name="token" /><br/>\n$1}i;
    }
    return $king;
}

sub check_token {
    my $hook = pop;
    my $page = $self;
    $self = $page->hub->aope;
    if(-f $page->file_path) {
        my $token = $self->find_token($page);
        return unless $token;
        $hook->code(undef) unless($self->cgi->token eq $token);
    } else {
        $self->associate($self->cgi->token,$page) if($self->cgi->token);
    }
}

sub token_path {
    my $page = shift;
    io->catfile($self->plugin_directory,$page->id);
}

sub associate {
    my ($token,$page) = @_;
    my $i = $self->token_path($page)->assert;
    $i->print($token);
}

sub find_token {
    my $page = shift;
    my $i = $self->token_path($page);
    return $i->getline if $i->exists;
}

package Kwiki::AuthorOnlyPageEditing::CGI;
use base 'Kwiki::CGI';
cgi token => qw(-utf8 -newlines);

package Kwiki::AuthorOnlyPageEditing;
