package Kwiki::Invite;
use Kwiki::Plugin qw(-Base -XXX);
use MIME::Lite;
use mixin 'Kwiki::Installer';
our $VERSION = '0.01';

const class_id => 'invite';
const class_title => 'Kwiki Invite Plugin';
const css_file => 'invite.css';
const cgi_class => 'Kwiki::Invite::CGI';
const config_file => 'invite.yaml';

sub register {
    my $registry = shift;
    $registry->add(action => 'invite');
    $registry->add(toolbar => 'invite', template => 'invite_toolbar.html');
}

sub invite {
    if(my $mode = $self->cgi->run_mode) {
	$self->$mode;
    }
    $self->render_screen;
}

sub post {
    my $user = $self->users->current->name || "Debugger";
    my $to   = $self->cgi->email           || "i.am\@debuggi.ng";
    my $from = $self->config->invitation_from_address;
    my $subject = "$user invites you to visit our site.";
    my $words = $self->cgi->words || "";
    my $body = $self->template_process($self->config->invitation_template,user => $user, words => $words);
    $self->mail_it($to,$from,$subject,$body);
}

field debug => 0;

sub mail_it {
    my ($to,$from,$subject,$body) = @_;
    my $msg = MIME::Lite->new(
	To      => $to,
	From    => $from,
	Subject => $subject,
	Data    => $body,
    );
    if($self->debug || $self->config->invitation_debug) {
	my $o = io("/tmp/kwiki-invite-msg.txt");
	$o->assert->print($msg->as_string);
    } else {
	$msg->send;
    }
    return $msg;
}

package Kwiki::Invite::CGI;
use base 'Kwiki::CGI';

cgi 'run_mode';
cgi 'email';
cgi 'words';

package Kwiki::Invite;

__DATA__

=head1 NAME

  Kwiki::Invite - Invite your friends to this kwiki.

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 COPYRIGHT

Copyright 2005 by Kang-min Liu <gugod@gugod.org>.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

See <http://www.perl.com/perl/misc/Artistic.html>

=cut

__config/invite.yaml__
invitation_template: invite_mail_content.txt
invitation_from_address: edit@me.com
invitation_site_name: "My Kwiki Site"
invitation_site_url: "http://localhost/"
invitation_debug: 0
__template/tt2/invite_mail_content.txt__
Hello, [% receiver %]

[% user %] just invited you to join our site: [% invitation_site_name %] ( [% invitation_site_url %] ):

[% words %]

__template/tt2/invite_toolbar.html__
<a href="[% script_name %]?action=invite">
Invite
</a>
__template/tt2/invite_content.html__
<div class="invite_content">
<form action="[% script_name %]" method="POST" >
<input type="hidden" name="action" value="invite" />
<input type="hidden" name="run_mode" value="post" />

<label>To</label>
<input type="text" name="email" />

<label>Words</label>
<textarea name="words"></textarea>

<input type="submit" name="submit" value="invite" />

</form>
</div>
__css/invite.css__
.invite_content label { display: block; }
.invite_content input[type="text"],
.invite_content textarea
 { margin-left: 2em; }
.invite_content textarea { width: 20em; height: 8em; }
