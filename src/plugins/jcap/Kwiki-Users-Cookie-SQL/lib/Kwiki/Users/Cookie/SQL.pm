package Kwiki::Users::Cookie::SQL;
use Kwiki::Users::Cookie -Base;

our $VERSION = "0.01";

const class_title => 'Kwiki users from Cookie SQL lookup';
const user_class => 'Kwiki::User::Cookie::SQL';

sub init {
	$self->hub->config->add_file('user_cookie_sql.yaml');
}


package Kwiki::User::Cookie::SQL;
use base qw[Kwiki::User::Cookie];

use DBI;

sub process_cookie {
	my ( $cookie_value ) = shift;
	my $dbh = DBI->connect($self->hub->config->users_sql_dsn,
												 $self->hub->config->users_sql_db_user,
												 $self->hub->config->users_sql_db_pass );
	my $sql = sprintf 
		"SELECT %s 
			 FROM %s 
			WHERE ( %s  = %s )  ",
		$self->hub->config->users_sql_return_value_column,
		$self->hub->config->users_sql_table,
		$self->hub->config->users_sql_where_cookie_column,
		$dbh->quote($cookie_value );
	
	if ( $self->hub->config->users_sql_where_extra ) {
		$sql .= $dbh->quote($self->hub->config->users_sql_where_extra);
	}
		
	if ( $self->hub->config->users_sql_order_by ) {
		$sql .= sprintf " ORDER BY %s ", 
						$dbh->quote( $self->hub->config->users_sql_order_by );
	}
	
	my $sth = $dbh->prepare($sql);

	if ( $sth->execute ) {
		$cookie_value = $sth->fetch->[0];
	} else {
		$cookie_value = '';
	}
	
	$sth->finish;
	$dbh->disconnect;
	
	return $cookie_value;
}

package Kwiki::Users::Cookie::SQL;    
__DATA__


__config/user_cookie_sql.yaml__
user_default_cookie_name: username 
user_default_name: AnonymousGnome
users_sql_dsn: dbi:mysql:kwiki 
users_sql_db_user: sql_user 
users_sql_db_pass: sql_pass 
users_sql_table: users 
users_sql_return_value_column: username
users_sql_where_cookie_column: sid
users_sql_where_extra: 
users_sql_order_by:
