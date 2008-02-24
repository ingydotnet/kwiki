package Kwiki::OpenID;
use strict;

use Kwiki::UserName '-Base';
use mixin 'Kwiki::Installer';

use Kwiki::Users::OpenID;   # In order to fill the __DATA__
use Net::OpenID::Consumer;
use LWPx::ParanoidAgent;
use Digest::SHA1 qw(sha1);
use Text::Microformat;
use CGI;

our $VERSION = 0.01;

const class_id    => 'user_name';
const class_title => 'Kwiki with OpenID authentication';
const css_file    => 'user_name.css';
const cgi_class   => 'Kwiki::OpenID::CGI';

field -package    => 'Kwiki::PageMeta', 'edit_by_icon';

sub register {
    my $registry = shift;
    $registry->add(preload => 'user_name');
    $registry->add(action  => 'return_openid');
    $registry->add(action  => 'logout_openid');
    $registry->add(action  => 'login_openid');
    $registry->add(action  => 'check_login_openid');
    $registry->add(hook    => 'page_metadata:sort_order', post => 'sort_order_hook');
    $registry->add(hook    => 'page_metadata:update', post => 'update_hook');
}

sub sort_order_hook {
    my $hook = pop;
    return $hook->returned, 'edit_by_icon';
}

sub update_hook {
    my $meta = $self->hub->pages->current->metadata;
    $meta->edit_by_icon($self->hub->users->current->icon);
}

sub logout_openid {
    $self->hub->cookie->write(openid => {}, { -expires => "-3d" });
    $self->render_screen(content_pane => 'logout_openid.html');
}

sub login_openid {
    my $oi_referer = $self->cgi->page;
    my $ci         = $self->cgi->oi_url;
    if ($ci) {
        my $session = $self->hub->session->load;
        $session->param('oi_referer', $oi_referer); # Safe for later

        my $nonce_pattern = $self->config->consumer_secret;
        my $nonce = sha1(sprintf($nonce_pattern, time, (stat $0)[9], -s _, $session->id));
        $session->param('nonce', $nonce);

        my $script_name = $self->config->script_name;

        my $q = CGI->new;

        my $csr = Net::OpenID::Consumer->new(
            ua   => LWPx::ParanoidAgent->new,
            args => $q,
            consumer_secret => $nonce, 
            required_root => $script_name,
        );
        my $claimed_identity = $csr->claimed_identity($ci);

        unless (defined $claimed_identity) {
            warn "Can't determine claimed identity for: [$ci]";
            return $self->redirect('action=login_openid;oi_error=Wrong identity');
        }
        my $check_url = $claimed_identity->check_url(
            return_to => $script_name . "?action=check_login_openid",
        );
        $self->redirect($check_url);    # Now we send the user to authenticate
    }
    $self->render_screen(
        content_pane => 'login_openid.html', page => $oi_referer);
}

sub check_login_openid {
    my %cgi_args = ();
    my $cgi = $self->cgi;

    my $q  = CGI->new;
    my $ua = LWPx::ParanoidAgent->new;

    my $session = $self->hub->session->load;
    my $page    = $session->param('oi_referer');
    my $nonce   = $session->param('nonce');

    my $csr = Net::OpenID::Consumer->new(
        ua   => $ua,
        args => $q,
        consumer_secret => $self->hub->session->load->param('nonce'),
    );

    if (my $setup_url = $csr->user_setup_url) {
        $self->redirect($setup_url);
    }
    elsif ($csr->user_cancel) {
        $self->redirect('action=login_openid;oi_error=User cancel');
    }
    elsif (my $vident = $csr->verified_identity) {
        my $verified_url = $vident->url;
        $self->create_cookie($ua, $verified_url);
        $self->redirect("?$page");
    } 
    else {
        $self->redirect('action=login_openid;oi_error=Service temporarily unavailable');
    }
}

sub create_cookie {
    my ($ua, $url) = @_;
    my $doc = Text::Microformat->new($ua->get($url)->content);
    my @formats = $doc->find({ class => 'vcard' });
    my $hcard = shift @formats;
    my %cookie = (
        oi_url   => $url,
    );
    if (defined $hcard) {
        my $fn    = $hcard->Get('fn');
        my $email = $hcard->Get('email');
        my $nick  = $hcard->Get('nickname');
        my $name  =   $fn ne $url     ? $fn   
                    : defined $nick   ? $nick
                    : defined $email  ? $email
                    : $url
                    ;
        $name     =~ s/\s+//g;
        @cookie{qw/fn name nickname email icon url/} = (
            $fn, $name, $nick, $email,
            $hcard->Get('photo'), $hcard->Get('url'),
        );
    };

    #use Data::Dumper;
    #warn "============= COOKIE ===============\n";
    #warn Dumper(\%cookie);

    $doc->delete;
    $self->hub->cookie->write(openid => \%cookie);    
}


package Kwiki::OpenID::CGI;
use Kwiki::CGI '-Base';

cgi 'oi_url';
cgi 'page';
cgi 'url';
cgi 'icon';
cgi 'fn';
cgi 'name';
cgi 'email';
cgi 'nickname';


package Kwiki::OpenID;

1;

__DATA__


__css/user_name.css__
div #user_name_title {
  font-size: small;
  float: right;
}

input.openid_input {
  background: url(/icons/openid-inputicon.gif) no-repeat;
  background-color: #fff;
  background-position: 0 50%;
  padding-left: 18px;
}
__template/tt2/user_name_title.html__
<!-- BEGIN user_name_title.html -->
<div id="user_name_title">
<em>[% IF hub.users.current.name -%]
(You are <a href="[% script_name _ '?' _ hub.users.current.name %]">[% hub.users.current.name | html %]</a>: <a href="[% script_name %]?action=logout_openid">Logout</a>)
[%- ELSE -%]
(Not Logged In: <a href="[% script_name _ "?action=login_openid&page=" _ hub.cgi.page_name %]">Login via OpenID</a>)
[%- END %]
</em>
</div>
<!-- END user_name_title.html -->
__template/tt2/login_openid.html__
<!-- BEGIN login_openid.html -->
[% IF hub.cgi.oi_error %]
<div class="error">Error: [% hub.cgi.oi_error %]</div>
[% END %]
<form action="[% script_name %]" method="get">
<input type="hidden" name="page" value="[% page %]">
<input type="hidden" name="action" value="login_openid">
<b>Your OpenID URL:</b> <input type="text" class="openid_input" name="oi_url" size="30">
<input style="background: rgb(255, 98, 0) none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; color: rgb(255, 255, 255);" value="Login" type="submit">
</form>
__template/tt2/logout_openid.html__
<!-- BEGIN logout_openid.html -->
<p>You've now successfully logged out.</p>
<!-- END logout_openid.html -->
__theme/basic/template/tt2/theme_title_pane.html__
<div id="title_pane">
  <h1>
[% IF hub.users.current.icon %]<a href="[% script_name %]?"><img src="[% hub.users.current.icon %]" height="36" style="vertical-align: middle; border: 0" /></a>[% END -%]
  [% screen_title || self.class_title %]
  </h1>
</div>
__icons/openid-inputicon.gif__
R0lGODlhEAAQAMQAAO3t7eHh4srKyvz8/P5pDP9rENLS0v/28P/17tXV1dHEvPDw8M3Nzfn5+d3d
3f5jA97Syvnv6MfLzcfHx/1mCPx4Kc/S1Pf189C+tP+xgv/k1N3OxfHy9NLV1/39/f///yH5BAAA
AAAALAAAAAAQABAAAAVq4CeOZGme6KhlSDoexdO6H0IUR+otwUYRkMDCUwIYJhLFTyGZJACAwQcg
EAQ4kVuEE2AIGAOPQQAQwXCfS8KQGAwMjIYIUSi03B7iJ+AcnmclHg4TAh0QDzIpCw4WGBUZeikD
Fzk0lpcjIQA7
