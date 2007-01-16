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

=head1 NAME 

Kwiki::Users::Cookie::SQL - automatically set Kwiki user name from a SQL
lookup based on a cookie value

=head1 SYNOPSIS

 $ cd /path/to/kwiki
 $ echo "users_class: Kwiki::Users::Cookie::SQL" >> config.yaml
 $ echo "users_cookie_name: user_cookie"    >> config.yaml
 $ echo "users_sql_dsn: dbi:mysql:kwiki" >> config.yaml 
 $ echo "users_sql_db_user: sql_user" >> config.yaml 
 $ echo "users_sql_db_pass: sql_pass" >> config.yaml 
 $ echo "users_sql_table: users" >> config.yaml 
 $ echo "users_sql_return_value_column: username" >> config.yaml
 $ echo "users_sql_where_cookie_column: sid" >> config.yaml
 $ echo "users_sql_where_extra: AND active = 1" >> config.yaml
 $ echo "users_sql_order_by: created_date desc" >> config.yaml

This would query the data source "dbi:mysql:kwiki":

     SELECT username 
       FROM users 
      WHERE ( sid = $cookies{$user_cookie_name} ) 
            AND active = 1 
   ORDER BY created_date desc;
 
Optionally, to display the user name:

 $ cd /path/to/kwiki
 $ kwiki -add Kwiki::UserName::Cookie
 $ echo "login_url: /login.html"    >> config.yaml

=head1 DESCRIPTION

This module will set the user's name from a SQL lookup performed using a
cookie value as query condition.

You might also want to use L<Kwiki::UserName::Cookie>.

=head1 AUTHORS

John Cappiello <jcap@cpan.org>

=head1 SEE ALSO

L<Kwiki>, l<Kwiki::Users::Cookie>, L<Kwiki::UserName::Cookie>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by John Cappiello

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

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
