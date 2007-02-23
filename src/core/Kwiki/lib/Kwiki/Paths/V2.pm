package Kwiki::Paths::V2;
use Kwiki::Base -Base;

sub first_filepath {
    return "$ENV{KWIKI_BASE}/base/database";
}
