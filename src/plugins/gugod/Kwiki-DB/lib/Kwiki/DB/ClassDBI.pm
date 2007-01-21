package Kwiki::DB::ClassDBI;
use Kwiki::DB -Base;

our $VERSION = '0.03';

const class_id    => 'cdbi';
const class_title => 'Kwiki ClassDBI';

field '_base';
field entities => {};

sub base {
    return $self->_base unless @_;
    my $class = shift;
    eval "require $class";
    die $@ if $@;
    $self->_base($class);
}

sub entity {
    my ($entity,$class) = @_;
    my $object = Kwiki::DB::ClassDBI->new(base => $class);
    $object->init;
    $self->entities->{$entity} = $object;
}

sub AUTOLOAD {
    my ($p,$func) = $Kwiki::DB::ClassDBI::AUTOLOAD =~ m/(.*)::(.*?)$/;
    for(keys %{$self->entities}) {
        if ($_ eq $func) {
            return $self->entities->{$_};
        }
    }
    if(my $base = $self->base) {
        $base->$func(@_);
    }
}
