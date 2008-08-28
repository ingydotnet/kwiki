var t = new Test.YAML();

var filters = {
    javascript: 'eval',
};

t.plan(5);
t.filters(filters);
t.run_is('javascript', 'yaml');

/* Test
=== Simple hash with one entry
+++ javascript
YAML.dump('hello', 42, null);
+++ yaml
--- hello
--- 42
--- ~

*/
