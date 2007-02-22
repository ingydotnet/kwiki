use t::Spork tests => 3;

my $spork_dir = 't/spork';
File::Path::rmtree($spork_dir);
mkdir($spork_dir) or die;

sub run_cmd_manifest {
    my $home = Cwd::cwd();
    chdir($spork_dir) or die;
    Spork->new->load_hub->command->process('-new');
    my $manifest = join '', map "$_\n", sort find_files('.');
    chdir($home) or die;
    return $manifest;
}

ok(-f 'Spork.slides');

$ENV{HOME} = undef;
Spork->new->load_hub->command->process('-make');

ok(-f 'slides/index.html');

__END__
=== Create new spork setup
--- action run_cmd_manifest: -new
--- manifest
foo

=== Create new spork setup
--- action run_cmd_manifest: -make
--- manifest
foo


