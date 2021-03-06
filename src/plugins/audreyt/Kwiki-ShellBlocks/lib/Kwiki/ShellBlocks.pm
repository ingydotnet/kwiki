package Kwiki::ShellBlocks;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-Base';
our $VERSION = '0.02';

const class_id => 'shell_blocks';
const class_title => 'Shell Blocks';
const css_file => 'shell_blocks.css';

sub register {
    my $registry = shift;
    $registry->add(wafl => shell => 'Kwiki::ShellBlocks::Wafl');
}

package Kwiki::ShellBlocks::Wafl;
use base 'Spoon::Formatter::WaflBlock';

sub to_html {
    return join '',
      qq{<pre class="shell_mode">},
      join("\n", map $self->render_line($_), split(/\n/, $self->block_text)),
      qq{</pre>};
}

sub render_line {
    my $source = shift;
    $source =~ s/^(\s*)//;
    my $spaces = $1;

    if ($source =~ s/^([%\$]|\w:[\w\\]+>)//) {
        $source = "<span class='prompt'>$1</span><span class='command'>$source</span>";
    }
    else {
        $source = "<span class='output'>$source</span>";
    }

    $source =~ s{((?:\s|^)#\s.+)}{<span class='comment'>$1</span>};

    return $spaces.$source;
}

1;

package Kwiki::ShellBlocks;
__DATA__

__css/shell_blocks.css__
pre.shell_mode {
    padding-left: 0px;
    padding-top: 0px;
    padding-bottom: 0px;
    margin-top: 0px;
    margin-bottom: 0px;
    background-color: #FFF;
}

.prompt { font-weight: bold; color: #C44800; }
.command { color: #0000FF; }
.comment { color: #404080; }
.output  { color: #006000; }
