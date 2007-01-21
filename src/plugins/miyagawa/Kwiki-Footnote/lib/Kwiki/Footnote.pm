package Kwiki::Footnote;

use strict;
our $VERSION = '0.01';
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-Base';

const class_id    => 'footnote';
const class_title => 'Footnote Wafl';
const css_file    => 'footnote.css';

field footnotes => [];

sub register {
    my $registry = shift;
    $registry->add(wafl => footnote => "Kwiki::Footnote::Footnote");
    $registry->add(wafl => footnotelist => "Kwiki::Footnote::FootnoteList");
}

package Kwiki::Footnote::Footnote;
use base 'Spoon::Formatter::WaflPhrase';

sub html {
    my $text = $self->arguments;
    my $footnotes = $self->hub->footnote->footnotes;
    push @$footnotes, $text;
    my $num = @$footnotes;
    return <<EOF;
<sup id="fb$num"><a href="#fn$num" title="@{[$self->html_escape($text)]}">$num</a></sup>
EOF
}

package Kwiki::Footnote::FootnoteList;
use base 'Spoon::Formatter::WaflPhrase';

sub html {
    my @footnotes = @{$self->hub->footnote->footnotes};
    my $html = qq(<ul class="footnotelist">\n);
    for my $idx (0..$#footnotes) {
	my $text = $footnotes[$idx];
	my $num  = $idx + 1;
	$html .= <<EOF
<li class="footnote"><cite id="fn$num"><a href="#fb$num">*$num</a></cite>: @{[$self->hub->formatter->text_to_html($text)]}</li>
EOF
    ;
    }
    $html .= "</ul>\n";
    return $html;
}

package Kwiki::Footnote;
1;
__DATA__


__css/footnote.css__
ul.footnotelist {
  margin-left: 0;
}
li.footnote {
  margin-left: 0;
}
