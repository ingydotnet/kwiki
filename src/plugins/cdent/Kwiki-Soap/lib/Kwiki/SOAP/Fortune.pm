package Kwiki::SOAP::Fortune;
use Kwiki::SOAP '-Base';
use mixin 'Kwiki::Installer';

# XXX at least some of this should come from preferences
const wsdl => 'http://www.asleep.net/soap/services.php?wsdl';

our $VERSION = 0.01;

const class_title => 'fortune soap retrieval';
const class_id => 'fortunesoap';
const css_file => 'fortunesoap.css';
const method => 'fortune';

sub register {
    my $registry = shift;
    $registry->add(template => 'fortune_soap.html');
    $registry->add(wafl => fortunesoap => 'Kwiki::SOAP::Fortune::Wafl');
}

sub get_result {
    my $type = shift;
    $self->soap(
        $self->wsdl,
        $self->method,
        [$type]
    );
}

package Kwiki::SOAP::Fortune::Wafl;
use base 'Kwiki::SOAP::Wafl';

sub html {
    my ($type) = split(' ', $self->arguments);
    my $result = $self->hub->fortunesoap->get_result($type);

    $self->hub->template->process('fortune_soap.html',
        fortune => $result,
        soap_class  => $self->hub->fortunesoap->class_id,
    );
}

package Kwiki::SOAP::Fortune;
1;

__DATA__

__css/fortunesoap.css__
div.fortunesoap { background: #d0d0d0; border thin solid black; padding: 1em;}
__template/tt2/fortune_soap.html__
<!-- BEGIN fortune_soap.html -->
<div class="[% soap_class %]">
[% fortune %]
</div>
<!-- END fortune_soap.html -->
