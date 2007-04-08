package Perldoc;
use strict;
use warnings;
use base 'Perldoc::Base';
# use base 'Tie::Hash';
use Perldoc::Base;
use 5.006001;
our $VERSION = '0.20';
our @EXPORT = '%DOC';

field 'dom' => -init => '$self->to_dom';

our %DOC;
# tie %DOC, 'Perldoc';

sub documents_from_module() {
    # class method to return a zero or more new Perldoc::Document objects from
    # a module.
}

sub to_html {
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

sub to_dom {
    require Perldoc::Dom;
    return Perldoc::Dom->new();
}

# sub to_pod {}
# sub to_kwid {}

#-------------------------------------------------------------------------------
field 'input_string';
field 'input_stringref';
field 'input_filehandle';
field 'input_filepath';

sub read {
    my $self = shift;
    for my $source (qw(string stringref filepath filehandle)) {
        if (defined $self->{"input_$source"}) {
            my $method = "read_$source";
            return $self->$method();
        }
    }
    die "No input to read";
}

sub read_string {
    my $self = shift;
    return $self->input_string;
}

sub read_stringref {
    my $self = shift;
    return ${$self->input_stringref};
}

sub read_filepath {
    my $self = shift;
    my $filepath = $self->input_filepath;
    open my $input, $filepath
      or die "Can't open '$filepath' for input:\n$!";
    local $/;
    return <$input>
}

sub read_filehandle {
    my $self = shift;
    my $filehandle = $self->input_filehandle;
    local $/;
    return <$filehandle>;
}

#-------------------------------------------------------------------------------
field 'output_stringref';
field 'output_filehandle';
field 'output_filepath';
field 'output_handle' => -init => '$self->open_handle';

sub write {
    my $self = shift;
    for my $target (qw(stringref filepath filehandle)) {
        if (defined $self->{"output_$target"}) {
            my $method = "write_$target";
            return $self->$method(@_);
        }
    }
    die "No destination for Perldoc::Writer to write to";
}

sub write_stringref {
    my $self = shift;
    ${$self->output_stringref} .= shift(@_);
}

sub write_filepath {
    my $self = shift;
    my $filehandle = $self->output_handle;
    print $filehandle shift(@_);
}

sub write_filehandle {
    my $self = shift;
    my $filehandle = $self->output_filehandle;
    print $filehandle shift(@_);
}

sub open_handle {
    my $self = shift;
    my $filepath = $self->output_filepath;
    $filepath = "> $filepath"
      unless $filepath =~ /^>/;
    open my $ouput, $filepath
      or die "Can't open '$filepath' for output:\n$!";
    return $filepath;
}

=head1 NAME

Perldoc::Writer - Writer Class for Perldoc Parsers

=head1 SYNOPSIS

    package Perldoc::Writer;

=head1 DESCRIPTION

Uniform writing interface.

XXX - Should be a mixin for Emitters.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

Audrey wrote the original code for this parser.

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut

=head1 NAME

Perldoc::Reader - Reader Class for Perldoc Parsers

=head1 SYNOPSIS

    package Perldoc::Reader;

=head1 DESCRIPTION

Uniform reading interface.

XXX - Should be a mixin for Parsers.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

Audrey wrote the original code for this parser.

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut

=head1 NAME

Perldoc - Documentation Framework for Perl

=head1 SYNOPSIS

    > perl-doc --kwid-to-html Doc.kwid > Doc.html

=head1 DESCRIPTION

Perldoc is meant to be a full featured documentation framework for Perl.

This release just contains enough functionality to convert Kwid to HTML.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>
Audrey Tang <autrijus@cpan.org>

Audrey wrote the original code for this parser.

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
