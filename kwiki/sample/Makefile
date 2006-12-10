include ../../config.mk
KWIKI = $(KWIKI_BASE)/bin/kwiki

all: lib new update

lib: $(KWIKI_BASE)/lib
	ln -s $(KWIKI_BASE)/lib

new:
	$(PERL) $(KWIKI) -new

update:
	$(PERL) $(KWIKI) -update

$(KWIKI_BASE)/lib:
	$(MAKE) -C $@

clean:
	ls | grep -v Makefile | grep -v README | xargs rm -fr
