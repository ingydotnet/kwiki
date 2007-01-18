package Kwiki::CSS;
use Kwiki::WebFile -Base;

const class_id => 'css';
const default_path_method => 'css_path';

conf css_path => [ 'css' ];

sub _append_file {
    my ($files, $file_path) = @_;
    unshift @$files, $file_path;
}

__DATA__

=head1 NAME

Kwiki::CSS - Kwiki CSS Base Class

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

Copyright (c) 2004. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
