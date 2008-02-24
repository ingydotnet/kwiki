use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Kwiki::OpenID',
    'VERSION_FROM' => 'lib/Kwiki/OpenID.pm', # finds $VERSION
    'PREREQ_PM' => {
        Test::More => 0.32,
        Kwiki => 0.38,
        Spoon => 0.22,
        Kwiki::UserName => 0.14,
        Kwiki::Session => 0.01,
        Net::OpenID::Consumer => 0.14,
        Text::Microformat => 0.02,
        Digest::SHA1 => 2.11,
    },
);
