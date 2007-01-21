package Kwiki::Pages::Perldoc;
use Kwiki::Pages -Base;
use Kwiki::Installer -base;
our $VERSION = '0.12';

const page_class => 'Kwiki::Page::Perldoc';

sub init {
    $self->SUPER::init(@_);
    $self->hub->config->add_file('pages.yaml');
}

sub all {
    map {
        $self->new_page($_)
    } grep {
        s/\.pod$//;
    }
    map {
        $_->filename;
    } io($self->current->database_directory)->all_files;
}

sub all_ids_newest_first {
    my $path = $self->current->database_directory;
    grep {
        chomp; 
        s/\.pod$//;
    } `ls -1t $path`;
}   


package Kwiki::Page::Perldoc;
use base 'Kwiki::Page';
use Kwiki ':char_classes';

sub file_path {
    join '/', $self->database_directory, $self->id . '.pod';
}

package Kwiki::Pages::Perldoc;
__DATA__

__config/pages.yaml__
database_directory: /usr/share/perl/5.8.4/pod
formatter_class: Kwiki::Formatter::Pod
