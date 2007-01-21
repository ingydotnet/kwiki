package Kwiki::HomePagePreference;
use Kwiki::Plugin -Base;
our $VERSION = '0.10';

const class_id => 'home_page_preference';

sub register {
    my $register = shift;
    $register->add(preference => $self->home_page_preference);
    $register->add(hook => 'hub:process',
        pre => 'process_hook',
    );
}

sub process_hook {
    require CGI;
    my $hook = pop;
    $self = $self->hub->home_page_preference;
    if (not length $ENV{QUERY_STRING} and CGI->request_method eq 'GET') {
        my $redirect = $self->preferences->home_page_preference->value;
        if (length $redirect) {
            $hook->cancel;
            return $self->redirect($redirect);
        }
    }
}

sub home_page_preference {
    my $p = $self->new_preference('home_page_preference');
    $p->query('Choose a custom home page?');
    $p->type('input');
    $p->size(15);
    $p->edit('check_home_page');
    $p->default('');
    return $p;
}

sub check_home_page {
    my $preference = shift;
    my $value = $preference->new_value;
    $self->utf8_decode($value);
    return unless length $value;
    return $preference->error('Value must not contain spaces')
      if $value =~ /\s/;
    $self->users->current(undef);
    return 1;
}
