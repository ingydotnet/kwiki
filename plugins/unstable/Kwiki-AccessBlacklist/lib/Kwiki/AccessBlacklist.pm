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

__DATA__

=head1 NAME

Kwiki::AccessBlacklist - Blacklist IP Addresses from Kwiki

=head1 SYNOPSIS

    PerlAccessHandler Kwiki::AccessBlacklist
    PerlSetVar KwikiAccessBlacklist /path/to/blacklist

=head1 DESCRIPTION

This ip address blacklisting module is installed as a mod_perl access
handler. It really has nothing to do with Kwiki per se, but I wrote it
to block people who post wiki spam.

Just create a blacklist file with one ip address per entry. If you only
specify 3, 2 or 1 nodes, that will block a /8, /16 or /24 respectively.

Here is a sample list:

    11.22.33.44
    11.22.33.55
    11.22.44

Everytime you change this list, Kwiki::AccessBlacklist will generate it
into a DB file for fast lookup. The file will be named the same as the
blacklist except with '.db' appended to it. You need to make sure that
Apache has write permissions to create the DB file.

Also if you delete the original blacklist, Kwiki::AccessBlacklist will
regenerate it from the DB file. In sorted order. That is nice for
cleaning up the blacklist.

=head1 AUTHOR

Brian Ingerson <ingy@ttul.org>

=head1 COPYRIGHT

Copyright (c) 2004. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
