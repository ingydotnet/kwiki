package Kwiki::SOAP::Google;
use strict;
use warnings;
use Kwiki::SOAP '-Base';
use Kwiki::Installer '-base';

# XXX at least some of this should come from preferences
const wsdl => 'http://api.google.com/GoogleSearch.wsdl';
const method => 'doGoogleSearch';
const limit => 10;

our $VERSION = 0.04;

const class_title => 'google soap retrieval';
const class_id => 'googlesoap';
const css_file => 'googlesoap.css';
const config_file => 'googlesoap.yaml';

field key => -init => '($self->config->can("google_api_key"))
      ? $self->config->google_api_key : undef';

sub register {
    my $registry = shift;
    $registry->add(wafl => googlesoap => 'Kwiki::SOAP::Google::Wafl');
}

sub get_result {
    my $query = shift;
    my $google_key = $self->key;
    return { error => 'no google key' }
        unless $google_key;
    my $result = $self->soap(
        $self->wsdl,
        $self->method,
        [
        $google_key,
        $query,
        0,
        $self->limit,
        'true', '', 'false', '', 'UTF-8', 'UTF-8'
        ]
    );
}


package Kwiki::SOAP::Google::Wafl;
use base 'Kwiki::SOAP::Wafl';

sub html {
    my $query = $self->arguments;
    return $self->wafl_error unless ($query);

    my $result = $self->hub->googlesoap->get_result($query);

    return $self->pretty($query, $result);
}

sub pretty {
    my $query = shift;
    my $result = shift;
    $self->hub->template->process('google_soap.html',
        soap_class  => $self->hub->googlesoap->class_id,
        query => $query,
        google_elements => $result->{resultElements},
        error => $result->{error},
    );
}

package Kwiki::SOAP::Google;
1;

__DATA__


__css/googlesoap.css__
div.googlesoap { background: #dddddd; font-family: sans-serif;}
.googlesoap dd { font-size: x-small; }
.googlesoap dt { font-size: small;
__template/tt2/google_soap.html__
<!-- BEGIN google_soap.html -->
<div class="[% soap_class %]">
[% IF error %]
<span style="color:red">[% error %]</span>
[% ELSE %]
<dl>
[% FOREACH google_result = google_elements %]
<dt><a href='[% google_result.URL %]' title='[% google_result.title %]'>
[% google_result.title %]
</a>
</dt>
<dd>[% google_result.snippet %]</dd>
[% END %]
</dl>
[% END %]
</div>
<!-- END google_soap.html -->
__config/googlesoap.yaml__
google_api_key:
