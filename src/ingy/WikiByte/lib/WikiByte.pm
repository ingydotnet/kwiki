package WikiByte;
use strict;
use warnings;
use Getopt::Long;
use utf8;
use XXX;

sub new { bless {}, shift }

sub process_command_line {
    my $self = shift;
    $self->get_options(@_);
    my $command = $self->{command};
    my $method = "handle_$command";
    $self->$method;
}

sub get_options {
    my $self = shift;
    local @ARGV = @_;
    $self->{command} = 'html';
    $self->{validate} = 0;
    GetOptions(
        "validate" => \ $self->{validate},
    );
}

sub handle_html {
    my $self = shift;
    require HTML::TreeBuilder;
    my $root = HTML::TreeBuilder->new_from_content(do {local $/; <STDIN>});
    $self->walk($root);
}

sub walk {
    my $self = shift;
    my $element = shift;
    my $content = $element->{_content};
    for my $block (@$content) {
        if (ref $block) {
            print "+" . $block->{_tag} . $self->attributes($block) . "\n";
            $self->walk($block);
            print "-" . $block->{_tag} . "\n";
        }
        else {
            my $text = $block;
            print " $text\n";
        }
    }
}

sub attributes {
    my $self = shift;
    my $element = shift;
    my $return = '';
    for my $key (sort keys %$element) {
        next if $key =~ /^_/;
        $return .= " $key=\"" . $element->{$key} . '"';
    }
    return $return;
}

1;
