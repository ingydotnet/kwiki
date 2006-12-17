package Kwiki::Indexer::Swish;
use strict;
use warnings;
use Kwiki::Indexer qw(-Base);
use mixin 'Kwiki::Installer';
use SWISH::API;

our $VERSION = '0.1.1';

const class_id => 'indexer_swish';
const class_title => 'Swish Indexer';

sub index {
    my $cmd = sprintf("swish-e -v0 -i %s -f %s/index.swish-e", 
		      $self->hub->config->database_directory,
		      $self->plugin_directory);
    $self->shell($cmd);
}

sub perform_search {
    my $arg = shift;
    my $swish = SWISH::API->new($self->plugin_directory . "/index.swish-e");
    my $results = $swish->Query($arg);
    my @results;

    while (my $result = $results->NextResult) {
	$result->Property('swishdocpath') =~ /(\w+)$/;
	my $page = $self->hub->pages->new_page($1);
	push(@results, $page);
    }
    [@results];
}

sub shell {
    my ($command) = @_;
    use Cwd;
    $! = undef;
    system($command) == 0
	or die "$command failed:\n$?\nin " . Cwd::cwd();
}

1;
__DATA__

=head1 NAME

Kwiki::Indexer::Swish - Kwiki Swish Indexed Search Plugin

=head1 SYNOPSIS

kwiki -add Kwiki::Indexer::Swish

=head1 DESCRIPTION

A Kwiki indexer plugin  that uses the swish-e indexing system.

This plugin requires the SWISH::API module that ships with swish-e to be
installed to function.

=head1 AUTHOR

Russell Heilling <chewtoy@s8n.net>

=head1 COPYRIGHT

Copyright (c) 2004. Russell Heilling. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
