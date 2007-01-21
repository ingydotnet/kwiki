package Kwiki::DoubleClickToEdit;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
use 5.006001;
our $VERSION = '0.10';

const class_id => 'double_click_to_edit';

sub javascript_file {
    return $self->preferences->double_click_to_edit->value
    ? 'double_click_to_edit.js'
    : ''
}

sub register {
    my $registry = shift;
    $registry->add(preload => 'double_click_to_edit');
    $registry->add(preference => $self->double_click);
}

sub double_click {
    my $p = $self->new_preference('double_click_to_edit');
    $p->query('Kwiki Double Click To Edit?');
    $p->type('boolean');
    $p->default('1');
    return $p;
}

__DATA__


__javascript/double_click_to_edit.js__
(
function() {
    var ol = window.onload;
    var doubleclick = function() {
        var links = document.getElementsByTagName('a');
        for (var i = 0; i < links.length; i++) {
            var link = links[i];
            var href = link.getAttribute('href');
            if (! href) continue;
            if (! href.match(/action=edit/)) continue;
            window.location = href;
            break;
        }
    };
    window.onload = function() {
        if (ol) ol();
        document.body.ondblclick = doubleclick;
    }
}
)();
