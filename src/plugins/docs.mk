PLUGINS_LEVEL_2 = \
	Kwiki/Cache.pod \

PLUGINS_DOCS = $(PLUGINS_LEVEL_2) 

plugins: $(PLUGINS_PATHS) $(PLUGINS_DOCS)

$(PLUGINS_LEVEL_2):
	lib=../../src/plugins/*/*/src/doc/$@; \
        link=`perl -e '$$_=shift;s!/!-!g;s!\.pod$$!!;print' $@`; \
	ln -fs $$lib $$link;
