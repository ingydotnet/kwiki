.PHONY: all clean

SOURCE=pod/Subclass.pod

all: html/Subclass.html text/Subclass.text

html/Subclass.html: $(SOURCE) html
	pod2html $< > $@
	rm pod2htm*.tmp

text/Subclass.text: $(SOURCE) text
	pod2text $< > $@

html text:
	mkdir -p $@

clean:
	rm -fr html text
