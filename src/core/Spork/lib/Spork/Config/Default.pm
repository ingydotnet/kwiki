package Spork::Config::Default;
use Spiffy -Base;
use Cwd;

my @pwent;
sub pwent {
    @pwent = getpwuid $< unless @pwent;
    return \@pwent;
}

sub login {
    $self->pwent->[0]
}

sub author_name {
    $self->pwent->[6];
}

sub author_email {
	my $name = $self->login;
	my $domain = eval {
		require Net::Domain;
		Net::Domain::hostdomain() || die;
	} || "...";
	join('@', $name, $domain);
};

sub author_webpage {
    "http://search.cpan.org/~" . $self->login
};

sub copyright_string {
    join(" ","Copyright &copy;", (localtime)[5] + 1900, $self->author_name)
}

sub file_base { Cwd::cwd() }

sub download_method {
	return eval {
		require LWP;
		return "lwp";
	} || eval {
		require File::Which;
		foreach my $exe (qw/wget curl/){
			return $exe if File::Which::which($exe);
		}
	} || "wget";
}

sub hash_ref {
	+{
		$self->_simple_defaults,
		$self->_guessing_defaults,
	}
}

sub _guessing_defaults {
	my @methods =qw(download_method file_base author_name
			author_email author_webpage copyright_string);
	my @rv;
	for (@methods) {
		push @rv, $_ => $self->$_;
	}
	return @rv
}

sub _simple_defaults {
    return (
	banner_bgcolor =>  "hotpink",
	show_controls =>  1,
	mouse_controls =>  0,
	image_width =>  350,
	auto_scrolldown =>  1,
	logo_image =>  "logo.png",
	slides_file => "Spork.slides",
	template_directory =>  "template/tt2",
	slides_directory =>  "slides",
	character_encoding =>  "utf-8",
	link_previous =>  "&lt; &lt; Previous",
	link_next =>  "Next &gt;&gt;",
	link_index =>  "Index",
	start_command =>  "open slides/start.html",
	template_path => [ './template/tt2' ]
    )
}

=pod

=head1 NAME

Spork::Config::Default - default values for config.yaml

=cut


