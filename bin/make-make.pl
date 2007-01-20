#!/usr/bin/env perl
use strict;
use warnings;

my ($output_file, $type, $star_level) = @ARGV;
$star_level ||= 1;

# ./Kwiki/src/doc/Kwiki/Formatter.pod

my $pathlet = ($output_file eq 'modules.mk') ? 'lib' : 'src/doc';
my $file_type = ($output_file eq 'modules.mk') ? 'MODULES' : 'DOCS';

my @libs = map {
    s!^.*/$pathlet/!! or die $_;
    chomp;
    $_;
} (<STDIN>);

my %paths;
our $level1 = '';
our $level2 = '';
our $level3 = '';
our $level4 = '';
our $level5 = '';
my $all = '';
my $sections = lc($type) . ": \$(${type}_PATHS) \$(${type}_$file_type)\n\n";

for my $lib (@libs) {
    my @parts = split('/', $lib);
    my $level = @parts;
    my $path = $lib;
    if ($path =~ s!/\w+.(pm|pod)$!!) {
        $paths{$path} = 1;
    }
    no strict 'refs';
    ${"level$level"} .= "\t$lib \\\n";
}

for my $level (1..5) {
    no strict 'refs';
    if (${"level$level"}) {
        ${"level$level"} =
            "${type}_LEVEL_$level = \\\n" .
            ${"level$level"} .
            "\n";
        $all .= "\$(${type}_LEVEL_$level) ";
        $sections .= make_section($level, $type, $star_level);
    }
}

my $paths = '';
if ($output_file eq 'modules.mk') {
    $paths = join '', map {
        "\t$_ \\\n";
    } sort keys %paths;
    $paths ||= '';
}

if ($paths) {
    $paths = "${type}_PATHS = \\\n$paths\n";
}

if ($all) {
    $all = "${type}_$file_type = $all\n\n";
}

open OUT, "> $output_file" or die "Can't open $output_file for output: $!";
print OUT "$paths$level1$level2$level3$level4$level5$all$sections";
close OUT;

sub make_section {
    my ($level, $TYPE, $star_level) = @_;
    my $dot_level = $level;
    $dot_level++ if $output_file eq 'docs.mk';
    my $type = lc($TYPE);
    my $stars = join '/', (('*') x $star_level);
    my $dots = join '/', (('..') x $dot_level);
    if ($level == 1) {
        return ($output_file eq 'modules.mk') ? <<"..." : <<"...";
\$(${TYPE}_LEVEL_$level):
	ln -fs $dots/src/$type/$stars/$pathlet/\$\@ \$\@
...
\$(${TYPE}_LEVEL_$level):
	link=`perl -e '\$\$_=shift;s!\\.pod\$\$!!;print' \$\@`; \\\
	ln -fs $dots/src/$type/$stars/$pathlet/\$\@ \$\$link;
...
    }
    my $dots2 = join '/', (('..') x ($level - 1));
    my $dummy = join '/', (('dummy') x ($level - 1));
    return ($output_file eq 'modules.mk') ? <<"..." : <<"...";
\$(${TYPE}_LEVEL_$level):
	cd $dummy; \\
	lib=$dots/src/$type/$stars/$pathlet/\$\@; \\
	ln -fs \$\$lib $dots2/\$\@;
...
\$(${TYPE}_LEVEL_$level):
	lib=../../src/$type/$stars/$pathlet/\$\@; \\
        link=`perl -e '\$\$_=shift;s!/!-!g;s!\\.pod\$\$!!;print' \$\@`; \\
	ln -fs \$\$lib \$\$link;
...
}

