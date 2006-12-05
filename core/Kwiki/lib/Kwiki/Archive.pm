package Kwiki::Archive;
use Kwiki::Plugin -Base;

const class_id => 'archive';
const class_title => 'Page Archive';
const show_revisions => 1;

sub register {
    my $registry = shift;
    $registry->add(hook => 'page:store', post => 'commit_hook');
}

sub init {
    if ($self->empty) {
        $self->generate;
        $self->commit_all;
    };
}

sub empty {
    my $dir = io($self->plugin_directory);
    $dir->exists and $dir->empty;
}

sub generate {
    my $dir = $self->plugin_directory;
    umask 0000;
    chmod 0777, $dir;
}

sub commit_hook {
    my $hook = pop;
    return unless $hook->returned_true;
    my $page = $self;
    $self = $page->hub->archive;
    $self->commit($page);
}

sub commit_all {
    for my $page ($self->pages->all) {
        $self->commit($page);
    }
}

sub page_properties {
    my $page = shift;
    my $properties = $page->metadata->to_hash;
    $properties->{edit_by} ||= '';
    $properties->{edit_time} ||= scalar(gmtime);
    $properties->{edit_unixtime} ||= scalar(time);
    return $properties;
}

sub revision_number {
    $self->history(shift)->[0]->{revision_id} || 0;    
}

sub revision_numbers {
    my $page = shift;
    [map $_->{revision_id}, @{$self->history($page)}];
}

__DATA__

=head1 NAME 

Kwiki::Archive - Kwiki Page Archive Plugin Base Class

=head1 SYNOPSIS

    package Kwiki::Archive::YourPlugin;
    use Kwiki::Archive -Base;

    sub show_revisions {...}
    sub commit {...}
    sub history {...}
    sub fetch {...}

=head1 DESCRIPTION

Kwiki archive plugins inherit from this base class.

A Kwiki archive plugin should implement the following methods:

=head2 show_revisions

This method is a callback used to query how many past revisions exist for a
document.  This is used by L<Kwiki::Revisions> to decide whether to display
a B<Revisions> link in a page's toolbar.  You should return 0 if there is
only one revision, 1 if there is one older revision, and so on.  This method
takes no arguments; you should find the current page using
$self->hub->pages->current. 

=head2 commit(page)

Add a new revision of a page.  The page (an IO::All object) is given as an
argument.  Your commit method should do a checkin, SQL row insert, or
something of that nature.

=head2 history(page)

Get a list of revision numbers, for a page.  The page (an IO::All object)
is given as an argument.  Return an array reference, containing numeric
revision numbers.

=head2 fetch(page, revision)

Get a copy of a page revision.  The page (an IO::All object) and the
revision number are given as arguments.  Return an IO handle object.

=head1 SEE ALSO

    Kwiki, Kwiki::Archive::Simple

=head1 AUTHOR

Brian Ingerson <INGY@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2004. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
