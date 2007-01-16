package Kwiki::Archive::Simple;
use Kwiki::Archive -Base;

sub revs_dir {
    io->catfile($self->plugin_directory,'revs');
}

sub commit {
    my $page = shift;
    my $page_id = $page->id;
    my $lock = io("plugin/archive/$page_id/lock")->assert->lock->open('>');
    my $latest_path = "plugin/archive/$page_id/latest";

    my $latest_number = $self->latest_revision_number($page_id) + 1;

    io($latest_path)->assert->println($latest_number);

    # archive/revs/PageName/$rev_number
    # archive/revsprop/PageName/$rev_number
    
    my $content = $page->content;
    io("plugin/archive/$page_id/$latest_number/page")->assert->print($content);
    $lock->close;
}

sub system_call {
    my $command = shift;
    system($command) == 0 or die;
}

sub show_revisions {
    $self->latest_revision_number > 1;
}

sub latest_revision_number {
    my $page_id = shift || $self->hub->pages->current->id;

    my $latest = io("plugin/archive/$page_id/latest");
    return $latest->exists
    ? $latest->chomp->getline
    : 0;
}

sub history {
    [ map +{revision_id => $_}, reverse 1..$self->latest_revision_number ]
}

sub fetch {
    my $page = shift;
    my $revision_id = shift;
    my $page_id = $page->id;
    my $latest_path = "plugin/archive/$page_id/$revision_id/page";
    io($latest_path)->utf8->all;
}

sub fetch_metadata {
    my $page = shift;
    my $revision_id = shift;
    return +{ revision_id => $revision_id };
}

__DATA__
    # cp $meta plugin/archive/PageName/$rev_number/meta
    # cp $meta plugin/archive/PageName/latest ->
    # cp $meta plugin/archive/PageName/$some_rev_number/previous ->
    # kwiki -archive_simple_rehash
    # kwiki -archive_simple_import_from_rcs
    # kwiki -archive_simple_prune
    # kwiki -archive_simple_compress

