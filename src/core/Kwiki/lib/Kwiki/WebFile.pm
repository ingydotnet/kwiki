package Kwiki::WebFile;
use Kwiki::Base -Base;
use Spoon::Base 'conf';

our @EXPORT = qw(conf);

field path => [];
field files => [];
const default_path_method => 'default_path';

sub init {
    my $method = $self->default_path_method;
    $self->add_path(@{$self->$method});
}

sub add_file {
    my $file = shift
      or return;
    my $file_path = '';
    for (@{$self->path}) {
        $file_path = "$_/$file", last
          if -f "$_/$file";
    }
    my $files = $self->files;
    @$files = grep { not /\/$file$/ } @$files;
    $self->_append_file($files, $file_path);
}

sub _append_file {
    my ($files, $file_path) = @_;
    push @$files, $file_path;
}

sub files_which_exist {
    grep {io->file($_)->exists} @{$self->files};
}

sub add_path {
    unshift @{$self->path}, @_;
}

sub clear_files {
    $self->files([]);
}
