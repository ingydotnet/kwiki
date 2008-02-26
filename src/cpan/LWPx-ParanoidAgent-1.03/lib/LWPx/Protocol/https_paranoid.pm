#
package LWPx::Protocol::https_paranoid;

# $Id: https_paranoid.pm 2 2005-06-01 23:12:25Z bradfitz $

use strict;

use vars qw(@ISA);
require LWPx::Protocol::http_paranoid;
@ISA = qw(LWPx::Protocol::http_paranoid);

sub _check_sock
{
    my($self, $req, $sock) = @_;
    my $check = $req->header("If-SSL-Cert-Subject");
    if (defined $check) {
	my $cert = $sock->get_peer_certificate ||
	    die "Missing SSL certificate";
	my $subject = $cert->subject_name;
	die "Bad SSL certificate subject: '$subject' !~ /$check/"
	    unless $subject =~ /$check/;
	$req->remove_header("If-SSL-Cert-Subject");  # don't pass it on
    }
}

sub _get_sock_info
{
    my $self = shift;
    $self->SUPER::_get_sock_info(@_);
    my($res, $sock) = @_;
    $res->header("Client-SSL-Cipher" => $sock->get_cipher);
    my $cert = $sock->get_peer_certificate;
    if ($cert) {
	$res->header("Client-SSL-Cert-Subject" => $cert->subject_name);
	$res->header("Client-SSL-Cert-Issuer" => $cert->issuer_name);
    }
    if(! eval { $sock->get_peer_verify }) {
       $res->header("Client-SSL-Warning" => "Peer certificate not verified");
    }
}

#-----------------------------------------------------------
package LWPx::Protocol::https_paranoid::Socket;

use vars qw(@ISA);
require Net::HTTPS;
@ISA = qw(Net::HTTPS LWPx::Protocol::http_paranoid::SocketMethods);

1;
