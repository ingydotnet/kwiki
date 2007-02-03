# @COPYRIGHT@
package Socialtext::Formatter::Viewer;
use strict;
use warnings;

use base 'Socialtext::Base';

use Class::Field qw( const field );
use Socialtext::Formatter::LinkDictionary;
use Socialtext::Formatter::Parser;
use Socialtext::Statistics 'stat_call';
use Readonly;

sub class_id { 'viewer' }
const class_title  => 'NLW Viewer';

field page_id         => '';
field url_prefix      => '';

field parser => -init =>
    'Socialtext::Formatter::Parser->new(table=>$self->hub->formatter->table,wafl_table=>$self->hub->formatter->wafl_table);';
field link_dictionary => -init =>
    'Socialtext::Formatter::LinkDictionary->new()';

Readonly my $MAX_SIZE => 500_000;

our $in_paragraph = 0;
sub text_to_html {
    my $self = shift;
    $in_paragraph = 0;
    $self->to_html( $self->parser->text_to_parsed(@_), $self->hub );
}

sub SELF () { 0 }
sub TREE () { 1 }
sub HUB  () { 2 }

# XXX the variable assignments happening here make this sub 
# less performant than it could be
sub to_html {
    my $html = $_[TREE]->html();

    if ($_[TREE]->formatter_id eq 'p') {
        $in_paragraph = 1;
    }
    # get the internal units
    for ( @{ $_[TREE]->units } ) {
        if ( ref ($_) ) {
            $_->{hub} = $_[HUB];
            $html .= $_[SELF]->to_html($_, $_[HUB]);
        }
        else {
            $html .= $_[TREE]->escape_html($_);
        }
    }

    $html = $_[TREE]->html_start()
        . $_[TREE]->text_filter($html)
        . $_[TREE]->html_end();
    $in_paragraph = 0;
    return $html;
}

sub to_text {
    my $self = shift;
    my $tree = shift;
    $tree->get_text;
}

# special
sub process {
    my $self = shift;
    my $raw_text        = shift;
    my $page            = shift;
    
    my $large_formatted = $self->_large_check(\$raw_text);
    return $large_formatted if $large_formatted;

    # XXX is there a difference between this and pages->current->id
    $self->page_id($page->id) if $page;

    # XXX note, if we assign to something before returning here,
    # the cost of this sub SKYrockets
    return $self->to_html( $self->_get_parse_tree( $raw_text, $page ),
        $self->hub );
}

sub _get_parse_tree {
    my $self = shift;
    my ( $text, $page ) = @_;

    return ( defined $page and $page )
        ? $self->parser->get_cached_tree( $text, $page,
            $self->hub->current_workspace->workspace_id )
        : $self->parser->text_to_parsed($text);
}

sub _detab {
    my $self = shift;
    my $text = shift;
    $text
        =~ s/(?mi:^tsv:\s*\n)((.*(?:\t| {3,}).*\n)+)/$self->_detab_table($1)/eg;
    $text;
}

sub _detab_table {
    my $self = shift;
    my $text = shift;

    $text =~ s/(\t| {3,})/|/g;
    $text =~ s/^/|/gm;
    $text =~ s/\n/|\n/gm;

    return $text;
}

sub _large_check {
    my $self = shift;
    my $text_ref = shift;
    my $length = length $$text_ref;
    return if $length < $MAX_SIZE;

    my $html = $self->html_escape( $$text_ref );
    $html =~ s/\n/<br \/>\n/g;

    my $size_str = _commafy_number($MAX_SIZE);
    return join '',
        qq{<p style="color:red">Text not formatted. Exceeds $size_str characters. ($length)</p>\n},
        $html;
}

# EXTRACT: this probably belongs in a Helper, Number or String-type class
sub _commafy_number {
    my $number = shift;

    1 while $number =~ s/(\d)(\d\d\d)(,|$)/$1,$2$3/;

    return $number;
}

1;

__END__

=head1 NAME

Socialtext::Formatter::Viewer - Transform a tree of Units into HTML

=head1 SYNOPSIS

    # text_to_html
    my $html = $hub->viewer->text_to_html($wiki_text);

    # parsed tree to html
    my $parser = Socialtext::Formatter::Parser->new(
        table = $hub->formatter->table,
        wafl_table = $hub->formatter->wafl_table,
    );
    my $units = $parser->text_to_parsed('Some text to parse');
    my $html = $hub->viewer->to_html($units);

=head1 DESCRIPTION

A viewer tranforms a tree of L<Socialtext::Formatter::Unit> into other
forms. At this point it only transforms into HTML.

=head1 METHODS

(TODO)

=over 4

=item text_to_html

Turn some wikitext into HTML, hiding the details.

=item to_html

Turn a tree of L<Socialtext::Formatter::Unit> into HTML.

=item process

Utilize caching while turning an L<Socialtext::Page> into HTML.

=back

=head1 AUTHOR

Socialtext, Inc., <code@socialtext.com>

=head1 COPYRIGHT & LICENSE

Copyright 2006 Socialtext, Inc., All Rights Reserved.

=cut
