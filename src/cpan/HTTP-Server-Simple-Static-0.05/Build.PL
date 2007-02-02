use strict;

use Module::Build;

Module::Build->new
    ( module_name => 'HTTP::Server::Simple::Static',
      license     => 'perl',
      create_makefile_pl => 'traditional',
      requires    => { 'HTTP::Server::Simple' => 0.01 ,
		       'File::Spec::Functions' => 0,
                       'IO::File' => 0,
		       'URI::Escape' => 0,
		       'MIME::Types' => 0,
		       'File::MMagic'  => 0,
		       'Exporter' => 0
		       },
    )->create_build_script;
