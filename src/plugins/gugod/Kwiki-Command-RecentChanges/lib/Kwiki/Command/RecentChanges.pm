package Kwiki::Command::RecentChanges;
use Kwiki::Plugin -Base;
our $VERSION = '0.01';

const class_id => 'command_recent_changes';
const class_title => '';

sub register {
    my $reg = shift;
    $reg->add(command => 'recent_changes',
              description => 'Show Kwiki recent changes from command-line'
             );
}

sub handle_recent_changes {
    my @pages = sort { 
        $b->modified_time <=> $a->modified_time 
    } $self->pages->all;
    for my $i (0..$#pages) {
        printf("%2d: %-20s %s\n",$i+1,$pages[$i]->id,$pages[$i]->edit_time)
            if defined $pages[$i];
        unless( ($i+1) % 10) {
            my $answer = io->prompt("Continue? [Y/n] ");
            last if $answer =~ /^no?/i;
        }
    }
}
