package Kwiki::Yahoo;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-base';

our $VERSION = '0.04';

const class_id    => 'yahoo_api';
const class_title => 'Yahoo API';
const css_file    => 'yahoo.css';
const search_spaces => [qw(doc image video news local spell related)];

field error => '';

sub register {
    my $registry = shift;
    for my $space (@{$self->search_spaces}) {
        my $key = 'yahoo_' . $space;
        $registry->add( wafl => $key  => 'Kwiki::Yahoo::Wafl' );
    }
}

sub do_search {
    my $type = shift;
    my $query = shift;
    my $args = shift;

    require Yahoo::Search;
    require Encode;
    my @html = map {Encode::decode('utf8', $_) } Yahoo::Search->HtmlResults(
        ucfirst($type) => $query,
        AppId => "Kwiki::Yahoo $VERSION",
        %$args,
    );
    $self->error($@);

    return [@html];
}


package Kwiki::Yahoo::Wafl;
use Spoon::Formatter ();
use base 'Spoon::Formatter::WaflPhrase';

sub html {
    my $args = $self->arguments;
    my $key = $self->method;

    $key =~ s/^yahoo_//;

    my ($query, $config) = split(/\s*\|\s*/, $args);
    if ($config and
        $config =~ /^(?:\s*[A-Z0-9_\-]+\s*=>\s*["'A-Z0-9_\-.+ ]+,*\s*)+$/i) {
        $config = eval "{ $config }";
    } else {
        $config = ();
    }

    my $html = $self->hub->yahoo_api->do_search($key, $query, $config);

    my $error = $self->hub->yahoo_api->error || '';
    $self->hub->template->process('yahoo.html',
        key => $key,
        query => $query,
        html => $html,
        error => $error,
    );
}

package Kwiki::Yahoo;

__DATA__


__template/tt2/yahoo.html__
<!-- BEGIN yahoo.html -->
<div class="yahoo_results">
<div class="yahoo_titlebox">
[% IF error %]
Error: [% error %]
[% END %]
Yahoo [% key %] search for [% query %]
</div>

[% FOREACH item = html %]
<div class="yahoo_item"
[% item %]
 </div>
[% END %]
<div class="yahoo_attribution">
<a href="http://developer.yahoo.net/">powered by Yahoo! Search</a>
</div>
</div>
<!-- END yahoo.html -->
__css/yahoo.css__
/* borrowed from the Yahoo::Search exapmle */
.yResult {
    display: block;
    border:  3px solid #CCF;
    padding: 10px;
}
.yLink   { }
.yTitle  { display:none; }
.yImg    { border: solid 1px; }
.yUrl    { display:none; }
.yMeta   { font-size: 80%; }
.ySrcUrl { }
.ySum    {
    font-family: arial;
    font-size: 90%;
}
.yahoo_attribution {
    text-align: right;
}
