package Kwiki::Icons;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const class_id => 'icons';
const css_file => 'icons.css';
const config_file => 'icons.yaml';

sub class_title {
    $self->usage;
}

sub register {
    my $registry = shift;
    $registry->add(preload => 'icons');
    $registry->add(preference => $self->use_icons);
}

sub init {
    $self->SUPER::init(@_);
    if ($self->preferences->can('use_icons') and
        $self->preferences->use_icons->value) {
        $self->template->add_path($self->icons_path);
    }
}

sub use_icons {
    my $p = $self->new_preference('use_icons');
    $p->query('Use icons in toolbar?');
    $p->type('boolean');
    $p->edit('correct_template_path');
    $p->default(1);
    return $p;
}

sub correct_template_path {
    my $pref = shift;
    if ($pref->new_value) {
        $self->template->add_path($self->icons_path);
    }
    else {
        $self->template->remove_path($self->icons_path);
    }
}

sub icons_path {
    $self->usage;
}

sub usage {
    die "Don't use Kwiki::Icons directly. Use a subclass of it.";
}

__DATA__


__config/icons.yaml__
icons_on_by_default: 1
