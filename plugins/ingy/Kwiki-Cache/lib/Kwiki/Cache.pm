package Kwiki::Cache;
use Kwiki::Plugin -Base;
use Digest::MD5;
our $VERSION = '0.11';

const class_id => 'cache';
const class_title => 'Generic Cache';

sub process {
    my $closure = shift;
    my @cache_strings = grep not(ref), @_;
    my ($options) = grep ref, @_;
    $options ||= {};
    my $timeout = $options->{-timeout} || 0;
    my $cache_name = Digest::MD5::md5_hex(join '!@#$', @cache_strings);
    my $path = $self->plugin_directory;
    my $cache = io->catfile($path, $cache_name);

    if ($cache->exists) {
        if (not($timeout) or (time - $cache->mtime) < $timeout) {
            my $value = $cache->all;
            return $value;
        }
    }

    my $lock = io->catfile($path, "$cache_name.lock")->lock;
    $lock->mode('>>')->open;
    $cache->touch;
    my $value = eval { &$closure };
    if ($@) {
        $lock->close;
        $lock->unlink;
        die $@;
    }
    if (defined $value) {
        $cache->assert->print($value);
        $cache->close;
    }
    elsif ($cache->exists) {
        $value = $cache->all;
        $cache->touch;
    }
    $lock->close;

    $lock->unlink;
    return $value;
}

__DATA__

=head1 NAME 

Kwiki::Cache - Kwiki Cache Plugin

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Brian Ingerson <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2004. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
