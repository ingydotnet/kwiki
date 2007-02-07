package Socialtext::Mock;
BEGIN {
    for (qw(
        Socialtext::AppConfig
        Socialtext::Authz
        Socialtext::BrowserDetect
        Socialtext::Log
        Socialtext::Statistics
    )) {
        my $module = $_;
        $module =~ s!::!/!g;
        $module .= '.pm';
        $INC{$module} = $module;
    }
}

package Socialtext::AppConfig;

package Socialtext::Authz;

package Socialtext::BrowserDetect;
sub ie { 0 }

package Socialtext::Log;

package Socialtext::Statistics;
use base 'Exporter';
@EXPORT_OK = qw(stat_call);
sub stat_call { }

1;
