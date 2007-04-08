package Module::Optimize;

use 5.006;
use strict;
use warnings;
use Module::Compile -base;

sub pmc_is_optimizer_module { 1 }

# Compile/Filter some source code into something else. This is almost
# always overridden in a subclass.
sub pmc_optimize {
    my ($class, $source) = @_;
    return $source;
}

1;

__END__

=head1 NAME

Module::Compile - Perl Module Optimization

=head1 SYNOPSIS

    package Foo;
    use Module::Optimize -base;

    sub pmc_optimize {
        my ($self, $source) = @_;
        # Convert perl5 $source into semantically equivalent $compiled_output
        return $compiled_output;
    }

In F<Bar.pm>:
  
    package Bar;
    
    use Foo;

or lexically:

    package Bar;
    
    {
        use Foo;
        ...
    }

To compile F<Bar.pm> into F<Bar.pmc>:

    perl -c Bar.pm

=head1 DESCRIPTION

This module provides a system for writing modules that I<compile> other
Perl modules.

Modules that use these compilation modules get compiled into some
altered form the first time they are run. The result is cached into
C<.pmc> files.

Perl has native support for C<.pmc> files. It always checks for them, before
loading a C<.pm> file.

You get the following benefits:

=head1 SEE ALSO

Module::Compile

=head1 AUTHORS

Audrey Tang <autrijus@autrijus.org>

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
