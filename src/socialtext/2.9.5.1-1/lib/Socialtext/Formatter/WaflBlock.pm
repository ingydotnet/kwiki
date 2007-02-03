# @COPYRIGHT@
package Socialtext::Formatter::WaflBlock;
use strict;
use warnings;

use base 'Socialtext::Formatter::Wafl', 'Socialtext::Formatter::Block';

use Class::Field qw( const field );


const formatter_id => 'wafl_block';
field 'method';
field 'arguments';

sub html_start { '<div class="wafl_block">'}

sub html_end {
    my $self = shift;
    my $method  = $self->method;
    my $escaped = $self->escape_wafl_dashes( $self->matched );
    chomp $escaped;
    return <<EOHTML;
<!-- wiki:
.$method
$escaped
.$method
--></div>
EOHTML
}

sub match {
    my $self = shift;
    my $text = shift;
    return
        unless $text
        =~ /(?:^\.([\w\-]+)\ *\n)((?:.*\n)*?)(?:^\.\1\ *\n|\z)/m;
    $self->set_match($2);
    my $method = lc $1;
    $method =~ s/-/_/g;
    $self->method($method);
    $self->matched($2);
}

sub block_text {
    my $self = shift;
    $self->to_html_escaped_text
}

################################################################################
package Socialtext::Formatter::Preformatted;

use base 'Socialtext::Formatter::WaflBlock';
use Class::Field qw( const );

const wafl_id => 'pre';
const html_start => "<pre>\n";
const html_end => "</pre>\n";


################################################################################
package Socialtext::Formatter::Html;

use base 'Socialtext::Formatter::WaflBlock';

use Class::Field qw( const );
use HTML::TreeBuilder ();
use HTML::PrettyPrinter;

const wafl_id => 'html';

sub text_filter {
    my $self = shift;
    my $text = shift;
    $text =~ s/<(?=\/?(?i:html|head|body))/&lt;/g;
    $text;
}

sub escape_html {
    my $self = shift;
    my $text = shift;
    return $self->hub->current_workspace->allows_html_wafl
        ? $self->_pretty_print_html($text)
        : $self->html_escape($text);
}

sub _pretty_print_html {
    my $self = shift;
    # guts can return undef
    my $html = HTML::TreeBuilder->new_from_content(shift)->guts;
    return '' unless ( defined($html) && $html =~ /\S/ );
    my $html_text = join '',
        @{ HTML::PrettyPrinter->new(
            quote_attr      => 1,
            allow_forced_nl => 1,
            )->format($html)
        };
    $html->delete();
    return $html_text;
}


################################################################################
package Socialtext::Formatter::Selenium;

use base 'Socialtext::Formatter::WaflBlock';

use Class::Field qw( const );
use Cwd 'cwd';
use Socialtext::File;
use Socialtext::Paths;

const wafl_id => 'selenium';

sub html {
    my $self = shift;
    my $test_text = $self->matched();
    my $test_name = $self->test_name();
    my $enabled = $self->enabled();
    if ($enabled && $test_name) {
        $self->store_test($test_name, $test_text);
    }
    return $self->hub->template->process('selenium_test.html',
        selenium_test_text => $test_text,
        selenium_test_name => $test_name,
        selenium_enabled => $enabled,
    );
}

sub test_name {
    my $self = shift;
    my $title = $self->hub->pages->current->title;
    return ($title =~ /^selenium:(\w+)$/) ? $1 : '';
}

sub enabled {
    my $self = shift;
    -e $self->plugin_directory;
}

sub store_test {
    my $self = shift;
    my ($test_name, $text) = @_;
    my $dir = $self->plugin_directory . '/tests';
    my $test_file = "$dir/$test_name.test";
    my $old_text = -e $test_file ? Socialtext::File::get_contents($test_file) : '';
    return if $old_text eq $text;
    if ($text !~ /\S/) {
        $test_file->unlink;
    }
    else {
        $test_file->print($text);
    }
    $self->rebuild($dir);
}

# XXX - This probably should use a post process rather than a system
# call, but this functionality is not called at all unless you have
# explicitly turned on Selenium testing.
sub rebuild {
    my $self = shift;
    my $dir = shift;
    my $home = cwd();
    chdir $dir or die;
    system("make", "clean"); # == 0 or die;
    system("make", "all"); # == 0 or die;
    chdir $home or die;
}

sub plugin_directory {
    my $self = shift;
    my $base = Socialtext::Paths::plugin_directory( $self->current_workspace_name );
    return Socialtext::File::catdir( $base, 'selenium' );
}


1;
