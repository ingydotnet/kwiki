package Kwiki::Status;
use Kwiki::Pane -Base;

const class_id => 'status';
const pane_template => 'status_pane.html';

__DATA__

__template/tt2/status_pane.html__
<div class="status">
[% units.join("<br />") %]
</div>
