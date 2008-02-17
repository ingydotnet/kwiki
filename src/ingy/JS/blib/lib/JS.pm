package JS;
use strict;
use warnings;
use File::Find;
use 5.005.003;

our $VERSION = '0.10';

sub new {
    my $class = shift;
    return bless {@_}, $class;
}

sub run {
    my $self = shift;

    if (! @ARGV) {
        return $self->list_all();
    }
    for my $js_module (@ARGV) {
        $js_module =~ s/\.js$//;
        my $path = $self->find_js_path($js_module)
          or warn "*** Can't find $js_module\n";
        print "$path\n";
    }
}

sub list_all {
    my $found = {};
    find {
        wanted => sub {
            return unless /\.js$/;
            my $dir = $File::Find::dir;
            $dir =~ s{.*/JS\b(/|$)(.*)}{$2} or return;
            my $module = $dir ? "$dir/$_" : $_;
            $module =~ s/[\/\\]+/./g;
            $module =~ s/\.js$//;
            return if $found->{$module}++;
            print $module, "\n";
        },
    }, grep {-d $_ and $_ ne '.'} @INC;
}

sub find_js_path {
    my $self = shift;
    my $module = shift;
    $module =~ s/(::|\.)/\//g;
    $module .= '.js';

    my $found = {};
    my $module_path;
    find {
        wanted => sub {
            my $path = $File::Find::name;
            return unless $path =~ /\Q$module\E$/;
            return if $found->{$path}++;
            $module_path = $path;
        },
    }, grep {-d $_ and $_ ne '.'} @INC;
    return $module_path;
}

1;

=head1 NAME

JS - JavaScript Modules on CPAN

=head1 SYSNOPSIS

    > js-cpan
    > js-cpan Foo.Bar
    > ln -s `js-cpan Foo.Bar` Foo.Bar.js

=head1 DESCRIPTION

Some JavaScript modules can be installed from CPAN. This module comes
with a utility called C<js-cpan> that helps you find JavaScript modules
that have been installed on you system so that you can use them in
various projects.

=head1 EXPLANATION

The JSAN project (L<http://openjsan.org>) has successfully provided much
of the groundwork to make JavaScript module distributions look and act
like Perl module distributions.

For example, the basic file layout is similar, the Test::Harness and
Test::Simple framework has been ported to JSAN, and most modules use
Makefiles to set things up.

The Open JSAN project offers the tip off the iceberg in terms of being a
CPAN for JavaScript. However it has a long way to go and not a lot of
community to get it there.

Many projects require JavaScript components these days, and it would be
nice to simply list them in the META.yml of your Perl project
distributions.

There is a simple way to package non-Perl components into Perl/CPAN
distributions. The components get installed in your Perl system but do
not affect Perl in any other way.

JS is a module to explain and help maintain the JavaScript modules
installed from CPAN.

Some module distributions will have both Perl and JavaScript components.
Others will have only JavaScript components. All JavaScript modules and
JavaScript module distributions should have a top-level-namespace of 'JS'.

=head1 JS MODULE AUTHOR HOWTO

It turns out that Perl's ExtUtils::MakeMaker will install *any*
files that you put in the C<lib/> directory, into your perl's
sitelib. So setting up a JavaScript distribution is very similar to
setting on a Perl one.

Say you have a JavaScript module called C<Foo.Bar>. First create a
distribution directory called: C<JS-Foo-Bar>. Put your JavaScript code
in C<lib/JS/Foo/Bar.js>. Put your documentation in
C<lib/JS/Foo/Bar.pod>. Your Makefile.PL should look something like this:

    use inc::Module::Install;
    name     'JS-Foo-Bar';
    abstract 'Sample JavaScript Module Distribution';
    version  '0.01';
    license  'lgpl';
    all_from 'lib/JS/Foo/Bar.pod';
    WriteAll;

Create a C<Changes> and C<README> file and dummy C<test.t>. CPAN module
distributions should have these files.

Put your JavaScript tests in a directory called C<tests>. I'll write up
more explicit instructions in a future release, but for now look at
C<JS-YAML> on CPAN or any openjsan.org module as an example.

Now just run these commands:

    perl Makefile.PL
    make
    make manifest
    make dist
    cpan-upload -user foo -passwd bar -mailto foo@bar.com Foo-Bar-0.01.tar.gz

That's it. You've joined the revolution. :)

NOTE: There is a working sample JavaScript module shipped with C<JS.pm>
      in the C<examples/Foo-Bar> directory.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
