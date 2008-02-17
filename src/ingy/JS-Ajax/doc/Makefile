.PHONY: all clean

SOURCE=pod/Ajax.pod

all: html/Ajax.html text/Ajax.text

html/Ajax.html: $(SOURCE) html
	pod2html $< > $@
	rm pod2htm*.tmp

text/Ajax.text: $(SOURCE) text
	pod2text $< > $@

html text:
	mkdir -p $@

clean:
	rm -fr html text
