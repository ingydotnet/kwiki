package Kwiki::Docsite;

use warnings;
use strict;


our $VERSION = '0.01';


use Kwiki::Plugin -Base;

const class_id => 'command_docsite';
const class_title => 'Command Docsite';

sub register {
    my $reg = shift;
    $reg->add(command => 'docsite',
              description => 'Compile whole wiki into a directory of HTML');
}

sub handle_docsite {
    my $output = shift || "doc";
    my $outdir = io($output)->dir->mkpath
        or die "Cannot make directory $output\n";

    # Because this is not under CGI mode.
    # Have to fake some environment here.
    $self->init_env();

    for my $page ( $self->hub->pages->all ) {
        io->catfile($outdir, $page->uri . ".html" )->print(
            $self->hub->display->render_screen(
                screen_title => $page->title,
                page_html => $page->to_html
            )
        )
    }
}

sub init_env {
    $self->hub->theme->init;
}


1; # End of Kwiki::Docsite
