package Kwiki::ForeignLinkGlyphs;
use strict;
use warnings;

use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';

our $VERSION = '0.02';

const class_id => 'foreignlinkglyphs';
const class_title => 'glyphs for foreign links';
const config_file => 'foreignlinkglyphs.yaml';

sub register {
    my $registry = shift;
    $registry->add(preload => 'foreignlinkglyphs');
}

field 'old_hyper';
field 'old_titlehyper';

sub init {
    super;
    my $formatter = $self->hub->load_class('formatter');
    $formatter->table->{hyper} = 'Kwiki::ForeignLinkGlyphs::Hyperlink';
    $formatter->table->{titlehyper} = 'Kwiki::ForeignLinkGlyphs::TitledHyperlink';
}

sub transform {
    my $link = shift;
    my $src = $self->config->foreignlinkglyph_image;
    my $target = $self->config->foreignlinkglyph_new_window =~
        /yes|1|true/i ? ' target="_new"' : '';
    $link =~ s{
      <a([^>]+)>  ([^<]+) </a>  $
      }{<a$1$target>$2</a><img src="$src" alt="" border="0" />}x;
    return $link;
}

package Kwiki::ForeignLinkGlyphs::Hyperlink;
use base 'Kwiki::Formatter::HyperLink';

sub html {
    $self->hub->foreignlinkglyphs->transform( $self->SUPER::html(@_) );
}      

package Kwiki::ForeignLinkGlyphs::TitledHyperlink;
use base 'Kwiki::Formatter::TitledHyperLink';

sub html {
    $self->hub->foreignlinkglyphs->transform( $self->SUPER::html(@_) );
}      

package Kwiki::ForeignLinkGlyphs;
1;
__DATA__


__config/foreignlinkglyphs.yaml__
foreignlinkglyph_image: plugin/foreignlinkglyphs/foreignlinkglyph.png
foreignlinkglyph_new_window: no

__plugin/foreignlinkglyphs/.htaccess__
Allow from all

__plugin/foreignlinkglyphs/foreignlinkglyph.png__
iVBORw0KGgoAAAANSUhEUgAAAAYAAAAGAQMAAAGtBU2dAAAABlBMVEX/AAD///9BHTQRAAAAB3RJ
TUUH0gsbCAwXQp9teAAAABV0RVh0U29mdHdhcmUAWFBhaW50IDIuNi4yxFiwnAAAABpJREFUeJxj
aGBgYDjAAAINYJjA8IChg2EOADOMBSV4TVvKAAAAAElFTkSuQmCC
