package WikiText::WikRad;
use base 'WikiText';

use 5.006.001;
our $VERSION = '0.10';

1;

=head1 NAME

WikiText::Wikrad - Wikrad WikiText Module

=head1 SYNOPSIS

    use WikiText::Wikrad;

    my $markup = WikiText::Wikrad
        ->new($wikitext)
        ->from('Socialtext')
        ->to_wikrad;
    
=head1 DESCRIPTION

This module can convert other markup to Wikrad.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
