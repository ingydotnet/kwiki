use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Kwiki::GoogleMaps',
    'VERSION_FROM' => 'lib/Kwiki/GoogleMaps.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
    },
);
