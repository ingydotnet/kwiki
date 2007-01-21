package Kwiki::DNSBL;
use Kwiki::Plugin -Base;
use Kwiki::Installer -base;

const class_id             => 'dnsbl';
const class_title          => 'DNS Blackhole List';
our $VERSION = '0.02';

sub register {
    require Net::DNSBLLookup; # Check for module at install time
    my $registry = shift;
    $registry->add(hook => 'edit:save', pre => 'dnsbl_hook');
    $registry->add(action => 'blocked_ip');
}

sub dnsbl_hook {
    my $hook = pop;
    my $ip = $self->hub->pages->meta_class->get_edit_address;
    if ($self->hub->dnsbl->check_dnsbl($ip)) {
	$hook->cancel();
	return $self->redirect("action=blocked_ip");
    }
}

sub check_dnsbl {
    require Net::DNSBLLookup;
    my ($ip) = @_;
    my $dnsbl = Net::DNSBLLookup->new(timeout => 5);
    my $res = $dnsbl->lookup($ip);
    my ($proxy, $spam, $unknown) = $res->breakdown;
    if ($proxy || $spam || $unknown) {
	return 1;
    } else {
	return 0;
    }
}

sub blocked_ip {
    return $self->render_screen(
        content_pane => 'blocked_ip.html',
    );
}

__DATA__

__template/tt2/blocked_ip.html__
<div class="error">
<p>You were blocked from editing because your ip address exists in one
or more DNS blackhole lists. These lists contains ip addresses that
are known to have open proxies or relay spam.</p>
</div>
