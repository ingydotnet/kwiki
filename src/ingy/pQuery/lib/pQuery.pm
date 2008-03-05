# pQuery - A Perl version of jQuery.

package pQuery;
use strict;
use warnings;
use 5.006001;
use pQuery::DOM;

use base 'Exporter';

our $VERSION = '0.01';

our @EXPORT = qw(pQuery);

our $DOM;

my $my = {};
my $lwp_user_agent;
my $quickExpr = qr/^[^<]*(<(.|\s)+>)[^>]*$|^#(\w+)$/;
my $isSimple = qr/^.[^:#\[\.]*$/;
my $dom_element_class = 'pQuery::DOM';

sub pQuery {
    return 'pQuery'->new(@_);
}

sub new {
    my $class = shift;
    my $self = bless [], $class;
    $my->{$self} = {};
    return $self->_init(@_);
}

sub _init {
    my ($self, $selector, $context) = @_;

    my $document = $DOM || $main::DOM || $main::DOM;
    $selector ||= $document or return $self;

    if (ref($selector) eq $dom_element_class) {
        @$self = $selector;
        return $self;
    }
    elsif (not ref($selector)) {
        my $match = ($selector =~ $quickExpr);

        if ($match and ($1 or not $context)) {
            if ($1) {
                $selector = $self->_clean([$1], $context);
            }
            else {
                my $id = $3;
                my $elem = $document->getElementById($id);
                if ($elem) {
                    if ($elem->id ne $id) {
                        return pQuery->find($selector);
                    }
                    else {
                        $self->[0] = $elem;
                        $#$self = 0;
                        return $self;
                    }
                }
                else {
                    $selector = [];
                }
            }



            @$self = pQuery::DOM->fromHTML($selector);
            return $self;



        }
        else {


            if ($selector =~ /^\s*(https?|file):/) {
                return $self->_new_from_url($selector);
            }
            else {
                die "Can't create new pQuery object with these arguments:\n(@_)";
            }
        }
    }
    elsif (ref($selector) eq 'ARRAY') {
        @$self = @$selector;
        return $self;
    }
    return $self;
}

sub _clean {
    my ($self, $html) = @_;
    return $html->[0];
}

sub _new_from_url {
    my $self = shift;
    my $url = shift;
    my $response = $self->get($url);
    if (! $response->is_success) {
        return $self;
    }
    @$self = pQuery::DOM->fromHTML($response->content);
}

sub html {
    my $self = shift;
    if (@_) {
        my $dom = $self->html_to_dom(@_);
        die "XXX - need to insert dom here";
    }
    return unless @$self;

    return $self->[0]->innerHTML;
}

sub toHtml {
    my $self = shift;
    if (@_) {
        my $dom = $self->html_to_dom(@_);
        die "XXX - need to insert dom here";
    }
    return unless @$self;

    return $self->[0]->toHTML;
}

sub text {
    my $self = shift;
    my $text = '';

    $self->each(sub {
        _to_text($_, \$text);
    });

    $text =~ s/\s+/ /g;
    $text =~ s/\s$//;

    return $text;
}

sub each {
    my ($self, $sub) = @_;
    my $i = 0;
    &$sub($i++) for @$self;
    return $self;
}

sub find {
    my $self = shift;
    my $selector = shift or return;
    my $elems = [];
    $self->each(sub {
        _find_elems($_, $selector, $elems);
    });
    return pQuery($elems);
}

sub end {
    my $self = shift;
    die "not implemented yet";
}

sub get {
    my $self = shift;
    my $url = shift;
    require LWP::UserAgent;
    $lwp_user_agent ||= LWP::UserAgent->new;

    my $request = HTTP::Request->new(GET => $url);
    my $response = $lwp_user_agent->request($request);
    return $response;
}

# Helper functions (not methods)
sub _to_text {
    my ($elem, $text) = @_;
    if (ref $elem) {
        for my $child (@{$elem->{_content}}) {
            _to_text($child, $text);
        }
    }
    else {
        $$text .= $elem;
    }
}

sub _find_elems {
    my ($elem, $selector, $elems) = @_;
    return unless ref $elem;

    if ($selector =~ /^\w+$/) {
        if ($elem->{_tag} eq $selector) {
            push @$elems, $elem;
            
        }
    }

    for my $child (@{$elem->{_content}}) {
        _find_elems($child, $selector, $elems);
    }
}

1;

=head1 NAME

pQuery - Perl Port of jQuery.js

=head1 SYNOPSIS

    use pQuery;

    pQuery("http://google.com/search?q=pquery")
        ->find("h2.r")
        ->each(sub {
            my $i = shift;
            print ($i + 1), ") ", pQuery($_)->text, "\n";
        });

=head1 DESCRIPTION

pQuery is a pragmatic attempt to port the jQuery JavaScript framework to
Perl. It is pragmatic in the sense that it switches certain JavaScript
idioms for Perl ones, in order to make the use of it concise. A primary
goal of jQuery is to "Find things and do things, concisely". pQuery has
the same goal.

pQuery exports a single function called C<pQuery>. This function acts a
constructor and does different things depending on the arguments you
give it. This is discussed in the L<CONSTRUCTORS> section below.

A pQuery object acts like an array reference (because, in fact, it is).
Typically it is an array of HTML::DOM elements, but it can be an array
of anything.

Like jQuery, pQuery methods return a pQuery object; either the
original object or a new derived object. All pQuery L<METHODS> are
described below.

=head1 CONSTRUCTORS

THe pQuery constructor is an exported function called C<pQuery>. It does
different things depending on the arguments you pass it.

=head2 A URL

If you pass pQuery a URL, it will attempt to get the page and use its
HTML to create a HTML::DOM object. The pQuery object will contain the
top level HTML::DOM object.

    pQuery("http://google.com");

=head2 HTML

If you already have an HTML string, pass it to pQuery and it will create
a HTML::DOM object. The pQuery object will contain the top level
HTML::DOM object.

    pQuery("<p>Hello <b>world</b>.</p>");

=head2 Selector String

You can create a pQuery object with a selector string just like in
jQuery. The problem is that Perl doesn't have a global DOM object lying
around like JavaScript does. You need to pass the DOM to select on as
the second parameter. (jQuery also has this second parameter).

    pQuery("table.mygrid > td:eq(7)", $dom);

=head2 pQuery Object

You can create a new pQuery object from another pQuery object. The new
object will be a shallow copy.

    my $pquery2 = pQuery($pquery1);

=head2 Array Reference

You can create a pQuery object as an array of anything you want; not
just HTML::DOM elements. This can be useful to use the C<each> method to
iterate over the array.

    pQuery(\ @some_array);

=head2 No Arguments

Calling pQuery with no arguments will return a pQuery object that is
just an empty array reference. This is useful for using it to call class
methods that don't need a DOM object.

    my $html = pQuery->get("http://google.com")->content;

=head1 METHODS

This is a reference of all the methods you can call on a pQuery object. They
are all ported from jQuery.

=head2 each($sub)

This method takes a subroutine reference and calls the subroutine once
for each member of the pQuery object that called C<each>. When the
subroutine is called it is passed an integer count starting at 0 at
incremented once for each call. It is also passed the current member of
the pQuery object in C<$_>.

    pQuery("td", $dom)->each(sub {
        my $i = shift;
        print $i, " => ", pQuery($_)->text(), "\n";
    });

The C<each> method returns the pQuery object that called it.

=head2 find($selector)

This method will search all the HTML::DOM elements of the its caller for
all sub elements that match the selector string. It will return a new
pQuery object containing all the elements found.

    my $pquery2 = $pquery1->find("h1,h2,h3");

=head2 html() html($html)

This method is akin to the famous JavaScript/DOM function C<innerHTML>.

If called with no arguments, this will return the the B<inner> HTML
string of the B<first> DOM element in the pQuery object.

If called with an HTML string argument, this will set the inner HTML of all
the DOM elements in the pQuery object.

=head2 HTML()

This function takes no arguments, and returns the B<outer> HTML of the first
DOM object in the pQuery object. Outer HTML means the HTML of the current
object and its inner HTML.

For example:

    pQuery('<p>I <b>like</b> pie</p>').HTML();

returns:

    <p>I <b>like</b> pie</p>

while:

    pQuery('<p>I <b>like</b> pie</p>').html();

returns:

    I <b>like</b> pie

=head2 end()

Revert the most recent 'destructive' operation, changing the set of
matched elements to its previous state (right before the destructive
operation). This method is useful for getting back to a prior context
when chaining pQuery methods.

    pQuery("table", $dom)     # Select all the tables
        ->find("td")          # Select all the tds
        ->each(sub { ... })   # Do something with the tds
        ->end()               # Go back to the tables selection
        ->each(sub { ... });  # Do something with the tables

=head2 get($url)

This method will fetch the HTML content of the URL and return a
HTML::Response object.

    my $html = pQuery.get("http://google.com")->content;

=head1 UNDER CONSTRUCTION

This module is still being written. The documented methods all work as
documented (but may not be completed ports of their jQuery
counterparts yet).

The selector syntax is still very limited. (Single tags, IDs and classes
only).

There is still much more code to port. Stay tuned...

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
