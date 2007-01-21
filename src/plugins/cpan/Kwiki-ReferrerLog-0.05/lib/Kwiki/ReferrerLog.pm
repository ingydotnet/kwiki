package Kwiki::ReferrerLog;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';
use Storable qw(lock_store lock_retrieve);
use POSIX qw(strftime);
our $VERSION = '0.05';

our $DAY_SECONDS = 86400;

const class_id    => 'referrerlog';
const class_title => 'ReferrerLog Display';
const config_file => 'referrerlog.yaml';

const css_file             => 'referrerlog.css';
const referrerlog_template => 'referrerlog_content.html';

const log_file    => 'referrers.log';

sub init {
    super;
    $self->hub->add_post_process($self->class_id, 'log_referrer');
}

sub register {
    my $registry = shift;
    $registry->add(preload => 'referrerlog');

    $registry->add(action => 'show_referrerlog');
    $registry->add(toolbar => 'referrerlog_button',
                   template => 'referrerlog_button.html');
}

sub log_referrer {
    my $ref = $ENV{HTTP_REFERER};
    return unless $ref;

    my $excl_subd = $self->config->exclude_subdomains;
    my @test = ();
    grep {
        if ( $excl_subd ) { return if $ref =~ m!^http://[a-zA-Z]*\.*$_!; }
        else { return if $ref =~ m!^http://$_! ; }
    } @{$self->config->exclude_referrers} if ref $self->config->exclude_referrers;

    my $log = $self->load_log;
    $log->{$ref}->[0]++ ;      # referrer count
    $log->{$ref}->[1] = time;  # time
    $log->{$ref}->[2] = $self->pages->current->uri;  # where did it go?

    $self->delete_old_logs($log);
    $self->store_log($log);
}


sub show_referrerlog {
    my $reflength = $self->config->truncate_referrers;

    my $log = $self->load_log;
    my $refs = [];
    foreach (keys %$log) {
      push @$refs, {'visitcount' => $log->{$_}->[0], 'time'   => $log->{$_}->[1],
                    'uri'    => $log->{$_}->[2],     'refuri' => $_};
    }

    # puts the latest referrers on the top of the list
    @$refs = sort { $a->{'time'} <=> $b->{'time'} } @$refs;

    $self->render_screen(
        screen_title => $self->class_title,
        'log' => $refs,
    );
}


sub file_path {
    join '/', $self->plugin_directory, $self->log_file;
}


sub load_log {
    lock_retrieve($self->file_path) if -f $self->file_path;
}


sub store_log {
    lock_store shift, $self->file_path;
}


sub delete_old_logs {
    my $log = shift;

    if ( $self->config->keep_days > 0 ) {
      my $now = time;
      my @to_delete = ();
      foreach (keys %$log) {
          push @to_delete, $_ if ($now - $log->{$_}->[1]) > $self->config->keep_days * $DAY_SECONDS;
      }
      delete $log->{$_} for @to_delete
    }
}


sub date_fmt {
    strftime($self->config->date_format, localtime(shift))
}

1;
__DATA__
__config/referrerlog.yaml__
keep_days: 2
date_format: %d.%m.%Y %H:%M
exclude_referrers:
exclude_subdomains: 1
truncate_referrers: 40
__template/tt2/referrerlog_button.html__
<a href="[% script_name %]?action=show_referrerlog" title="Log of Referrers">
[% INCLUDE referrerlog_button_icon.html %]
</a>
__template/tt2/referrerlog_button_icon.html__
Referrers
__template/tt2/referrerlog_content.html__
This is a list of sites, that refer to this website. The 'count' column denotes
the number of visitors, that have arrived from the corresponding site until now.
<table id="reflog_table">
  <tr>
    <th class="reflog_head">Viewed Page</th>
    <th class="reflog_head">Referring URL</th>
    <th class="reflog_head">Last Request</th>
    <th class="reflog_head">Count</th>
  </tr>
[% FOR  ref = log -%]
  <tr>
    <td class="[% 'odd_' IF loop.count % 2 == 0 %]reflog_line">
      <a href="[% script_name %]?[% ref.uri %]" title="link to [% ref.refuri %]">[% ref.uri %]</a></td>
    <td class="[% 'odd_' IF loop.count % 2 == 0 %]reflog_line">
      <a href="[% ref.refuri %]" title="external link to [% ref.refuri %]">
      [% IF ref.refuri.length > self.config.truncate_referrers %]
        [% FILTER truncate(self.config.truncate_referrers) %] [% ref.refuri %] [% END %]
      [% ELSE %]
        [% ref.refuri %]
      [% END %]
      </a>
    </td>
    <td class="[% 'odd_' IF loop.count % 2 == 0 %]reflog_line">[% self.date_fmt(ref.time) %]</td>
    <td class="[% 'odd_' IF loop.count % 2 == 0 %]reflog_line">[% ref.visitcount %]</td>
  </tr>
[% END %]
</table>
__css/referrerlog.css__
#reflog_table { width:100%; }
.reflog_head  {}
.reflog_line      { font-size:8px; font-family:fixed; }
.odd_reflog_line  { font-size:8px; font-family:fixed; background-color:#fffff7; }
