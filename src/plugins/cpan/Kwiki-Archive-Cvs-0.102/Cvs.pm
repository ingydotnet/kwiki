package Kwiki::Archive::Cvs;

use strict;
use warnings;
use Kwiki::Archive '-Base';

our $VERSION = '0.1';

# It will try to add files to CVS every time they're changed; this
#  fails silently when they're already present.

# Misinteractions:
#  Kwiki::Revisions tries to show the previous revision for single-revision pages.
#  Kwiki::Pages trips up on the CVS directory; change the line to
#    map {chomp; $_} `ls -1t $path | fgrep -xv CVS`;
#   for a quick-and-dirty fix.


# These should be read once and cached.

sub cvsSetting {
    my $page = shift;
    my $setting = shift;

    my $l = io($page->database_directory."/CVS/$setting")->getline or die "Unable to read CVS/$setting: $!";

    local ($/);
    $/ = "\n";
    chomp($l);
    $l;
}

sub cvsRoot {
    my $page = shift;
    $self->cvsSetting($page, 'Root');
}

sub cvsRepository {
    my $page = shift;
    $self->cvsSetting($page, 'Repository');
}

# Take responsibility for initialising this manually.
sub empty {
    0;
}

sub commit {
    my $page = shift;
    my $props = $self->page_properties($page);

    # Unconditionally add (this command will fail once the file is added)
    system('cvs', '-Q', '-d', $self->cvsRoot($page), 'add', $page->io);

    my $msg = join ',',
      $self->uri_escape($props->{edit_by}),
      $props->{edit_time},
      $props->{edit_unixtime};

    $self->cvs($page, 'commit', '-m', $msg, $page->io);
}

sub revision_numbers {
    my $page = shift;
    [map $_->{revision_id}, @{$self->history($page)}];
}

sub fetch_metadata {
    my $page = shift;
    my $rev = shift;

    my $rlog = io("cvs -Q -d ".$self->cvsRoot($page)." log -r$rev ".$page->io." |") or die $!;

    $rlog->utf8 if $self->use_utf8;
    $self->parse_metadata($rlog->all);
}

sub parse_metadata {
    my $log = shift;
    $log =~ /
        ^revision\s+(\S+).*?
        ^date:\s+(.+?);.*?\n
        (.*)
    /xms or die "Couldn't parse rlog:\n$log";

    my $revision_id = $1;
    my $msg = $3;
    chomp $msg;

    my ($edit_by, $edit_time, $edit_unixtime) = split ',', $msg;
    $edit_time ||= $2;
    $edit_unixtime ||= 0;
    $revision_id =~ s/^1\.//;

    return {
        revision_id => $revision_id,
        edit_by => $self->uri_unescape($edit_by),
        edit_time => $edit_time,
        edit_unixtime => $edit_unixtime,
    };
}

sub history {
    my $page = shift;

    my $rlog = io("cvs -Q -d ".$self->cvsRoot($page)." log ".$page->io." |") or die $!;

    $rlog->utf8 if $self->use_utf8;

    my $input = $rlog->all;
    $input =~ s/
        \n=+$
        .*\Z
    //msx;
    my @rlog = split /^-+\n/m, $input;
    shift(@rlog);

    return [
        map $self->parse_metadata($_), @rlog
    ];
}

sub fetch {
    my $page = shift;
    my $revision_id = shift;
    my $revision = "1.$revision_id";
    local($/, *CO);
    open CO, "cvs -Q -d ".$self->cvsRoot($page)." checkout -r$revision -p ".$self->cvsRepository($page)."/".$page->id." |"
      or die $!;
    binmode(CO, ':utf8') if $self->use_utf8;
    scalar <CO>;
}

sub shell {
    use Cwd;
    $! = undef;
    system(@_) == 0 
      or die "@_ failed:\n$?\nin " . Cwd::cwd();
}

sub cvs {
    my $page = shift;
    $self->shell('cvs', '-Q', '-d', $self->cvsRoot($page), @_);
}

1;
