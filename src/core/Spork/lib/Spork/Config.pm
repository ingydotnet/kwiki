package Spork::Config;
use Kwiki::Config -Base;
use mixin 'Spoon::Installer';

# use Spork::Config::Default;

const class_id => 'config';

sub parse_yaml_file {
    my $file = shift;
#     $self->parse_yaml(io($file)->utf8->all);
    $self->parse_yaml(io($file)->all);
}

sub default_configs {
    my @configs;
# 	push @configs, Spork::Config::Default->hash_ref; # first the guesses
    push @configs, "$ENV{HOME}/.sporkrc/config.yaml" # then the users defaults
      if defined $ENV{HOME} and -f "$ENV{HOME}/.sporkrc/config.yaml";
    push @configs, "config.yaml" # and then the values for pwd
      if -f "config.yaml";
    return @configs;
}

sub default_classes {
    (
        command_class => 'Spork::Command',
        config_class => 'Spork::Config',
        formatter_class => 'Spork::Formatter',
        hooks_class => 'Spoon::Hooks',
        hub_class => 'Spork::Hub',
        registry_class => 'Spork::Registry',
        slides_class => 'Spork::Slides',
        template_class => 'Spork::Template::TT2',

        # For Kwiki Plugins:
        cache_class => 'Kwiki::Cache',
        cgi_class => 'Kwiki::CGI',
        css_class => 'Kwiki::CSS',
        javascript_class => 'Kwiki::Javascript',
        kwiki_command_class => 'Kwiki::Command::V1',
        pages_class => 'Kwiki::Pages',
        preferences_class => 'Kwiki::Preferences',
    )
}

__DATA__

=head1 NAME

Spork::Config - Spork Configuration Class

=head1 SETTINGS

This is a list of all the current configuration options in alphabetical order:

=over 4

=item * author_email

The presentation author's email address.

=item * author_name

The presentation author's full name.

=item * author_webpage

The presentation author's webpage.

=item * auto_scrolldown

When a multipart slide is too long for the display, force it to scroll all the
way down when you link to it.

=item * banner_bgcolor

Background color for the banner boxes at the top and bottom of each slide.

=item * character_encoding

I18N character encoding. You probably want 'utf-8'.

=item * copyright_string

A copyright message to be displayed on each slide.

=item * download_method

Which program to use when downloading images. Possible values are:

    wget - default
    curl
    lwp

=item * file_base

A path to prepend to any relative file path provided to the C<<file<...> >>
directive.

=item * file_base

A path to prepend to any relative file path provided to the C<<file<...> >>
directive.

=item * formatter_class

Perl module to be used for slides formatting. You probably won't change this
unless you are up to the task of writing your own custom formatter.

=item * image_width

This is the default width that all images in your slideshow will be scaled to.

=item * link_index

Text for link to index page.

=item * link_next

Text for link to next page.

=item * link_previous

Text for link to previous page.

=item * logo_image

A small image to put at the bottom of each slide. You can leave this value
empty if you don't have a logo.

=item * mouse_controls

If this is turned off, clicking on the page will not advance the
screen. This is useful if you like to use the mouse to hilight things
on the page.

=item * show_controls

If this is turned off, the control links (previous, index, next) will not
display.

=item * slides_directory

The directory where all your slides will be written to when you do C<spork
-make>.

=item * slides_file

The name of the file that you write all of your slides in.

=item * start_command

The command that gets executed when you type C<spork -make>.

=item * template_class

The Perl module that is used for template processing. This module also
contains the default templates that are used. Possible values are:

    Spork::Template::TT2    (Template Toolkit - default)
    Spork::Template::Mason  (HTML::Mason - by Dave Rolsky)
    Spork::Template::Simple (Simplistic version with no dependencies)

=item * template_directory

The directory where spork writes all its templates during C<spork -make>. 
Templates will only be written if this directory does not exist.
So to force templates to be upgraded, delete this directory.

This directory should be listed in C<template_path>.

=item * template_path

A list of template directories to be used by the template processing class.

=back

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2004, 2005. Brian Ingerson. All rights reserved.
Copyright (c) 2007. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut

__config.yaml__
################################################################################
# Spork Configuration File.
# 
# Please read this file over and set the values to your own.
#
# If you want global settings for all your slideshows, copy this file to
# ~/.sporkrc/config.yaml. Any settings in this local file will override
# the global value of that setting.
# 
# See C<perldoc Spork::Config> for details on settings.
################################################################################

# These will be guessed using getpwuid on the real uid

author_name: Ingy döt Net
author_email: ingy@cpan.org
author_webpage: http://search.cpan.org/~ingy/
copyright_string: Copyright &copy; 2007 Ingy döt Net

# Some styling:

banner_bgcolor: orange
logo_image: logo.png
image_width: 350
auto_scrolldown: 1
show_controls: 0
mouse_controls: 0
link_previous: &lt; &lt; Previous
link_next: Next &gt;&gt;
link_index: Index


# Some paths:

slides_file: Spork.slides
template_directory: template/tt2
template_path: 
- ./template/tt2
slides_directory: slides

# This one defaults to CWD, and will vary each time you run 'spork -make'
# file_base: /Users/ingy/src/


# These should probably go in ~/.sporkrc/config.yaml if they're wrong

download_method: wget
start_command: open slides/start.html

character_encoding: utf-8



# Change core classes here:

# formatter_class: Spork::Formatter::Kwid


# Set plugin classes here:

# plugin_classes:
# - Spork::S5
# - Spork::S5Theme
# - Spork::S5ThemeFlower
# - Spork::S5ThemeBlackday
# - Kwiki::PerlBlocks

__plugins__
