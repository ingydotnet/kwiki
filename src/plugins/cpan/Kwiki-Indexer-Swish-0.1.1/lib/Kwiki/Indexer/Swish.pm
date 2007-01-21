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
