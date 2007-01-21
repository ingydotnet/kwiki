package Kwiki::LaTeXMath;
use strict;
use warnings;
use Kwiki::Plugin '-Base';

our $VERSION = 0.01;

const class_title => 'LaTeX Math in Kwiki';
const class_id => 'latexmath';


sub register {
    my $registry = shift;
    $registry->add(wafl => latexmath => 'Kwiki::LaTeXMath::Wafl');
}

1;

package Kwiki::LaTeXMath::Wafl;
use Spoon::Formatter ();
# use base 'Spoon::Formatter::WaflPhrase';
use base 'Spoon::Formatter::WaflBlock';


use Digest::MD5 qw(md5_hex);

my $base_dir = 'latex_images/';
my $ext = 'png';

my $latex_file_pre = <<EOF;
\\documentclass[12pt]{article}
\\pagestyle{empty}
\\begin{document}

\\begin{displaymath}
EOF


my $latex_file_post = <<EOF;
\\end{displaymath}

\\end{document}
EOF


sub to_html {
    my $equ = $self->block_text;
#    my $equ = $self->arguments;
    my $dir = 'plugin/' . $base_dir;
    my $base_name = md5_hex($equ);

    if(! -f $dir . $base_name . '.' . $ext) {
	$self->mk_file($dir, $base_name, $equ);
    }

    join('',
	 '<div style="text-align:center;">',
	 '<img src="', 
	 $dir,
         $base_name, 
	 '.',
	 $ext,
	 '" />',
	 '</div>'
        );
}


sub mk_file {
    my($dir, $base_name, $equ) = @_;
    warn "Dir: $dir";
    warn "Base: $base_name";
    warn "Equ: $equ";

    my $tex_file = $base_name.'.tex';

    open LATEX, '>'.$dir . $tex_file;

    print LATEX $latex_file_pre;
    print LATEX $equ;
    print LATEX $latex_file_post;

    close LATEX;

    $self->textogif($dir, $tex_file);

}


# modified from 
#                          T E X T O G I F
#
#                          by John Walker
#                      http://www.fourmilab.ch/
#
#    	    	     $version = '1.1 (2003-11-07)';
#
# by PJWindley for including in Kwiki::LaTeXMath.  Here is the origianl 
# description:
#
#
#   Converts a LaTeX file containing equations(s) into a GIF file for
#   embedding into an HTML document.  The black and white image of the
#   equation is created at high resolution and then resampled to the
#   target resolution to antialias what would otherwise be jagged
#   edges.
#
#   Online documentation with sample output is available on the Web
#   at http://www.fourmilab.ch/webtools/textogif/
#
#   Write your equation (or anything else you can typeset with LaTeX)
#   in a file like:
#
#       \documentclass[12pt]{article}
#       \pagestyle{empty}
#       \begin{document}
#
#       \begin{displaymath}
#       \bf  % Compiled formulae often look better in boldface
#       \int H(x,x')\psi(x')dx' = -\frac{\hbar2}{2m}\frac{d2}{dx2}
#                                 \psi(x)+V(x)\psi(x)
#       \end{displaymath}
#
#       \end{document}
#
#   The "\pagestyle{empty}" is required to avoid generating a huge
#   image with a page number at the bottom.
#
#                         Required Software
#
#   This script requires the following software to be installed
#   in the standard manner.  Version numbers are those used in the
#   development and testing of the script.
#
#   Perl        5.8.0 (anything later than 4.036 should work)
#   TeX         3.14159 (Web2C 7.3.1)
#   LaTeX2e     <2000/06/01>
#   dvips       dvipsk 5.86
#   Ghostscript 6.52 (2001-10-20)
#   Netpbm      9.24

sub textogif {
    my ($d,$f) = (@_);


#                       Default Configuration
#
#   The following settings are the defaults used if the -dpi and
#   -res options are not specified on the command line.
#
#   The parameter $dpi controls how large the equation will appear
#   with respect to other inline images and the surrounding text.
#   The parameter is expressed in "dots per inch" in the PostScript
#   sense.  Unfortunately, since there's no standard text size in
#   Web browsers (and most allow the user to change fonts and
#   point sizes), there's no "right" value for this setting.  The
#   default of 150 seems about right for most documents.  A setting
#   of 75 generates equations at half the normal size, while 300
#   doubles the size of equations.  The setting of $dpi can always be
#   overridden by specifying the "-dpi" command line option.
#
    my $dpi = 100;
#
#   The parameter $res specifies the oversampling as the ratio
#   of the final image size to the initial black and white image.
#   Smaller values produce smoothing with more levels of grey but
#   require (much) more memory and intermediate file space to create
#   the image.  If you run out of memory or disc space with the
#   default value of 0.5, try changing it to 0.75.  A $res setting of
#   1.0 disables antialiasing entirely.  The setting of $res can
#   always be overridden by specifying the "res" command line option.
#
    my $res = 0.5;
#
#   The $background parameter supplies a command, which may be
#   void, to be inserted in the image processing pipeline to
#   adjust the original black-on-white image so that its background
#   agrees with that of the document in which it is to be inserted.
#   If your document uses a white background, the void specification:
#
#       $background = "";  $transparent = "ff/ff/ff";
#
#   should be used.  For colour or pattern backgrounds, you'll have
#   to hack the code.  The reason for adjusting the background is to
#   ensure that when the image is resampled and then output with a
#   transparent background the edges of the characters will fade
#   smoothly into the page background.  Otherwise you'll get a
#   distracting "halo" around each character.  You can override this
#   default specification with the -grey command line option.
#
    my $background = "";  
    my $transparent = "ff/ff/ff";
#
#   Image generation and decoding commands for GIF and PNG output.
#
    my $cmdPNG = 'pnmtopng';
    my $cmdPNGdecode = 'pngtopnm';
#
#   Default image creation modes
#
    my $imageCmd = $cmdPNG;
    my $imageCmdD = $cmdPNGdecode;
    my $imageExt = $ext;

    $f =~ s/(.*)\.tex$/$1/;
    &syscmd($d, "echo x | latex  $f >/dev/null\n");
    &syscmd($d, "dvips -f $f >_temp_$$.ps\n");
	    
    #   Assemble and execute the command pipeline which generates the image.

    #   Start by invoking Ghostscript with the pbmraw output device and
    #   output file set to standard output ("-") and the requested resolution.
    #   The -q (Quiet) option is required; otherwise Ghostscript will send
    #   processing information to standard output and corrupt transmission
    #   of the bitmap to the next component in the pipeline.
    my $cmd = "echo quit | gs -q -dNOPAUSE  -r" . int($dpi / $res). "x". int($dpi / $res) .
	    " -sOutputFile=- -sDEVICE=pbmraw _temp_$$.ps | " .

    #   Next we crop white space surrounding the generated text, promote
    #   the monochrome bitmap to a grey scale image with 8 bits per pixel,
    #   apply whatever background adjustment transform is requested, and
    #   scale the image to the desired size.
	    "pnmcrop -white | pnmdepth 255 | $background pnmscale " .
	    $res . " | " .

    #   Finally, convert the image to the desired output format and write
    #   the output file.
	    "$imageCmd -interlace -transparent rgb:$transparent >$f.$imageExt";
    &syscmd($d, $cmd);

    #   Sweep up debris left around by the various intermediate steps
    &syscmd($d, "rm $f.tex $f.dvi $f.aux $f.log _temp_$$.ps");

    #   Print the reference to include this figure, including width and height,
    #   to standard error.
    #my $r = `$imageCmdD $f.$imageExt | pnmfile`;
    #$r =~ m/(\d+) by (\d+)/;
    #return "<img src=\"$d$f.$imageExt\" width=\"$1\" height=\"$2\">\n";

    
    #	Echo and execute a system command
    
    sub syscmd {
    	my ($dir,$cmd) = @_;
	
	# print(STDERR "$cmd\n");
	my $foo = system("cd $dir; $cmd") == 0 || warn("Error processing command:\n\t$cmd\n\t");
    }

}

1;
