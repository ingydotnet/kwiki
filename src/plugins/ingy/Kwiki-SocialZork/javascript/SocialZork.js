var $ = function(id) {
    return document.getElementById(id);
}

var Zork = function() {};
var _ = Zork.prototype;

_.glyphs = {
    N: '▲',
    S: '▼',
    E: '▶',
    W: '◀',
    NW: '◤',
    NE: '◥',
    SW: '◣',
    SE: '◢',
    luck: 'Ω',
    retreat: '↩',
    navigate: '⎈',
    //edit: '',
    edit: ' ',
    dot: '•',
    bad_apple: '',
    star: '★',
    cloud: '☁',
    snowman: '☃',
    yinyang: '☯',
    happy: '☺',
    sad: '☹',
    hotspring: '♨',
};

_.spinner_glyphs = [
    'dot', 'bad_apple', 'happy', 'sad', 'cloud', 'star',
    'snowman', 'hotspring',
];

_.all_positions = [
    'a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9',
    'b9', 'c9', 'd9', 'e9', 'f9',
    'g9', 'g8', 'g7', 'g6', 'g5', 'g4', 'g3', 'g2', 'g1',
    'f1', 'e1', 'd1', 'c1', 'b1'
];

_.control_positions = {
    N: 'a5',
    S: 'g5',
    W: 'd1',
    E: 'd9',
    NW: 'a1',
    NE: 'a9',
    SW: 'g1',
    SE: 'g9',
    luck: 'g3',
    retreat: 'b1',
    edit: 'g8',
}

_.set_controls = function(controls) {
    for (var control in controls) {
        this.set_control(control, controls[control]);
    }
    this.set_control('edit');
}

_.set_control = function(control, args) {
    var box = $('theme_' + this.control_positions[control]);
    box.innerHTML =
        '<a>' +
        this.glyphs[control] +
        '</a>';
    var self = this;
    box.onclick = function() {
        self.handle_click(control, args);
    };
}

_.handle_click = function(command, args) {
    if (command == 'edit') {
        this.edit_page();
    }
    else {
        this.goto_page(args);
    }
}

function XXX(args) {
    if (! confirm(args))
        throw("terminated...");
    return args;
}

function JJJ(args) {
    return XXX(JSON.stringify(args));
}

_.clear_controls = function() {
    var positions = this.all_positions;
    for (var ii = 0; ii < positions.length; ii++) {
        var box = $('theme_' + positions[ii]);
        box.innerHTML = '';
    }
}

_.start_spinner = function() {
    var position = 0;
    var self = this;

    var index = Math.floor(Math.random() * this.spinner_glyphs.length);
    var glyph = this.glyphs[this.spinner_glyphs[index]];
    var spinner = function() {
        var box1 = $('theme_' + self.all_positions[position]);
        if (++position >= self.all_positions.length)
            position = 0;
        var box2 = $('theme_' + self.all_positions[position]);
        box1.innerHTML = '';
        box2.innerHTML = glyph;
    }
    this.interval_id = setInterval(spinner, 33);
}

_.stop_spinner = function() {
    clearInterval(this.interval_id);
    this.interval_id = null;
    this.clear_controls();
}

_.edit_page = function() {
    this.clear_controls();
    this.start_spinner();
    var url = 'index.cgi?action=get_text;page_nid=' + this.current_page;

    var self = this;
    var callback = function(text) {
        self.stop_spinner();
        $('zork_content_div').innerHTML = 
            '<form>' +
            '<a href="#" id="zork_save_button">Save</a>&nbsp;' +
            '<a href="#" id="zork_cancel_button">Cancel</a><br />' +
            '<textarea id="zork_edit_area">' + text +
            '</textarea></form>';
        $('zork_save_button').onclick = function() {
            self.save_page();
        }
        $('zork_cancel_button').onclick = function() {
            self.cancel_edit();
        }
    }
    Ajax.get(url, callback);
}

_.save_page = function() {
    this.clear_controls();
    this.start_spinner();
    var url = 'index.cgi';
    var postdata =
        'action=save_text;page_nid=' +
        this.current_page +
        ';content=' + encodeURIComponent($('zork_edit_area').value);

    var self = this;
    var callback = function(text) {
        if (text.match(/not ok/)) {
            alert(text);
        }
        self.load_page(self.current_page);
    }
    Ajax.post(url, postdata, callback);
}

_.cancel_edit = function() {
    this.clear_controls();
    this.start_spinner();
    this.load_page(this.current_page);
}

_.goto_page = function(page_id) {
    this.clear_controls();
    this.start_spinner();
    this.load_page(page_id);
}

_.kill_links = function(pane) {
    var links = pane.getElementsByTagName('a');
    for (var i = 0; i < links.length; i++) {
        var link = links[i];
        var href = link.getAttribute('href');
        if (href) {
            link.setAttribute('href', '#');
        }
        href = link.getAttribute('target');
        if (href) {
            link.removeAttribute('target');
        }
    }
}

_.load_page = function(page_id) {
    this.current_page = page_id;
    var self = this;
    var page_loaded = function(json) {
        document.title = page_id;
        var data = JSON.parse(json);
        var pane = $('zork_content_div');
        if (data.socialtext_html) {
            pane.innerHTML = data.socialtext_html;
            self.kill_links(pane);
        }
        else if (data.local_html) {
            pane.innerHTML = data.local_html;
            self.kill_links(pane);
        }
        else {
            pane.innerHTML = 'This page is currently empty...';
        }
        if (self.interval_id) {
            self.stop_spinner();
        }
        self.clear_controls();
        if (data.controls) {
            self.controls = data.controls;
            self.set_controls(data.controls);
        }
    }
    Ajax.get(
        'index.cgi?action=load_page;page_nid=' + page_id,
        page_loaded
    );
}

window.onload = function() {
    var zork = new Zork();
    zork.load_page(zork_current_page_id);
}
