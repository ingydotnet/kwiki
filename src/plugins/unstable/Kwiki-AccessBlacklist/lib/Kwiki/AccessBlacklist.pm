package Kwiki::AccessBlacklist;
use Spiffy -Base;
use mixin 'Spoon::IndexList';
use Apache::Constants qw(:common REDIRECT);
our $VERSION = '0.10';

field 'blacklist_path';

sub handler($$) {
    my $self = (shift)->new;
    my $r = shift;
    $self->blacklist_path($r->dir_config('KwikiAccessBlacklist'));
    my $ip_address = $self->get_ip_address($r)
      or return FORBIDDEN;;
    return $self->blacklisted($ip_address)
    ? $self->deny($r)
    : OK;
}

sub get_ip_address {
    my $r = shift;
    my $ip_address = $r->header_in('X-Forwarded-For') || 
                     $r->connection->remote_ip
      or return;
    $ip_address =~ /((?:\d{1,3}\.){3}\d{1,3})\s*$/
      or return;
    $ip_address = $1;
    return $ip_address;
}

sub blacklisted {
    my $ip_address = shift;
    my $index = $self->index_list($self->blacklist_path);
    while (1) {
        return 1 if $index->{$ip_address};
        last unless $ip_address =~ s/\.\d+$//;
    }
    return 0;
}

sub deny {
    my $r = shift;
    $r->headers_out->set(Location => 'http://zombo.com');
    return REDIRECT;
}
