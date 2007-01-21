package Kwiki::BabelTest;
use Kwiki::Plugin -Base;
use Kwiki::Installer -mixin;
our $VERSION = '0.10';

const class_id => 'babeltest';
const class_title => 'BabelTest Blocks';
const css_file => 'babeltest.css';

sub register {
    my $registry = shift;
    $registry->add(wafl => babeltest => 'Kwiki::BabelTest::Wafl');
}

package Kwiki::BabelTest::Wafl;
use base 'Spoon::Formatter::WaflBlock';

sub to_html {
    require YAML::Loader::Babel;
    my $yaml = $self->matched;
    my @rows = eval {YAML::Loader::Babel->new->load($yaml)};
    return $self->error if @_;
    return $self->error unless @rows > 1;
    my $head = shift @rows;
    if (defined $head->{columns}) {
        $head->{columns} = [split /\s+/, $head->{columns}];
        return $self->hub->template->process('babeltest_table.html',
            head => $head,
            rows => \@rows,
        );
    }
    return $self->error;
}

sub error {
    my $text = $self->html_escape($self->matched);
    return "<pre>\n$text</pre>\n" if @_;
}

package Kwiki::BabelTest;
__DATA__

__css/babeltest.css__
table.babeltest {
    border-collapse: collapse;
    margin-bottom: .2em;
}

table.babeltest td {
    border: 1px;
    border-style: solid;
    padding: .2em;
    vertical-align: top;
}
__template/tt2/babeltest_table.html__
<table class="babeltest">
<tr>
<td colspan="[% head.columns.size %]">[% head.type %]</td>
</tr>
<tr>
[% FOR label = head.columns -%]
<td>[% label %]</td>
[% END -%]
</tr>
[% FOR row = rows -%]
<tr>
[% FOR label = head.columns -%]
<td>[% row.$label %]</td>
[% END -%]
</tr>
[% END -%]
</tr>
</table>
