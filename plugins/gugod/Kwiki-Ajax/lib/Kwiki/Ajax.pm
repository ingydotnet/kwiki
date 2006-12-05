package Kwiki::Ajax;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
our $VERSION = '0.10';

const class_id => 'ajax';

sub init {
    $self->hub->javascript->add_file('xmlhttprequest.js');
    $self->hub->javascript->add_file('ajax.js');
}

sub register {
    my $registry = shift;
    $registry->add(action => 'ajax');
}

sub ajax {
    $self->render_screen;
}

__DATA__

=head1 NAME

Kwiki::Ajax - Ajax Support for Kwiki

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Brian Ingerson <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
__template/tt2/ajax_content.html__
<div id="kwiki_ajax_main_div">
</div>

<script>
var main_kwiki_ajax_function;
push_onload_function(
    function () {
        main_kwiki_ajax_function();
    }
);
</script>


__javascript/ajax.js__
/*
Kwiki::Ajax - Generic javascript support for doing ajax stuff in Kwiki.
*/

// This lets various code bases add onload functions to a queue.
var onload_functions = new Array()

function push_onload_function(func) {
    onload_functions.push(func)
}

window.onload = function() {
    while (func = onload_functions.shift())
        func()
}

// Debugging stuff
function XXX(o) { 
    DumperPopup(o) 
}
// function XXX() {
//     var win = open('', '', 'width=500,height=500,resizable')
//     var doc = win.document.open()
//     doc.writeln('<html><head><title>XXX</title></head><body><pre>')
//     for (i in arguments) {
//         doc.writeln('---')
//         doc.write(html_escape(arguments[i]))
//         doc.writeln('...')
//     }  
//     doc.writeln('</pre></body></html>')
//     doc.close()
//     win.focus()
// }   
//  
// Object.prototype.XXX = XXX
//         
// function html_escape(string) {    string = string.toString()
//     string = string.replace(/&/g, '&amp;')
//     string = string.replace(/</g, '&lt;')
//     string = string.replace(/>/g, '&gt;')
//     return string
// }

// Kwiki server communication functions
function kwiki_ajax_get_request(url, query_string, callback) {
    var req = new XMLHttpRequest()
    req.open('GET', url + '?' + query_string)
    req.onreadystatechange = function() {
        if (req.readyState == 4 && req.status == 200) {
            callback(req)
        }
    }
    req.send(null)
}

function kwiki_ajax_post_request(url, postdata, callback) {
    var req = new XMLHttpRequest()
    req.open('POST', url)
    req.onreadystatechange = function() {
        if (req.readyState == 4 && req.status == 200) {
            callback(req)
        }
    }
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    req.send(postdata)
}

function replace_element_with_html_string(elem, string) {
    var real_elem = (typeof(elem) == 'string')
    ? document.getElementById(elem)
    : elem; 
    real_elem.innerHTML = string;
}

function replace_element_with_html_from_kwiki_query(elem, query, func) {
    var real_elem = (typeof(elem) == 'string')
    ? document.getElementById(elem)
    : elem; 
    function callback(response) {
        real_elem.innerHTML = response.responseText;
        if (func)
            func();
    }
    kwiki_ajax_get_request("", query, callback);
}

__javascript/xmlhttprequest.js__
/*

Cross-Browser XMLHttpRequest v1.1
=================================

Emulate Gecko 'XMLHttpRequest()' functionality in IE and Opera. Opera requires
the Sun Java Runtime Environment <http://www.java.com/>.

by Andrew Gregory
http://www.scss.com.au/family/andrew/webdesign/xmlhttprequest/

This work is licensed under the Creative Commons Attribution License. To view a
copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send
a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305,
USA.

Not Supported in Opera
----------------------
* user/password authentication
* responseXML data member

Not Fully Supported in Opera
----------------------------
* async requests
* abort()
* getAllResponseHeaders(), getAllResponseHeader(header)

*/
// IE support
if (window.ActiveXObject && !window.XMLHttpRequest) {
  window.XMLHttpRequest = function() {
    return new ActiveXObject((navigator.userAgent.toLowerCase().indexOf('msie 5') != -1) ? 'Microsoft.XMLHTTP' : 'Msxml2.XMLHTTP');
  };
}
// Gecko support
/* ;-) */
// Opera support
if (window.opera && !window.XMLHttpRequest) {
  window.XMLHttpRequest = function() {
    this.readyState = 0; // 0=uninitialized,1=loading,2=loaded,3=interactive,4=complete
    this.status = 0; // HTTP status codes
    this.statusText = '';
    this._headers = [];
    this._aborted = false;
    this._async = true;
    this.abort = function() {
      this._aborted = true;
    };
    this.getAllResponseHeaders = function() {
      return this.getAllResponseHeader('*');
    };
    this.getAllResponseHeader = function(header) {
      var ret = '';
      for (var i = 0; i < this._headers.length; i++) {
        if (header == '*' || this._headers[i].h == header) {
          ret += this._headers[i].h + ': ' + this._headers[i].v + '\n';
        }
      }
      return ret;
    };
    this.setRequestHeader = function(header, value) {
      this._headers[this._headers.length] = {h:header, v:value};
    };
    this.open = function(method, url, async, user, password) {
      this.method = method;
      this.url = url;
      this._async = true;
      this._aborted = false;
      if (arguments.length >= 3) {
        this._async = async;
      }
      if (arguments.length > 3) {
        // user/password support requires a custom Authenticator class
        opera.postError('XMLHttpRequest.open() - user/password not supported');
      }
      this._headers = [];
      this.readyState = 1;
      if (this.onreadystatechange) {
        this.onreadystatechange();
      }
    };
    this.send = function(data) {
      if (!navigator.javaEnabled()) {
        alert("XMLHttpRequest.send() - Java must be installed and enabled.");
        return;
      }
      if (this._async) {
        setTimeout(this._sendasync, 0, this, data);
        // this is not really asynchronous and won't execute until the current
        // execution context ends
      } else {
        this._sendsync(data);
      }
    }
    this._sendasync = function(req, data) {
      if (!req._aborted) {
        req._sendsync(data);
      }
    };
    this._sendsync = function(data) {
      this.readyState = 2;
      if (this.onreadystatechange) {
        this.onreadystatechange();
      }
      // open connection
      var url = new java.net.URL(new java.net.URL(window.location.href), this.url);
      var conn = url.openConnection();
      for (var i = 0; i < this._headers.length; i++) {
        conn.setRequestProperty(this._headers[i].h, this._headers[i].v);
      }
      this._headers = [];
      if (this.method == 'POST') {
        // POST data
        conn.setDoOutput(true);
        var wr = new java.io.OutputStreamWriter(conn.getOutputStream());
        wr.write(data);
        wr.flush();
        wr.close();
      }
      // read response headers
      // NOTE: the getHeaderField() methods always return nulls for me :(
      var gotContentEncoding = false;
      var gotContentLength = false;
      var gotContentType = false;
      var gotDate = false;
      var gotExpiration = false;
      var gotLastModified = false;
      for (var i = 0; ; i++) {
        var hdrName = conn.getHeaderFieldKey(i);
        var hdrValue = conn.getHeaderField(i);
        if (hdrName == null && hdrValue == null) {
          break;
        }
        if (hdrName != null) {
          this._headers[this._headers.length] = {h:hdrName, v:hdrValue};
          switch (hdrName.toLowerCase()) {
            case 'content-encoding': gotContentEncoding = true; break;
            case 'content-length'  : gotContentLength   = true; break;
            case 'content-type'    : gotContentType     = true; break;
            case 'date'            : gotDate            = true; break;
            case 'expires'         : gotExpiration      = true; break;
            case 'last-modified'   : gotLastModified    = true; break;
          }
        }
      }
      // try to fill in any missing header information
      var val;
      val = conn.getContentEncoding();
      if (val != null && !gotContentEncoding) this._headers[this._headers.length] = {h:'Content-encoding', v:val};
      val = conn.getContentLength();
      if (val != -1 && !gotContentLength) this._headers[this._headers.length] = {h:'Content-length', v:val};
      val = conn.getContentType();
      if (val != null && !gotContentType) this._headers[this._headers.length] = {h:'Content-type', v:val};
      val = conn.getDate();
      if (val != 0 && !gotDate) this._headers[this._headers.length] = {h:'Date', v:(new Date(val)).toUTCString()};
      val = conn.getExpiration();
      if (val != 0 && !gotExpiration) this._headers[this._headers.length] = {h:'Expires', v:(new Date(val)).toUTCString()};
      val = conn.getLastModified();
      if (val != 0 && !gotLastModified) this._headers[this._headers.length] = {h:'Last-modified', v:(new Date(val)).toUTCString()};
      // read response data
      var reqdata = '';
      var stream = conn.getInputStream();
      if (stream) {
        var reader = new java.io.BufferedReader(new java.io.InputStreamReader(stream));
        var line;
        while ((line = reader.readLine()) != null) {
          if (this.readyState == 2) {
            this.readyState = 3;
            if (this.onreadystatechange) {
              this.onreadystatechange();
            }
          }
          reqdata += line + '\n';
        }
        reader.close();
        this.status = 200;
        this.statusText = 'OK';
        this.responseText = reqdata;
        this.readyState = 4;
        if (this.onreadystatechange) {
          this.onreadystatechange();
        }
        if (this.onload) {
          this.onload();
        }
      } else {
        // error
        this.status = 404;
        this.statusText = 'Not Found';
        this.responseText = '';
        this.readyState = 4;
        if (this.onreadystatechange) {
          this.onreadystatechange();
        }
        if (this.onerror) {
          this.onerror();
        }
      }
    };
  };
}
// ActiveXObject emulation
if (!window.ActiveXObject && window.XMLHttpRequest) {
  window.ActiveXObject = function(type) {
    switch (type.toLowerCase()) {
      case 'microsoft.xmlhttp':
      case 'msxml2.xmlhttp':
        return new XMLHttpRequest();
    }
    return null;
  };
}
