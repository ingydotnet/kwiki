use pQuery;
pQuery('whiteg.html')                      # Load document
    ->find(':header')                       # Find all headers
    ->each(sub {                            # For each header
        my $num = $_->tagName;              # Get tag (H1,H2...)
        $num =~ s/H//;                      # Strip off 'H'
        var $indent = "  " x ($num - 1);    # Make indent
        print $indent . pQuery($_).text;    # Print TOC line
    })

