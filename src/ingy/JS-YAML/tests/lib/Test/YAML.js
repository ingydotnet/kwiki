proto = Test.Base.newSubclass('Test.YAML', 'Test.Base');

proto.init = function() {
    Test.Base.prototype.init.call(this);
    this.block_class = 'Test.YAML.Block';
    this.section_delim = '+++';
}

proto = Test.YAML.Filter.prototype;

proto.eval_dump_js = function(content, block) {
    try {
        var node = eval(content);
    }
    catch(e) {
        throw("Error attempting to eval '" + content + "'");
    }
    return YAML.dump(node);
}

