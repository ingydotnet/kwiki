use 5.008003;
use strict;
use warnings;

use Config();

# Clobber @INC to make sure we are self contained.
BEGIN {
    system("(cd lib; make core)") == 0 or die;
    @INC = (
        'lib',
        $Config::Config{privlib},
        $Config::Config{archlib},
    ); 
}

use Script::Hater;

Script::Hater->new->run;

{
    package Script::Hater;
    use IO::All;

    sub initialize {
        my ($self, $data) = @_;
        my $save = $self->save;
        $save->{kwiki_base} = $ENV{PWD};
        return;
    }

    sub write_config_yaml {
        my ($self, $data) = @_;
        my $save = $self->save;
        my $config = <<"...";
PERL = $save->{perl_path}
KWIKI_BASE = $save->{kwiki_base}
...
        io('config.mk')->print($config);
        return;
    }

    sub check_sanity {
        my ($self, $data) = @_;
        die "Can't run Configure.pl from here."
          unless -f 'Configure.pl';
        die "Kwiki doesn't work on MSWin32. Perhaps try cygwin."
          if $^O eq 'MSWin32';
        return;
    }

    sub set_perl {
        my ($self, $data) = @_;
        $data->{default} = $Config::Config{perlpath};
    }
}

__DATA__
---
start:
  handler: check_sanity
  next: setup

setup:
  handler: initialize
  next: welcome

welcome:
  clear: 1
  print: |2
                                Welcome to Kwiki!

    This Configure.pl script will set up everything to get a new Kwiki up and
    running in a few minutes.

    You will be asked a number of questions about your local environment. If
    you wish to review what questions you will be asked before continuing,
    visit http://2.kwiki.org/?ConfigureQuestions.

    After general configuration is complete, you will be given the chance to
    install one or more instances of a Kwiki wiki. You may also elect to setup
    new Kwiki instances separately, and at a future time.

  next: ask_to_continue

ask_to_continue:
  prompt:
    msg: Do you wish to continue?
    type: Yn
    n_state: goodbye
  next: which_perl

which_perl:
  prompt:
    pre: set_perl
    msg: |
      Which Perl binary do you want to use for all Kwiki operations?
      The default is the one you used to run this Configure.pl.
    type: execpath
    save: perl_path
  next: complete

goodbye:
  print: Goodbye!
  next: end

complete:
  handler: write_config_yaml
  print: Configuration is complete. Enjoy using Kwiki!
  next: end
