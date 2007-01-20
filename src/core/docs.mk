CORE_PATHS = \
	Kwiki \

CORE_LEVEL_1 = \
	Kwiki.pod \

CORE_LEVEL_2 = \
	Kwiki/Formatter.pod \
	Kwiki/Hub.pod \

CORE_DOCS = $(CORE_LEVEL_1) $(CORE_LEVEL_2) 

core: $(CORE_PATHS) $(CORE_DOCS)

$(CORE_LEVEL_1):
	ln -fs ../../src/core/*/src/doc/$@ $@

$(CORE_LEVEL_2):
	@( \
	cd dummy; \
	lib=../../../src/core/*/src/doc/$@; \
	echo "ln -fs $$lib $@;"; \
	ln -fs $$lib ../$@; \
	)

