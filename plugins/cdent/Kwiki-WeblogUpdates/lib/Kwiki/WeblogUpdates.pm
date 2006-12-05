package Kwiki::WeblogUpdates;
use Kwiki::Plugin '-Base';

const class_id => 'weblog_updates';
const class_title => 'Weblog Updates';


# XXX oh, very confused, want to make sure we post process, but only
# when page:store has happened. and somehow need to know what 
# page was changed. And really need a <link> to rss in each page
sub init {
    $self->hub->add_hook('page:store' => post => 'weblog_updates:send_ping');
}


sub send_ping {
    my $page = shift;

    # XXX what sort of escaping do we need on this
    my $full_url = $self->config->wiki_url .  $self->config->script_name .
        '?' . $page->uri;
    my $title = $self->config->wiki_title . ' - ' . $page->title;
    my $ping_text =<<"EOF";
<?xml version="1.0"?>
<methodCall>
    <methodName>weblogUpdates.ping</methodName>
    <params>
        <param>
            <value>$title</value>
        </param>
        <param>
            <value>$full_url</value>
        </param>
    </params>
</methodCall>
EOF

    my @ping_sites = @{$self->config->weblog_updates_url};
    foreach my $url (@ping_sites) {
        $self->do_ping($url, $full_url, $ping_text);
    }
}

sub do_ping {
    my ($url, $full_url, $ping_text) = @_;

    require LWP::UserAgent;

    my $ua  = LWP::UserAgent->new();
    $ua->agent('Socialtext Workspace v' . $self->hub->main->product_version);
    my $req = HTTP::Request->new('POST', $url);
    $req->header('Content-Type' => 'text/xml');
    $req->content($ping_text);

    my $res = $ua->request($req);
    # XXX this amounts to a log of the ping in the error log
    # which is helpful while we are testing 
    warn "weblog ping for $full_url", $res->content, "\n";
    # XXX bail on dealing with response; we've already let go of the user
}
