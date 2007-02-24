package Kwiki::GoogleMaps;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-base';

our $VERSION = '0.01';

const class_title => 'Google Maps Embed';
const class_id    => 'gmaps';
const config_file => 'gmaps.yaml';

sub register {
    my $registry = shift;
    $registry->add(wafl => gmaps => 'Kwiki::GoogleMaps::Wafl');
}

package Kwiki::GoogleMaps::Wafl;
use Spoon::Formatter ();
use base 'Spoon::Formatter::WaflPhrase';

my $id = -1;

sub html {
    my $address = $self->arguments;
    my $key = $self->hub->config->google_maps_api_key
        or return "(No google_maps_api_key defined)";
    $id++;

    $address =~ s/"/\\"/g;

    return <<EOF;
<div id="map-$id" style="width: 500px; height: 300px"></div>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=$key" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
    if (GBrowserIsCompatible()) {
      var map = new GMap2(document.getElementById("map-$id"));
      var geocoder = new GClientGeocoder();
      var address = "$address";
      geocoder.getLatLng(address, function(point) {
          if (!point) {
              alert(address + " not found");
          } else {
              map.setCenter(point, 13);
              var marker = new GMarker(point);
              map.addOverlay(marker);
              marker.openInfoWindowHtml(address);
          }
      });
    }
    //]]>
    </script>
EOF
}

package Kwiki::GoogleMaps;

1;
__DATA__

__config/gmaps.yaml__
google_maps_api_key:
