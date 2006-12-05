use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Kwiki::Users::Cookie::SQL',
    AUTHOR              => 'John Cappiello <jcap@cpan.org>',
    VERSION_FROM        => 'lib/Kwiki/Users/Cookie/SQL.pm',
    ABSTRACT_FROM       => 'lib/Kwiki/Users/Cookie/SQL.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
				'Kwiki::Users::Cookie' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Kwiki-Users-Cookie-SQL-*' },
);
