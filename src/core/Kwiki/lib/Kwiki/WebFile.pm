package Kwiki::WebFile;
use Kwiki::Base -Base;
use Spoon::Base 'conf';

our @EXPORT = qw(conf);

field files => [];

sub add_file {
    my $file = shift
      or return;
    my $file_path = $self->hub->paths->find_file($self->class_id, $file)
      or return;
    $self->_append_file($file_path);
}

sub _append_file {
    my $file = shift;
    my $files = $self->files;
    @$files = grep { not /\/$file$/ } @$files;
    push @$files, $file;
}

sub files_which_exist {
    grep {io->file($_)->exists} @{$self->files};
}

sub clear_files {
    $self->files([]);
}

# Deprecated/delegated
sub add_path { $self->hub->paths->add_path($self->class_id, @_) }
