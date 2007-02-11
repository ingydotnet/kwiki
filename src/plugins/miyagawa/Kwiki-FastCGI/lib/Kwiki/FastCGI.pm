package Kwiki::FastCGI;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const class_id => 'fastcgi';

1;

=head1 NAME

Kwiki::FastCGI - FastCGI bootstrap file template for Kwiki

=head1 SYNOPSIS

  > echo Kwiki::FastCGI >> plugins
  > echo "script_name: index.fcgi" >> config.yaml
  > kwiki -update

  # httpd.conf or .htaccess
  AddHandler fastcgi-script .fcgi

=head1 DESCRIPTION

Kwiki::FastCGI installs C<index.fcgi> to run your Kwiki as a FastCGI server.

=head1 AUTHOR

Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<CGI::Fast>, L<Kwiki>

=cut

__DATA__

__index.fcgi__
#!/usr/bin/perl
use lib 'lib';
use Kwiki::Boot;
use CGI::Fast;

while ( my $cgi = CGI::Fast->new ) {
    Kwiki::Boot->debug->class->new->kwiki->process;
}
