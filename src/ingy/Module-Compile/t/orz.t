# BEGIN { unlink 't/orz.tc' }

# Need to incoke Module::Compile before Test::More
use Module::Compile;

use Test::More tests => 5;

pass "Test runs";

ok ((-f 't/orz.tc'), "Compiled file exists");

use t::Testorz;

fail "don't want this to run";

no t::Testorz;

pass "Second half of test runs";
