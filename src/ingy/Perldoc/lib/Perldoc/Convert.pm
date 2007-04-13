package Perldoc::Convert;
use strict;
use warnings;
use Perldoc::Base -base;

sub kwid_to_html {
    my $self = shift;
    require Perldoc::Parser::Kwid;
    require Perldoc::Emitter::HTML;

    my $html = '';
    $self->output_stringref(\$html);
    my $receiver = Perldoc::Emitter::HTML->new(
        document => $self,
    );
    my $parser = Perldoc::Parser::Kwid->new(
        receiver => $receiver,
        document => $self,
    );
    $parser->parse;
    return $html;
}

1;
