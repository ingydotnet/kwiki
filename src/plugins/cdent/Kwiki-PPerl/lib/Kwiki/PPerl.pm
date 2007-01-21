package Kwiki::PPerl;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
use Config;
use File::Spec;

our $VERSION = '0.01';

const class_id => 'pperl';
const class_title => 'PPerl';

sub set_file_content {
    # Can't use super here because of mixin squashes things down into one
    # namespace. May need to make mixins more flexible.
    my $content = Spoon::Installer::set_file_content($self, @_);
    my $path = shift;
    $content = $self->fix_perl($content);
    return $content;
}

sub fix_perl {
    my $content = shift;
    my $perl_dir = $Config{perlpath};
    $perl_dir =~ s{/[^/]*$}{};
    my $pperl = File::Spec->catfile($perl_dir, 'pperl');
    $content =~ s/\{PPERL_PATH\}/#!$pperl/;
    return $content;
}


__DATA__
__index.cgi__
{PPERL_PATH}
use lib 'lib';
use Kwiki;
Kwiki->new->debug->process('config*.*', -plugins => 'plugins');
CGI->initialize_globals;
