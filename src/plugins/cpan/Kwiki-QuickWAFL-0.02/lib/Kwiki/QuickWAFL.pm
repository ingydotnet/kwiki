package Kwiki::QuickWAFL;

use warnings;
use strict;
use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';
our $VERSION = '0.02';

const class_title => 'QuickWAFL';
const class_id => 'quickwafl';

sub register {
	my $registry = shift;
	if( $self->config->can('blocks') ) {
		foreach( @{$self->config->blocks}) {
			$registry->add( wafl => $_ => 'Kwiki::QuickWAFL::Block' );
		}
	}
}

package Kwiki::QuickWAFL::Block;
use base qw( Spoon::Formatter::WaflBlock );
sub contains_phrases {
	my $id = $self->formatter_id;
	[ grep {$_ ne $id} @{$self->hub->formatter->all_phrases} ];
}
sub contains_blocks {
    $self->hub->formatter->all_blocks;
}

package Kwiki::QuickWAFL;
1; # End of Kwiki::QuickWAFL
__DATA__
__config/quick_walf.yaml__
# DO NOT EDIT THIS FILE
# Put overrides in the top level config.yaml
# See: http://www.kwiki.org/?ChangingConfigDotYaml
#
# DO NOT EDIT THIS FILE
# Put overrides in the top level config.yaml
# See: http://www.kwiki.org/?ChangingConfigDotYaml
#
blocks:
- example
- workaround
