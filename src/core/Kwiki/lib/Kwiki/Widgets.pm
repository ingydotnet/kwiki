package Kwiki::Widgets;
use Kwiki::Pane -Base;

const class_id => 'widgets';
const pane_template => 'widgets_pane.html';
const pane_unit => 'widget';

__DATA__

__template/tt2/widgets_pane.html__
<div class="widgets">
[% units.join("<br />") %]
</div>
