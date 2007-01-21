package Kwiki::DB::DBI;
use Kwiki::DB -Base;
use base 'DBI';

const class_id    => 'dbi';
const class_title => 'Kwiki DBI';

our $VERSION = '0.02';

sub connect {
     my ($dsn, $user, $pass, $attr, $old_driver) =  @_;
     $attr->{RootClass} = 'DBI';
     super($dsn, $user, $pass, $attr, $old_driver);
}
