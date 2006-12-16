package Kwiki::UniUI;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
our $VERSION = '0.10';

const class_id => 'uniui';
# const javascript_file => 'uniui.js';
const css_file => 'uniui.css';

sub init {
    super;
    $self->hub->ajax_toolman;
    $self->hub->javascript->add_file('datadumper.js');
    $self->hub->javascript->add_file('UniuiPage.js');
#     $self->hub->javascript->add_file('UniuiPageList.js');
#     $self->hub->javascript->add_file('uniui.js');
}

sub register {
    my $registry = shift;
    $registry->add(preload => 'uniui');

    $registry->add(action => 'uniui_home_page');
    $registry->add(action => 'uniui_recent_changes');
    $registry->add(action => 'uniui_search');
    
    $registry->add(hook => 'page:kwiki_link', pre => 'kwiki_link_hook' );
}

sub uniui_home_page {
    $self->hub->template->render('uniui_home_page.html',
    );
}

sub uniui_recent_changes {
    $self->hub->template->render('uniui_query_result_set.html',
        result_set => $self->hub->recent_changes->recent_changed_pages,
    );
}

sub uniui_search {
    $self->hub->template->render('uniui_query_result_set.html',
        result_set => $self->hub->search->perform_search,
    );
}

sub kwiki_link_hook {
    my $hook = pop;
    $hook->cancel;
    my $label = shift;
    my $page = $self; 
    my $page_uri = $page->uri;
    $label = $page->title
      unless defined $label;
    return $label unless $page->is_readable;
    qq(<a href="#" onclick="open_page_display('$page_uri');return false;">$label</a>);
}

__DATA__

=head1 NAME

Kwiki::UniUI - A Unified Interface Theme for Kwiki

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2006. Ingy döt Net. All rights reserved.

Copyright (c) 2005. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut


__template/tt2/uniui_home_page.html__
<h3>Welcome to the Kwiki Ajax Unified Interface Development Area</h3>
This view of <a href="http://www.kwiki.org">www.kwiki.org</a> uses a special
theme with "Ajax" capabilities. Try recent changes and search. Try opening
entries and dragging them around.
__template/tt2/uniui_query_result_set.html__
<ul id="uniui_page_list">
[% FOR page = result_set %]
[% INCLUDE uniui_query_result_item.html %]
[% END %]
</ul>
__template/tt2/uniui_query_result_item.html__
<li id="[% page.id %]">
<a name="anchor_[% page.id %]"></a>
<a href=""
   onclick="uniui_Page_List.findPage('[% page.id %]').toggleDisplay();return false;"
> [% page.id %] </a>
<div id="display_[% page.id %]" class="page_display" style="display: none">
</div>
</li>
__javascript/dummyClass.js__
// This is the constructor
var dummyClass = function(value) { 
    this.bar = value;
}
// This sets the inheritance
dummyClass.prototype = new Object()
// This defines a method for all instances
dummyClass.prototype.foo = function(bar, baz) {
}
// Create a new object
var xxx = new uniuiPage(12345678);
// Call a method
xxx.foo();
// Add an instance-only method
xxx.baz = function() { alert('I am lonely') }

__javascript/UniuiPage.js__
//------------------------------------------------------------------------------
// UniuiPage - Object Repesenting a Kwiki Page
UniuiPage = function(page_id) { 
    this.id = page_id
}
_ = UniuiPage.prototype = new Object()
uniuiPage = function() { return new UniuiPage(arguments) }
//------------------------------------------------------------------------------

_.toggleDisplay = function() {
    var div_id = 'display_' + this.id
    var display_div = document.getElementById(div_id)
    if (display_div.style.display == 'none') {
//        window.location = '#anchor_' + this.id
        open_display_div(this.id, display_div)
    }
    else {
        display_div.style.display = 'none'
    }
}

// __javascript/UniuiPageList.js__
//------------------------------------------------------------------------------
// UniuiPageList - Object Repesenting a List of Pages
UniuiPageList = function() { }
_ = UniuiPageList.prototype = new Object()
uniuiPageList = function() { return new UniuiPageList(arguments) }

//------------------------------------------------------------------------------

_.page_set = new Object()

_.addPage = function(page_id) {
    this.page_set[page_id] = new UniuiPage(page_id)
}

_.findPage = function(page_id) {
    return this.page_set[page_id]
}

_.initializeFromQuery = function(query_string, callback) {
    set_loading_message_html('kwiki_ajax_main_div')
    var self = this
    replace_element_with_html_from_kwiki_query(
        'kwiki_ajax_main_div',
        query_string,
        function() {
            ToolMan.dragsort().makeListSortable(
                document.getElementById("uniui_page_list"),
                function(item) {
                    item.toolManDragGroup.verticalOnly()
                }
            );

            var list = document.getElementById('uniui_page_list')
            var array = list.getElementsByTagName('li')
            for (i = 0; i < array.length; i++) {
                var page_id = array[i].getAttribute('id')
                self.addPage(page_id)
            }
            if (callback) callback()
        }
    )
}

uniui_Page_List = uniuiPageList()

// __javascript/uniui.js__
//------------------------------------------------------------------------------
// Functional UniUI code.
//------------------------------------------------------------------------------

// function sleep(milli_seconds) {
//     var then, now
//     then = new Date().getTime()
//     now = then
//     while((now - then) < milli_seconds) {
//         now = new Date().getTime()
//     }
// }

main_kwiki_ajax_function = uniui_home_page
// main_kwiki_ajax_function = uniui_unit_test

function uniui_unit_test() {
    test2 = function() {
        uniui_Page_List.findPage('HomePage').toggleDisplay()
    }

    uniui_Page_List.initializeFromQuery(
        'action=uniui_recent_changes',
        test2
    )
}

function uniui_home_page() {
    replace_element_with_html_from_kwiki_query(
        'kwiki_ajax_main_div',
        'action=uniui_home_page'
    )
}

function set_loading_message_html(elem) {
    replace_element_with_html_string(
        elem,
        '<blink><span style="color: red">Loading...</span></blink>'
    )
}

function uniui_recent_changes() {
    uniui_Page_List.initializeFromQuery('action=uniui_recent_changes')
}

function uniui_search() {
    var form = document.getElementById('search_form')
    var search_term = form.elements['search_term'].value
    var query = 'action=uniui_search;search_term=' + search_term
    uniui_Page_List.initializeFromQuery(query)
}

function add_page_to_list(page_id) {
    uniui_Page_List.addPage(page_id)
    var l = document.getElementById("uniui_page_list")
    var newNode = document.createElement("li")
    newNode.innerHTML =  
        '<a name="anchor_' + page_id +
        '"></a><a href="#" onclick="uniui_Page_List.findPage(\''+ page_id +
        '\').toggleDisplay();return false;">' + page_id +
        '</a><div id="display_' + page_id +
        '" class="page_display" style="display: none"> </div>';
    var firstChild = l.firstChild
    l.insertBefore(newNode,l.firstChild)
}

function open_page_display(page_id) {
    var div_id = 'display_' + page_id 
    var display_div = document.getElementById(div_id)
    if (display_div == null) {
       add_page_to_list(page_id)
       display_div = document.getElementById(div_id)
    }
    if (display_div.style.display == 'none') {
        open_display_div(page_id, display_div)
    }
    window.location = '#anchor_' + page_id
}

function open_display_div(page_id, display_div) {
    display_div.style.display = 'block'
    set_loading_message_html(display_div)
    replace_element_with_html_from_kwiki_query(
        display_div,
        "action=display_html;page_name=" + page_id
    )
}

__css/uniui.css__

.page_display
{
  background: #f5f5f5;
  padding: 0.5em;
  margin: 0.5em 0;
  border-style: outset;
}
