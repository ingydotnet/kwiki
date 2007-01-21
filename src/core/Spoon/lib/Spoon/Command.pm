package Spoon::Command;
use Spoon::Base -Base;

field quiet => 0;

sub process {
    no warnings 'once';
    local *boolean_arguments = sub { qw( -q -quiet ) };
    my ($args, @values) = $self->parse_arguments(@_);
    $self->quiet(1)
      if $args->{-q} || $args->{-quiet};
    my $action = $self->get_action(shift(@values)) ||
                 sub { $self->default_action(@_) };
    $action->(@values);
    return $self;
}

sub get_action {
    my $action = shift
      or return;
    $action =~ s/^-//
      or return;
    my $method = "handle_$action";
    return sub {
        $self->$method(@_);
    } if $self->can($method);
    my $array = $self->hub->registry->lookup->{command}{$action}
      or return;
    my $class_id = shift @$array;
    my $object = $self->hub->$class_id;
    return sub {
        $object->$method(@_);
    };
}

sub default_action {
    $self->usage;
}

sub command_usage {
    my $pattern = shift;
    my $lookup = $self->hub->registry->lookup;
    my $commands = $lookup->{command} || {};
    my %descriptions = map {
        my $array = $commands->{$_};
        shift @$array;
        my %hash = @$array;
        my $description = $hash{description} || '';
        ($_, $description);
    } keys %$commands;
    my $usage = '';
    for my $plugin (@{$lookup->plugins}) {
        my $class_id = $plugin->{id};
        for my $command (@{$lookup->add_order->{$class_id}{command}}) {
            $usage .= sprintf($pattern, $command, $descriptions{$command});
        }
    }
    return $usage;
}

sub msg {
    warn @_ unless $self->quiet;
}
