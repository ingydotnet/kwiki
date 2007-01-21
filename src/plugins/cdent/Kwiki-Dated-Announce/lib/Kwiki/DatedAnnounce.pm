package Kwiki::DatedAnnounce;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-base';

our $VERSION = 0.01;

const class_title => 'Dated Announced';
const class_id => 'dated_announce';
const css_file => 'dated_announce.css';

sub register {
    my $registry = shift;
    $registry->add(wafl => dated => 'Kwiki::DatedAnnounce::Wafl');
}

package Kwiki::DatedAnnounce::Wafl;
use base 'Spoon::Formatter::WaflBlock';

sub to_html {
    my $string = $self->block_text;
    chomp $string;
    # XXX datespec should be better than epoch
    $string =~ s/^ datespec: \s* (\w+) \s* (\w+) \s* \n+//sx;

    my $datespec = $1 || 0;
    my $duration = $2 || 0;
    my $now = time;
    
    if (($now >= $datespec) &&
        (($duration == 0) || ($now <= $datespec + $duration))) {
           return "<div class='dated'>\n" .
                  $self->hub->formatter->text_to_html($string) .
                  "</div>\n";
    } else {
        return "\n";
    }
}

package Kwiki::DatedAnnounce;
1;

__DATA__


__css/dated_announce.css__
div.dated { background: #dddddd; }
