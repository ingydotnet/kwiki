package Script::Hater;
use strict;
use warnings;

sub XXX { require YAML; die YAML::Dump(@_) }

sub new {
    bless {}, shift;
}

sub save {
    my $self = shift;
    $self->{save} ||= {};
    return $self->{save};
}

sub run {
    my $self = shift;
    my $table = $self->{table} = $self->data;
    my $state = 'start';
    while ($state ne 'end') {
        die "No table definition for '$state'"
          unless exists $table->{$state};
        my $data = $table->{$state};
        $data = {} unless ref $data;
        my $handler = $self->can($state) ? $state : 'generic_handler';
        my $prev_state = $state;
        $state = $self->$handler($data);
        die "No next state from '$prev_state'\n" unless $state;
    }
}

sub data {
    require YAML;
    local $/;
    no warnings 'once';
    YAML::Load(<main::DATA>);
}

sub generic_handler {
    my ($self, $data) = @_;
    my $next;

    if (my $handler = $data->{handler}) {
        $next = $self->$handler($data);
        $next ||= '';
        $next = '' unless $next =~ /^[a-z]\w+$/;
    }

    $self->clear if $data->{clear};

    if (my $print = $data->{print}) {
        $print .= "\n" unless $print =~ /\n\z/;
        print "\n$print";
    }

    $next = $self->prompt($data->{prompt}) if $data->{prompt};

    $next ||= $data->{next};
    return $next;
}

sub clear {
    system('clear');
}

sub prompt {
    my ($self, $data) = @_;
    print "\n";
    if (my $pre = $data->{pre}) {
        $self->$pre($data);
    }
    my $answer = 
        $data->{type} =~ /^yn$/i ? $self->prompt_yn($data) :
        $data->{type} eq 'execpath' ? $self->prompt_execpath($data) :
        XXX($data);
    if ($data->{save}) {
        $self->save->{$data->{save}} = $answer;
    }
    return $data->{"${answer}_state"} || '';
}

sub prompt_yn {
    my ($self, $data) = @_;
    my $default_string = $data->{type};
    $data->{default} =
      $default_string eq 'Yn' ? 'y' :
      $default_string eq 'yN' ? 'n' :
      defined $data->{default} ? $data->{default} :
      die "No default";
    my $msg = $data->{msg};
    $data->{prompt} = "$msg [$default_string] > ";
    $data->{validate} = sub { /^[yn]$/i };
    return lc $self->do_prompt($data);
}

sub prompt_execpath {
    my ($self, $data) = @_;
    $data->{validate} = sub { -f and -x };
    $self->do_prompt($data);
}

sub do_prompt {
    my ($self, $data) = @_;
    my ($msg, $default, $validate, $prompt) =
      @{$data}{qw(msg default validate prompt)};
    $prompt ||= "$msg [$default] > ";
    $prompt =~ s/\n /\n/;
    my $answer = '';
    while (1) {
        print $prompt;
        $answer = <STDIN>;
        chomp $answer;
        $answer ||= $default;
        local $_ = $answer;
        last if &$validate;
        print "$answer is an invalid response\n";
    }
    return $answer;
}

1;
