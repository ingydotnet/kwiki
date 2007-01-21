package Kwiki::PageTemperature;
use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';

const class_id             => 'page_temperature';
const time_period_minutes  => 60 * 24 * 60;
const color_divisor        => (60 * 24 * 60) / 255;

our $VERSION = '0.01';

sub register {
    my $registry = shift;
    $registry->add(status => 'page_temperature',
                   template => 'page_temperature.html',
                   show_for => 'display',
               );
}

sub page_age {
    my $page = $self->hub->pages->current;
    $page->age_in_minutes < $self->time_period_minutes
      ? $page->age_in_minutes
      : $self->time_period_minutes;
}

sub red {
    int(($self->time_period_minutes - $self->page_age)/$self->color_divisor);
}

sub blue {
    int($self->page_age/$self->color_divisor);
}

__DATA__

__template/tt2/page_temperature.html__
<!-- BEGIN page_temperature -->
<div id="page_temperature" style="height: .25em;background-color: rgb([%- hub.page_temperature.red %], 0, [%- hub.page_temperature.blue %]);">&nbsp;</div>
<!-- END page_temperature -->
