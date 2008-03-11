package t::TestJS;
use Test::Base -Base;
use JS;

package t::TestJS::Filter;
use Test::Base::Filter -Base;

sub run_js {
    my $command = shift;
    @INC = ('t/testlib');
    $command =~ s{^js-cpan\s+}{};
    return "JS->new->run(qw($command))";
}
