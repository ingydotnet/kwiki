package Kwiki::Scode;
use Kwiki::Plugin -Base;
our $VERSION = '0.01';

use GD;
use CGI;

const class_id => 'scode';
const class_title => 'Scode prevents wiki spam';

my $tmpdir = "/tmp/";
my $scode_length = 6;
my $scode_maxtmp = 50;

sub init {
    $tmpdir = $self->plugin_directory . '/';
}

sub register {
    my $reg = shift;
    $reg->add(action => 'captcha');
}

sub captcha {
    my $cgi = new CGI;
    my $code = $cgi->param('code');

    # Calculate code
    my $scode = $self->scode_get($code);

    # lets define the image
    my $im_length = ($self->scode_len()+1)*10;
    my $im = new GD::Image($im_length,25);

    # define the color we going to use
    my $c_background = $im->colorAllocate(224,224,224);
    my $c_border = $im->colorAllocate(0,0,0);
    my $c_line = $im->colorAllocate(192,192,192);
    my $c_code = $im->colorAllocate(128,128,128);

    # Fill in the background
    $im->fill(50,50,$c_background);

    # Draw the borders lines
    for (my $i=0;$i<$im_length;$i+=5) {
        $im->line($i,0,$i,24,$c_line);
    }

    for (my $i=0;$i<25;$i+=5) {
        $im->line(0,$i,$im_length-1,$i,$c_line);
    }

    $im->rectangle(0,0,$im_length-1,24,$c_border);

    # Write the code
    $im->string(gdGiantFont,8,5,$scode,$c_code);

    # Generate the cookie
    my $cookie = $cgi->cookie(-name=>'code',-value=> $code);

    # Output the image
    binmode STDOUT;
    print $cgi->header(-type=>'image/png');
    print $im->png;

    return;
}


## Following code comes from MT::Scode plugin ##########

sub scode_len {
    return $scode_length;
}

sub scode_tmp {
    return $scode_maxtmp;
}

sub scode_generate {
    return int rand( (10**($scode_length)) - (10**($scode_length-1)) ) +
                      10**($scode_length-1);
}

sub scode_create {
    my $code = shift;

    return if (-e $tmpdir.$code);

    if ($code>0 && $code<=$scode_maxtmp) {
    	my $scode = scode_generate();
        open(OUTFILE,">${tmpdir}${code}");
        print OUTFILE $scode;
        close(OUTFILE);
    }
}

sub scode_delete {
    my $code = shift;

    if ($code>0 && $code<=$scode_maxtmp) {
        unlink $tmpdir.$code;
    }
}

sub scode_get {
    my $code = shift;

    srand time;

    # Random number back...if have not initialized
    if ($code<=0 || $code>$scode_maxtmp || !-e $tmpdir.$code ) {
        return scode_generate();
    }

    open(INFILE, $tmpdir.$code);
    my $scode = <INFILE>;
    close(INFILE);

    $scode =~ s/\D//g;
    return $scode;
}
