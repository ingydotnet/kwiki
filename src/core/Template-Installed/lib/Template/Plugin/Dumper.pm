#==============================================================================
# 
# Template::Plugin::Dumper
#
# DESCRIPTION
#
# A Template Plugin to provide a Template Interface to Data::Dumper
#
# AUTHOR
#   Simon Matthews <sam@knowledgepool.com>
#
# COPYRIGHT
#   Copyright (C) 2000 Simon Matthews.  All Rights Reserved
#
#   This module is free software; you can redistribute it and/or
#   modify it under the same terms as Perl itself.
#
# REVISION
#   $Id: Dumper.pm 1055 2007-04-27 11:50:40Z abw $
# 
#==============================================================================

package Template::Plugin::Dumper;

use strict;
use warnings;
use base 'Template::Plugin';
use Data::Dumper;

our $VERSION = 2.70;
our $DEBUG   = 0 unless defined $DEBUG;
our @DUMPER_ARGS = qw( Indent Pad Varname Purity Useqq Terse Freezer
                       Toaster Deepcopy Quotekeys Bless Maxdepth );
our $AUTOLOAD;

#==============================================================================
#                      -----  CLASS METHODS -----
#==============================================================================

#------------------------------------------------------------------------
# new($context, \@params)
#------------------------------------------------------------------------

sub new {
    my ($class, $context, $params) = @_;
    my ($key, $val);
    $params ||= { };


    foreach my $arg (@DUMPER_ARGS) {
	no strict 'refs';
	if (defined ($val = $params->{ lc $arg })
	    or defined ($val = $params->{ $arg })) {
	    ${"Data\::Dumper\::$arg"} = $val;
	}
    }

    bless { 
	_CONTEXT => $context, 
    }, $class;
}

sub dump {
    my $self = shift;
    my $content = Dumper @_;
    return $content;
}


sub dump_html {
    my $self = shift;
    my $content = Dumper @_;
    for ($content) {
	s/&/&amp;/g;
	s/</&lt;/g;
	s/>/&gt;/g;
	s/\n/<br>\n/g;
    }
    return $content;
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

Template::Plugin::Dumper - Plugin interface to Data::Dumper

=head1 SYNOPSIS

    [% USE Dumper %]

    [% Dumper.dump(variable) %]
    [% Dumper.dump_html(variable) %]

=head1 DESCRIPTION

This is a very simple Template Toolkit Plugin Interface to the Data::Dumper
module.  A Dumper object will be instantiated via the following directive:

    [% USE Dumper %]

As a standard plugin, you can also specify its name in lower case:

    [% USE dumper %]

The Data::Dumper 'Pad', 'Indent' and 'Varname' options are supported
as constructor arguments to affect the output generated.  See L<Data::Dumper>
for further details.

    [% USE dumper(Indent=0, Pad="<br>") %]

These options can also be specified in lower case.

    [% USE dumper(indent=0, pad="<br>") %]

=head1 METHODS

There are two methods supported by the Dumper object.  Each will
output into the template the contents of the variables passed to the
object method.

=head2 dump()

Generates a raw text dump of the data structure(s) passed

    [% USE Dumper %]
    [% Dumper.dump(myvar) %]
    [% Dumper.dump(myvar, yourvar) %]

=head2 dump_html()

Generates a dump of the data structures, as per dump(), but with the 
characters E<lt>, E<gt> and E<amp> converted to their equivalent HTML
entities and newlines converted to E<lt>brE<gt>.

    [% USE Dumper %]
    [% Dumper.dump_html(myvar) %]

=head1 AUTHOR

Simon Matthews E<lt>sam@knowledgepool.comE<gt>

=head1 VERSION

2.7, distributed as part of the
Template Toolkit version 2.19, released on 27 April 2007.



=head1 COPYRIGHT

Copyright (C) 2000 Simon Matthews All Rights Reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<Template::Plugin|Template::Plugin>, L<Data::Dumper|Data::Dumper>

