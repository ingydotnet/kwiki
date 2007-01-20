PLUGINS_PATHS = \
	Kwiki \

PLUGINS_LEVEL_2 = \
	Kwiki/Cache.pod \

PLUGINS_DOCS = $(PLUGINS_LEVEL_2) 

plugins: $(PLUGINS_PATHS) $(PLUGINS_DOCS)

$(PLUGINS_LEVEL_2):
	@( \
	cd dummy; \
	lib=../../../src/plugins/*/*/src/doc/$@; \
	echo "ln -fs $$lib $@;"; \
	ln -fs $$lib ../$@; \
	)

