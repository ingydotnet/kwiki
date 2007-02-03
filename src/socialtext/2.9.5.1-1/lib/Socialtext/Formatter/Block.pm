# @COPYRIGHT@
package Socialtext::Formatter::Block;
use strict;
use warnings;

use base 'Socialtext::Formatter::Unit';

sub contains_phrases {
    Socialtext::Formatter->all_phrases;
}

################################################################################
package Socialtext::Formatter::Heading;
use base 'Socialtext::Formatter::Block';
use Class::Field qw( const field );

const formatter_id => 'hx';
field 'level';

sub match {
    my $self = shift;
    my $text = shift;
    return unless $text =~ /^(\^{1,6})\s*(.*?)(\s+=+)?\s*\n+/m;
    $self->level( length($1) );
    $self->set_match($2);
}

sub html_start {
    my $self = shift;
    my $text = $self->get_text;
    my $id   = Socialtext::Page->name_to_id($text);
    sprintf '<h%s id="%s">', $self->level,
        Socialtext::Formatter::legalize_sgml_id($id);
}

sub html_end {
    my $self = shift;
    '</h' . $self->level . ">\n"
}

################################################################################
package Socialtext::Formatter::Paragraph;
use base 'Socialtext::Formatter::Block';
use Class::Field qw( const );

const formatter_id  => 'p';
const html_start    => "<p>\n";
const html_end      => "</p>\n";
const pattern_block =>
    qr/((?:^(?!(?:[\#\-\*]+ |[\^\|\>]|\.\w+\s*\n)).*\S.*\n)+(^\s*\n)*)/m;

sub text_filter {
    my $self = shift;
    my $text = shift;
    $text =~ s/(\r?\n)*\z//;
    $text =~ s/\n/<br \/>\n/g;

    # And now remove any BRs we just added WITHIN HTML comments,
    # so they don't screw up Wikiwyg.
    return $text unless $text =~ /<!--/;
    return join '', map {
        s/<br \/>// if /^<!--.*-->$/s;
        $_;
    } split /(<!--.*?-->)/s, $text;
}

################################################################################
package Socialtext::Formatter::EmptyParagraph;
use base 'Socialtext::Formatter::Paragraph';
use Class::Field qw( const );

const formatter_id  => 'empty_p';
const pattern_block => qr/((^\s*\n)+)/m;
const html_start    => "";
const html_end      => "<br />";

################################################################################
package Socialtext::Formatter::WaflParagraph;
use base 'Socialtext::Formatter::Paragraph';
use Class::Field qw( const );

const formatter_id  => 'wafl_p';
const pattern_block => qr/^(\{.*\})\n/m;
const html_start    => "";
const html_end      => "<br />";

sub text_filter { $_[1] }

################################################################################
package Socialtext::Formatter::Indent;
use base 'Socialtext::Formatter::Block';
use Class::Field qw( const field );

const formatter_id => 'indent';
field 'level';
field 'start_level';

sub match {
    my $self = shift;
    my $text = shift;
    return unless $text =~ /^(>+)/m;
    my $l = length($1);
    $self->level($l);
    return unless $text =~ /(^(>{$l}(?!>).*\n)+)/m;
    $self->set_match; # sets text field
    my $new_text = $self->text;
    $new_text =~ s/^>+\s*//gm;
    $self->text($new_text);
    return 1;
}

sub text_filter { Socialtext::Formatter::Paragraph->text_filter($_[1]) }

sub html_start {
    my $self = shift;
    my $level
        = defined $self->start_level ? $self->start_level : $self->level;
    return ( '<blockquote>' x $level ) . "\n";
}

sub html_end {
    my $self = shift;
    my $level   = $self->level;
    my $next    = $self->next_unit;
    my $newline = "\n";
    if ( ref($next) and $next->formatter_id eq 'indent' ) {
        my $next_level = $next->level;
        if ( $level < $next_level ) {
            $next->start_level( $next_level - $level );
            $level = 0;
        }
        else {
            $next->start_level(0);
            $level   = $level - $next_level;
            $newline = '';
        }
    }
    return ( '</blockquote>' x $level ) . $newline;
}

################################################################################
package Socialtext::Formatter::Item;
use base 'Socialtext::Formatter::Block';
use Class::Field qw( const );

const formatter_id => 'li';
const html_start   => "<li>";
const html_end     => "</li>\n";
const bullet       => '[\#\*\-\+]+(?=\ +|$)';

sub match {
    my $self = shift;
    my $text = shift;
    my $bullet = $self->bullet;
    return unless $text =~ /^$bullet(?:\ *)(.*)\n/m;
    $self->set_match;
}

sub text_filter {
    my $self = shift;
    my $text = shift;
    $text = "&nbsp;" if not length($text);
    $text;
}

1;
