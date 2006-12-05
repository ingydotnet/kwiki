package Kwiki::Oreo;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

__DATA__
__index.html__
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml11.dtd">

<!-- To Do

- Get theme skin
- Get atom resources
- Grab other js
- Pull in needed css

-->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>...placeholder...</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <script type="text/javascript" src="javascript/oreo.js"></script>
  <link rel="atom" type="atom" href="atom/index.xml" />
</head>
<body></body>
</html>
__javascript/oreo.js__
Oreo = function() {};
proto = Oreo.prototype;

proto.init = function() {
    var self = this;
    this.loadJavascriptClassFiles(
        [
            'HTTP/Request.js'
        ],
        function() { self.start() }
    );
}

proto.start = function() {
    this.getAtomInfo();
}

proto.getAtomInfo = function() {
    var self = this;
    new HTTP.Request(
        {
            uri: 'atom/info.xml',
            method: 'get',
            onComplete: function(trans) { self.processAtomInfo(trans) }
        }
    );
}

proto.processAtomInfo = function(atom) {
    var e = atom.responseXML;
    XXX = e;
}

proto.loadJavascriptClassFiles = function(files, callback) {
    var namespaces = [];
    for (var i = 0; i < files.length; i++) {
        var file = files[i];
        var uri = 'javascript/' + file;
        var script = document.createElement('script');
        script.setAttribute('type', 'text/javascript');
        script.setAttribute('src', uri);
        document.getElementsByTagName('head')[0].appendChild(script);

        var namespace = file.replace(/^(\w+).*$/, '$1');
        namespaces.push(namespace);
    }

    var self = this;
    var interval_id = window.setInterval(
        function() {
            for (var i = 0; i < namespaces.length; i++) {
                var namespace = namespaces[i];
                if (! window[namespace]) return;
            }
            window.clearInterval(interval_id);
            callback();
        },
        50
    );
}

window.onload = function() {
    window.oreo = new Oreo();
    window.oreo.init();
}
