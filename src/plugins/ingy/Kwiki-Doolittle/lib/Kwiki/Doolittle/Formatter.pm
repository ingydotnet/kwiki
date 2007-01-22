package Kwiki::Doolittle::Formatter;
use Kwiki::Formatter -Base;

sub text_to_html {
    if ($_[0] =~ /^=head/m) {
        require Kwiki::Formatter::Pod;
        return Kwiki::Formatter::Pod->new->text_to_html(@_);
    }
    return $self->SUPER::text_to_html(@_);
}

package Kwiki::Formatter::ForcedLink;
no warnings 'redefine';
sub pattern_start { qr/\[([$WORD\-]+)\]/ }


package Kwiki::Formatter::WikiLink;
our $pattern =
    qr/[$UPPER](?=[$WORD\-]*[$UPPER])(?=[$WORD\-]*[$LOWER])[$WORD\-]+/;
sub pattern_start { qr/$pattern|!$pattern/ }
