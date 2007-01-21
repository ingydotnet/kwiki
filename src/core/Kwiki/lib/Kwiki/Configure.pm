package Kwiki::Configure;
use Kwiki::Plugin -Base;
our $VERSION = '0.01';
use Config();
use Script::Hater;

const class_id => 'configure';
const class_title => 'Kwiki Site Configuration';

sub register {
    my $registry = shift;
    $registry->add(
        command => 'configure',
        description => 'Sitewide Kwiki initial configuration'
    );
}

sub handle_configure {
    chdir $ENV{KWIKI_BASE} or die;
    Script::Hater->new->run;
}

package Script::Hater;
use IO::All;

sub initialize {
    my ($data) = @_;
    my $save = $self->save;
    $save->{kwiki_base} = $ENV{PWD};
    return;
}

sub write_config_yaml {
    my ($data) = @_;
    my $save = $self->save;
    my $config = <<"...";
PERL = $save->{perl_path}
KWIKI_BASE = $save->{kwiki_base}
...
    io('config.mk')->print($config);
    return;
}

sub check_sanity {
    my ($data) = @_;
    # Check Perl version
    die "Kwiki doesn't work on MSWin32. Perhaps try cygwin."
      if $^O eq 'MSWin32';
    return;
}

sub set_perl {
    my ($data) = @_;
    $data->{default} = $Config::Config{perlpath};
}

no warnings 'redefine';
sub data {
    require YAML;
    return YAML::Load(<<'...');
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

    This command will set up everything to get a new Kwiki up and
    running in less than a minute.

    You will be asked a few questions about your local environment. If
    you wish to review what questions you will be asked before
    continuing, visit http://2.kwiki.org/?ConfigureQuestions.

    After general configuration is complete, you will be given the
    chance to install one or more instances of a Kwiki wiki. You may
    also elect to setup new Kwiki instances separately using:

        kwiki -new

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
      The default is the one you used to run this command.
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
...
}
