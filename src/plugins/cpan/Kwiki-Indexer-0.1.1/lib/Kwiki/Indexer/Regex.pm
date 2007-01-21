package Kwiki::Indexer::Regex;
use strict;
use warnings;
use Kwiki::Indexer qw(-Base);
use mixin 'Kwiki::Installer';

our $VERSION = '0.1.1';

const class_id => 'indexer_regex';
const class_title => 'Perl regex Index Engine';

sub register { }

sub init { }

sub perform_search { 
    my $arg = shift;
    [grep {$_->content =~ m{$arg}i and $_->active} $self->hub->pages->all ];
}

1;
