#============================================================= -*-Perl-*-
#
# Template::Plugin::Iterator
#
# DESCRIPTION
#
#   Plugin to create a Template::Iterator from a list of items and optional
#   configuration parameters.
#
# AUTHOR
#   Andy Wardley   <abw@wardley.org>
#
# COPYRIGHT
#   Copyright (C) 2000-2006 Andy Wardley.  All Rights Reserved.
#
#   This module is free software; you can redistribute it and/or
#   modify it under the same terms as Perl itself.
#
# REVISION
#   $Id: Iterator.pm 1055 2007-04-27 11:50:40Z abw $
#
#============================================================================

package Template::Plugin::Iterator;

use strict;
use warnings;
use base 'Template::Plugin';
use Template::Iterator;

our $VERSION = 2.68;

#------------------------------------------------------------------------
# new($context, \@data, \%args)
#------------------------------------------------------------------------

sub new {
    my $class   = shift;
    my $context = shift;
    Template::Iterator->new(@_);
}

1;

__END__


#------------------------------------------------------------------------
# IMPORTANT NOTE
#   This documentation is generated automatically from source
#   templates.  Any changes you make here may be lost.
# 
#   The 'docsrc' documentation source bundle is available for download
#   from http://www.template-toolkit.org/docs.html and contains all
#   the source templates, XML files, scripts, etc., from which the
#   documentation for the Template Toolkit is built.
#------------------------------------------------------------------------

=head1 NAME

Template::Plugin::Iterator - Plugin to create iterators (Template::Iterator)

=head1 SYNOPSIS

    [% USE iterator(list, args) %]

    [% FOREACH item = iterator %]
       [% '<ul>' IF iterator.first %]
       <li>[% item %]
       [% '</ul>' IF iterator.last %]
    [% END %]

=head1 DESCRIPTION

The iterator plugin provides a way to create a Template::Iterator object 
to iterate over a data set.  An iterator is implicitly automatically by the
FOREACH directive.  This plugin allows the iterator to be explicitly created
with a given name.

=head1 AUTHOR

Andy Wardley E<lt>abw@wardley.orgE<gt>

L<http://wardley.org/|http://wardley.org/>




=head1 VERSION

2.68, distributed as part of the
Template Toolkit version 2.19, released on 27 April 2007.

=head1 COPYRIGHT

  Copyright (C) 1996-2007 Andy Wardley.  All Rights Reserved.


This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<Template::Plugin|Template::Plugin>, L<Template::Iterator|Template::Iterator>

=cut

# Local Variables:
# mode: perl
# perl-indent-level: 4
# indent-tabs-mode: nil
# End:
#
# vim: expandtab shiftwidth=4:
