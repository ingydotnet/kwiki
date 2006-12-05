#!/usr/bin/env perl
use strict;
use warnings;
use Cwd qw(cwd abs_path);
use File::Path;

my $lib = './lib';
my $sources = "$lib/.sources";

die "Problems accessing ./lib directory"
  if -e $lib and (not -d $lib or not -w $lib);
mkdir $lib unless -e $lib;
my @sources = -e $sources
? do {
    local *SOURCES;
    open SOURCES, $sources
      or die "Can't open $sources for input\n";
    map {chomp; $_} <SOURCES>;
}
: ();

my %sources = map {($_, 1)} @sources;

for my $path (@ARGV) {
    unless (-d $path and -d "$path/lib") {
        warn "Skipping '$path' (No lib directory)\n";
        next;
    }
    $path = abs_path($path);
    if ($sources{$path}) {
        warn "Skipping '$path' (Already in $sources)\n";
        next;
    }
    push @sources, $path;
}

my %path_map;

my $home = cwd();
for my $dir (@sources) {
    next unless -d $dir and -r $dir;
    chdir $dir or die "Couldn't chdir to $dir";
    # XXX Refactor UNIX commands into Perl
    $path_map{$_} = abs_path($_)
      for map {
          chomp;
          $_;
      } `find $lib -type f | grep '\\.pm\$'`;
}
chdir $home or die "Couldn't chdir back to $home";

for my $rel_path (keys %path_map) {
    my $abs_path = $path_map{$rel_path};
    my ($rel_dir) = ($rel_path =~ /(.*)\/\w+\.pm$/)
      or die "Can't find directory component for $rel_path";
    File::Path::mkpath($rel_dir) unless -e $rel_dir;
    unlink $rel_path if -l $rel_path;
    symlink($abs_path, $rel_path)
      or die "Can't create symlink from $rel_path to $abs_path\n";
}

open SOURCES, "> $sources"
  or die "Can't open $sources for output\n";
print SOURCES "$_\n" for @sources;
close SOURCES;

__END__

=head1 NAME

make-lib-tree.pl - Make a lib/ directory full of symlinks to Perl modules

=head1 SYNOPSIS

    > # add new source directories to a tree (see ./lib/.sources)
    > perl make-lib-tree.pl ~/src/kwiki/* ~/src/kwiki/plugins/*
    > # update an existing lib tree
    > perl make-lib-tree.pl

=head1 DESCRIPTION

Installing Perl modules can be a pain, especially for a project like
Kwiki that has potentially hundreds of modules.

Most Kwiki code lives on CPAN, but it is also available at
http://svn.kwiki.org/kwiki/ using subversion.

There is an easy solution to installing eveything from CPAN. This script
will create/maintain a directory called ./lib/ that contains symlinks to
all the modules you need to run a particular project (like Kwiki). Since
Kwiki always looks for modules in C<./lib>, you can just put this
directory in your Kwiki installation dir.

=head1 NOTES

You can put this script in your PATH if you want.

A better idea is to create a symlink to it in the same bin directory
that your 'perl' binary executable lives. (If you have the permissions
to do it.)

    > ln -s ~/src/kwiki/make-lib-tree.pl /usr/local/bin/make-lib-tree

You can actually link it into any bin directory in your path, but
putting it in the Perl one allows you to use C<perldoc make-lib-tree>.

This linking step is simply for ease of use and is not necessary to use
this script.

Also note that no special permissions are needed to use this type of
setup. You can download and setup Kwiki all in your home directory.

=head1 AUTHOR

Brian Ingerson <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
