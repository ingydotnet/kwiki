package Kwiki::GDGraphGenerator;
use strict;
use warnings;

use Kwiki::Plugin '-Base';
use Kwiki::Installer '-base';

our $VERSION = "0.04";

const class_title => 'Kwiki graphs';
const class_id    => 'graphgenerator';

sub register {
    my $registry = shift;
    $registry->add( wafl => graph => 'Kwiki::GDGraphGenerator::Wafl' );
}

package Kwiki::GDGraphGenerator::Wafl;
use Spiffy '-Base';
use base 'Spoon::Formatter::WaflBlock';

field 'config';

sub to_html {

    # parse the config, make sure options are there
    require YAML;
    $self->config( eval { YAML::Load( $self->block_text ) } );
    return $self->error("make sure your YAML is correct") if $@;
    return $self->error("graph config isn't a hash")
        unless $self->config && ref $self->config eq 'HASH';
    foreach (qw( id data type )) {
        return $self->error("graph config must specify '$_'")
            unless exists $self->config->{$_};
    }

    # check to see if the graph exists -- if not, create it
    my $error = $self->generate_image
        unless -e $self->checksum_path
        && io( $self->checksum_path )->assert->scalar eq $self->checksum;
    return $self->error($error) if $error;

    # return a simple link
    $self->hub->template->process( 'graphgenerator_inline.html',
        src => $self->image_path );
}

sub error {
    $self->hub->template->process( 'graphgenerator_error.html',
        msg => "Couldn't create graph: " . shift );
}

sub checksum {
    require Data::Dumper;
    require Digest::MD5;
    my $d = new Data::Dumper( [ $self->config ] );
    Digest::MD5::md5_hex( $d->Sortkeys(1)->Indent(0)->Dump );
}

sub image_path {
    $self->hub->cgi->button;
    $self->hub->graphgenerator->plugin_directory . '/'
        . $self->hub->pages->current->id . '.'
        . $self->config->{id} . '.png';
}

sub checksum_path {
    $self->image_path . '.config.md5';
}

sub generate_image {

    # load config, put things in variables and strip out
    # options we're not going to give to set()
    # (NOTE: width and height are read-only)
    my %config = %{ $self->config };
    my ( $type, $width, $height, $data )
        = @config{qw( type width height data )};
    delete @config{qw( type width height data id )};
    $width  ||= 300;
    $height ||= 300;

    # check for keys we don't allow
    foreach my $key (qw( logo )) {
        return "specifying $key is not permitted" if $config{$key};
    }

    # create a new graph object
    require GD::Graph;
    my $class = "GD::Graph::$type";
    eval "require $class;";
    return "couldn't create new $class" if $@;
    my $graph = $class->new( $width, $height );

    # set the options and plot the data
    $graph->set(%config)
        or return "couldn't use config: " . $graph->error;
    my $gd = $graph->plot($data)
        or return "couldn't plot graph: " . $graph->error;

    # save to the files
    io( $self->image_path ) < $gd->png;
    io( $self->checksum_path ) < $self->checksum;

    # undef means no error
    return;
}

package Kwiki::GDGraphGenerator;
1;

__DATA__


__plugin/graphgenerator/.htaccess__
Allow from all

__template/tt2/graphgenerator_error.html__
<!-- BEGIN graphgenerator_error.html -->
<p><span class="error">[% msg %]</span></p>
<!-- END graphgenerator_error.html -->

__template/tt2/graphgenerator_inline.html__
<!-- BEGIN graphgenerator_inline.html -->
<img src="[% src %]" alt="(graph)" />
<!-- END graphgenerator_inline.html -->
