package Kwiki::Toolbar::List;
use strict;
use warnings;
use Kwiki::Toolbar '-Base';

our $VERSION = 0.01;

#const class_id => 'toolbar';
const class_title => 'Kwiki Toolbar List';
const toolbar_template => 'toolbar_pane.html';
#const css_file => 'toolbar.css';
#const config_file => 'toolbar.yaml';

sub html {
    my $lookup = $self->hub->registry->lookup;
    my $tools = $lookup->{toolbar}
      or return '';
    my %toolmap;
    for (keys %$tools) {
        my $array = $tools->{$_};
        push @{$toolmap{$array->[0]}}, {@{$array}[1..$#{$array}]};
    }
    my %classmap = reverse %{$lookup->{classes}};
    my $x = 1;
    my %class_ids = map {
        ($classmap{$_}, $x++)
    } @{$self->hub->config->plugin_classes};
    my @class_ids = grep {
        delete $class_ids{$_}
    } @{$self->config->toolbar_order};
    push @class_ids, sort {
        $class_ids{$a} <=> $class_ids{$b}
    } keys %class_ids;
    my @toolbar_content = ();
    @toolbar_content = grep {
        defined $_ and do {
            my $button = $_;
            $button =~ s/<!--.*?-->//gs;
            $button =~ /\S/;
        }
    } map {
        $self->show($_) ? defined($_->{template}) ? $self->template->process($_->{template}) : undef : undef
    } map {
        defined $toolmap{$_} ? @{$toolmap{$_}} : ()
    } @class_ids;

    $self->template->process($self->toolbar_template,
        toolbar_content => \@toolbar_content,
	action		=> $self->hub->action,
    );
}

1;

__DATA__

__template/tt2/toolbar_pane.html__
<!-- BEGIN toolbar_pane.html -->
<div class="toolbar">
<ul id="nav">
[% FOREACH item = toolbar_content -%]
<li>[% item %]</li>
[% END -%]
</ul>
</div>
<!-- END toolbar_pane.html -->
__config/toolbar.yaml__
toolbar_order:
- search
- display
- recent_changes
- user_preferences
- new_page
- edit
- revisions
