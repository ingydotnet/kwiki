package Kwiki::Paths::V2;
use Kwiki::Base -Base;

sub find_first_filepath {
    return "$ENV{KWIKI_BASE}/base/database";
}
