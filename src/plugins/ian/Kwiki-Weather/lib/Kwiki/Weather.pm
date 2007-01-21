package Kwiki::Weather;
use strict;
use warnings;

use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

our $VERSION = '0.05';

const class_title => 'Weather Report';
const class_id    => 'weather';
const cgi_class   => 'Kwiki::Weather::CGI';
field 'geo_weather';

sub register {
    my $registry = shift;
    $registry->add( action => 'weather' );
    $registry->add(
        toolbar  => 'weather',
        template => 'weather_button.html'
    );
    $registry->add( wafl => weather => 'Kwiki::Weather::Wafl' );
    $registry->add( prerequisite => 'zipcode' );
}

sub weather {
    my $zipcode = $self->cgi->zipcode;
    return $self->render_screen( content_pane => 'weather_error.html' )
        unless $zipcode =~ /^\d{5}$/;
    require Geo::Weather;
    my $weather = Geo::Weather->new;
    $weather->get_weather($zipcode);
    $self->geo_weather($weather);
    $self->render_screen;
}

package Kwiki::Weather::Wafl;
use base 'Spoon::Formatter::WaflPhrase';

sub to_html {
    my $zipcode = $self->arguments;
    return $self->wafl_error
        unless $zipcode =~ /^\d{5}$/;
    require Geo::Weather;
    my $weather = Geo::Weather->new;
    $weather->get_weather($zipcode);
    $self->hub->template->process( 'weather_report.html', weather => $weather,
    );
}

package Kwiki::Weather::CGI;
use Kwiki::CGI -base;
cgi 'zipcode';

package Kwiki::Weather;

__DATA__


__template/tt2/weather_content.html__
[% self.geo_weather.report %]
<hr/>
[% self.geo_weather.report_forecast %]
__template/tt2/weather_error.html__
[% screen_title = 'Weather Report' %]
<p><span class="error">Please specify a zipcode in your Preferences.</span></p>
__template/tt2/weather_report.html__
[% weather.report %]
<hr/>
[% weather.report_forecast %]
__template/tt2/weather_button.html__
<a href="[% script_name %]?action=weather&zipcode=[% hub.users.current.preferences.zipcode.value %]" title="Local Weather Report">
[% INCLUDE weather_button_icon.html %]
</a>
__template/tt2/weather_button_icon.html__
Weather
