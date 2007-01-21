package Kwiki::Podcast;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
use XML::RSS;
use URI;
our $VERSION = '0.01';

const class_id => 'podcast';
const class_title => 'Podcast';
const config_file => 'podcast.yaml';

sub register {
    my $registry = shift;
    $registry->add(action => 'podcast');
    $registry->add(toolbar => 'podcast_button', 
                   template => 'podcast_button.html',
                  );
}

sub podcast {
    my @pods;
    for($self->hub->pages->all){
	if($_->content =~ m/(https?:.+?\.mp3)/i) {
	    push @pods, { uri => $1 , page => $_ };
	}
    }
    $self->hub->headers->content_type('text/xml');
    return $self->mkrss($self->hub->config->podcast_title,
			$self->hub->config->podcast_publisher,
			$self->hub->config->podcast_description,
			@pods);
}

sub mkrss {
    my ($title,$creator,$description,@pods) = @_;
    my $rss = XML::RSS->new( version => '2.0', encoding=> 'utf-8' );

    $rss->channel(title => $title,
		  publisher => $creator,
		  description => $description );

    for (@pods) {
	my $uri = URI->new($_->{uri});
	my ($sec,$min,$hour,$mday,$mon,$year,,,) = localtime($_->{page}->io->ctime);
	$rss->add_item( title => $_->{page}->title,
			link  => $uri,
			enclosure => { url => $uri, type => 'audio/mpeg' },
			description => '<![CDATA[' . $_->{page}->content . ']]>',
			category => "Podcast",
			pubDate => ($year+1900)."-$mon-$mday"."T"."$hour:$min:$sec",
			author => $_->{page}->metadata->edit_by
		      );
    }
    return $rss->as_string;
}

__DATA__


__config/podcast.yaml__
podcast_title: Kwiki Podcast
podcast_publisher: Kwiki Hacker
podcast_description: Podcast in a Kwiki way
__template/tt2/podcast_button.html__
<a href="[% script_name %]?action=podcast">
[% INCLUDE podcast_button_icon.html %]
</a>
__template/tt2/podcast_button_icon.html__
Podcast
