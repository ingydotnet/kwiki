use ExtUtils::MakeMaker;

WriteMakefile(
  'NAME'         => 'Kwiki::IRCMode',
  'VERSION_FROM' => 'lib/Kwiki/IRCMode.pm',
  'PREREQ_PM'    => {
    'Kwiki' => 0.33,
    'Parse::IRCLog' => '1.10'
  },
  'PREREQ_PRINT' => 1
);
