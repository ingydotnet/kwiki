package Kwiki::VimMode;
use strict;
use warnings;

use Kwiki::Plugin -Base;
use Kwiki::Installer -base;

our $VERSION = 0.05;

const class_title => 'color hiliting using Vim';
const class_id    => 'vim_mode';
const css_file    => 'vim_mode.css';

sub register {
    my $registry = shift;
    $registry->add( wafl => vim => 'Kwiki::VimMode::Wafl' );
}

package Kwiki::VimMode::Wafl;
use base 'Spoon::Formatter::WaflBlock';

sub to_html {
    require Text::VimColor;
    my $string = $self->block_text;
    chomp $string;
    $ENV{PATH} = "/usr/local/bin:$ENV{PATH}";
    $string =~ s/^ filetype: \s* (\w+) \s* \n+//sx;
    my @filetype = $1 ? ( filetype => $1 ) : ();
    my $vim = Text::VimColor->new(
        string => $string,
        @filetype,
        vim_options => [ qw( -RXZ -i NONE -u NONE -N ), "+set nomodeline" ]
    );
    return '<pre class="vim">' . $vim->html . "</pre>\n";
}

package Kwiki::VimMode;

__DATA__


__css/vim_mode.css__
pre.vim { margin-left: 1em }
.synComment    { color: #0000FF }
.synConstant   { color: #FF00FF }
.synIdentifier { color: #008B8B }
.synStatement  { color: #A52A2A ; font-weight: bold }
.synPreProc    { color: #A020F0 }
.synType       { color: #2E8B57 ; font-weight: bold }
.synSpecial    { color: #6A5ACD }
.synUnderlined { color: #000000 ; text-decoration: underline }
.synError      { color: #FFFFFF ; background: #FF0000 none }
.synTodo       { color: #0000FF ; background: #FFFF00 none }
