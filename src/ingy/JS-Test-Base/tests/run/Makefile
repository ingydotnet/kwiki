.PHONY: all clean

ALL_T_HTML:=$(shell ls -1 ../*.t.js | perl -pe 's/js$$/html/;s/^\.\.\///')

ALL_TARGETS:=$(ALL_T_HTML) index.html

all: $(ALL_TARGETS)

%.t.html: template/test.html
	perl bin/render-template $< $@

index.html: template/index.html ../*.t.js
	perl bin/render-template $< $@

clean:
	rm -fr $(ALL_TARGETS)

html:
	mkdir html
