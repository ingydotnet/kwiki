package WikiText;
use strict;
use warnings;

use 5.006.001;
our $VERSION = '0.09';

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    $self->{wikitext} = shift;
    return $self;
}

sub to_html {
    my $self = shift;
    my $parser_class = ref($self) . '::Parser';
    eval "require $parser_class; 1"
      or die "Can't load $parser_class:\n$@";
    require WikiText::HTML::Emitter;
    my $parser = $parser_class->new(
        receiver => WikiText::HTML::Emitter->new,
    );

    return $parser->parse($self->{wikitext});
}

1;

=encoding utf8

=head1 NAME

WikiText - Wiki Text Conversion Tools

=head1 SYNOPSIS

    use WikiText::Sample::Parser;
    use WikiText::HTML::Emitter;
    
    my $parser = WikiText::Sample::Parser->new(
        receiver => WikiText::HTML::Emitter->new,
    );
    
    my $wikitext = "== A Title

    This is some text that contains a '''bold phrase''' in it.
    ";
    
    my $html = $parser->parse($wikitext);

=head1 DESCRIPTION

The WikiText modules parse documents in various formats. A parse has a
receiver. The receiver takes the parse events and creates a new form. The new
form can be HTML, an AST or another wiki markup.

Some formats are richer than others. The module WikiText::WikiByte defines a
bytecode format. The bytecode format is rich enough to be a receiver for any
parse, therefore it makes an ideal intermediate format.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
