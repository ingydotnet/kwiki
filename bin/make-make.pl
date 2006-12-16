#!/usr/bin/env perl
use strict;
use warnings;

my ($type, $stars) = @ARGV;
$stars ||= 1;

my @libs = map {
    s!^.*/lib/!! or die $_;
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
my $sections = lc($type) . ": \$(${type}_PATHS) \$(${type}_MODULES)\n\n";

for my $lib (@libs) {
    my @parts = split('/', $lib);
    my $level = @parts;
    my $path = $lib;
    if ($path =~ s!/\w+.pm$!!) {
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
        $sections .= make_section($level, $type, $stars);
    }
}

my $paths = join '', map {
    "\t$_ \\\n";
} sort keys %paths;
$paths ||= '';

if ($paths) {
    $paths = "${type}_PATHS = \\\n$paths\n";
}

if ($all) {
    $all = "${type}_MODULES = $all\n\n";
}

print "$paths$level1$level2$level3$level4$level5$all$sections";

sub make_section {
    my ($level, $TYPE, $stars) = @_;
    my $type = lc($TYPE);
    my $star = join '/', (('*') x $stars);
    my $dots = join '/', (('..') x $level);
    if ($level == 1) {
        return <<"...";
\$(${TYPE}_LEVEL_$level):
	ln -s $dots/$type/$star/lib/\$\@ \$\@

...
    }
    my $dots2 = join '/', (('..') x ($level - 1));
    my $dummy = join '/', (('dummy') x ($level - 1));
    return <<"...";
\$(${TYPE}_LEVEL_$level):
	\@( \\
	cd $dummy; \\
	lib=$dots/$type/$star/lib/\$\@; \\
	echo "ln -s \$\$lib \$\@;"; \\
	ln -fs \$\$lib $dots2/\$\@; \\
	)

...
}

