CORE_LEVEL_1 = \
	Kwiki.pod \

CORE_LEVEL_2 = \
	Kwiki/Formatter.pod \
	Kwiki/Hub.pod \

CORE_DOCS = $(CORE_LEVEL_1) $(CORE_LEVEL_2) 

core: $(CORE_PATHS) $(CORE_DOCS)

$(CORE_LEVEL_1):
	link=`perl -e '$$_=shift;s!\.pod$$!!;print' $@`; \
	ln -fs ../../src/core/*/src/doc/$@ $$link;
$(CORE_LEVEL_2):
	lib=../../src/core/*/src/doc/$@; \
        link=`perl -e '$$_=shift;s!/!!g;s!\.pod$$!!;print' $@`; \
	ln -fs $$lib $$link;
