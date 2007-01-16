package Kwiki::Htaccess;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const class_id => 'htaccess';
const class_title => 'Apache htaccess Files';

__DATA__

=head1 NAME

Kwiki::Htaccess - Kwiki Apache htaccess Plugin

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Brian Ingerson <INGY@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2004. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
__.htaccess__
<Files config.yaml>
    Deny from all
</Files>
__config/.htaccess__
Deny from all
__plugin/.htaccess__
Deny from all
__template/.htaccess__
Deny from all
__theme/.htaccess__
Deny from all
__theme/basic/css/.htaccess__
Allow from all
