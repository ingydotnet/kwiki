package Kwiki::SOAP;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-base';

our $VERSION = 0.05;

const class_title => 'generic soap retrieval';
const class_id => 'soap_access';
const css_file => 'soap.css';

sub register {
    my $registry = shift;
    $registry->add(template => 'base_soap.html');
    $registry->add(wafl => soap => 'Kwiki::SOAP::Wafl');
}

sub soap {
    require SOAP::Lite;
    my $wsdl = shift;
    my $method = shift;
    my $args_list = shift;
    my $soap;
    my $result;

    eval {
        $soap = SOAP::Lite->service($wsdl);
        $result = $soap->$method(@$args_list);
    };
    if ($@) {
        return {error => (split(/\n/,$@))[0]};
    }
    return $result;
}

package Kwiki::SOAP::Wafl;
use base 'Spoon::Formatter::WaflPhrase';

# XXX move most of this up into the top package
# and break it up so tests can access it and 
# some of the soap stuff can be wrapped in evals
# to trap errors (which cause death at the moment)

sub html {
    my ($wsdl, $method, @args) = split(' ', $self->arguments);
    return $self->walf_error
        unless $method;

    my $result = $self->hub->soap_access->soap($wsdl, $method, \@args);

    return $self->pretty($result);
}

sub pretty {
    require YAML;
    my $results = shift;
    $self->hub->template->process('base_soap.html',
        soap_class  => $self->hub->soap_access->class_id,
        soap_output => YAML::Dump($results),
    );
}

package Kwiki::SOAP;
1;

__DATA__


__css/dated_announce.css__
div.soap { background: #dddddd; }
__template/tt2/base_soap.html__
<!-- BEGIN base_soap.html -->
<div class="[% soap_class %]">
<pre>
[% soap_output %]
</pre>
</div>
<!-- END base_soap.html -->
