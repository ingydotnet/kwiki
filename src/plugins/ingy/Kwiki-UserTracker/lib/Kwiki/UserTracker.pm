package Kwiki::UserTracker;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const class_id => 'user_tracker';

sub register {
    my $registry = shift;
    $registry->add(
        hook => 'hub:pre_process',
        pre => 'tracker',
    );
    $registry->add(
        widget => 'user_tracker_widget', 
        template => 'user_tracker_widget.html',
        show_for => ['display', 'edit', 'recent_changes'],
    );
}

sub tracker {
    my $hook = pop;
    $self = $self->user_tracker;
}

__DATA__

__template/tt2/user_tracker_widget.html__
[% IF hub.users.current.name %]
Foo!<br />
[% END %]
