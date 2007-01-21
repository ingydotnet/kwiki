package Kwiki::IRCMode;
our $VERSION = '0.30';


use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-Base';

const class_id => 'irc';
const css_file => 'irc.css';
const class_title => 'Kwiki IRC Log Waffle';

sub register {
  my $registry = shift;
  $registry->add(wafl => irc => 'Kwiki::IRCMode::Wafl' );
}

package Kwiki::IRCMode::Wafl;
use base qw(Spoon::Formatter::WaflBlock);

use Parse::IRCLog;
my $p = Parse::IRCLog->new;


sub to_html {
  my (@msgs, %nicks);

  my $html = "<blockquote class='irc'>\n";

  for (split("\n", $self->block_text)) {
    my $event = $p->parse_line($_); $event->{nick_prefix} ||= '';
    defined $nicks{$event->{nick}} or $nicks{$event->{nick}} = scalar keys %nicks;
    $html .= "<p>";
    if (defined $event->{timestamp}) { $html .= "[$event->{timestamp}]"; }
    if ($event->{type} eq 'msg') {
      $html .=
        "&lt;$event->{nick_prefix}<span class='u$nicks{$event->{nick}}'>$event->{nick}</span>&gt; $event->{text}";
    } elsif ($event->{type} eq 'action') {
      $html .=
        " * <span class='u$nicks{$event->{nick}}'>$event->{nick}</span> $event->{text}";
    } else {
      $html .= "$event->{text}";
    }
    $html .= "</p>\n";
  }

  $html .= "</blockquote>\n";

  return $html;
}


package Kwiki::IRCMode;

__DATA__
__css/irc.css__
blockquote.irc {
  background-color: #ddd;
}
blockquote.irc span.u0 { color: #f00; }
blockquote.irc span.u1 { color: #00f; }
blockquote.irc span.u2 { color: #0f0; }
blockquote.irc span.u3 { color: #a0a; }
blockquote.irc p { margin: 0; padding: 0; }
