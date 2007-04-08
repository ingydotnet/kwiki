use t::TestPerldoc tests => 1;

use Perldoc::Convert;

no_diff;
run_is kwid => 'html';

sub to_html {
    Perldoc::Convert->kwid_to_html(input_string => @_);
}

__DATA__
=== Convert Kwid to HTML
--- kwid to_html
= Intro to Kwid

This is _Kwid_!! It
really *rocks*.

* Love
* Your
* *Parser*
--- html
<body>
<h1>
Intro to Kwid
</h1>

<p>
This is _Kwid_!! It
really <b>
rocks</b>
.<p>
<ul><li>
Love</li><li>
Your</li><li>
<b>
Parser</b>
</li></ul>
</body>

