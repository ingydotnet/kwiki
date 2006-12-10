include ../core/modules.mk
include ../plugins/modules.mk

#-------------------------------------------------------------------------------
all: core cpan

$(CORE_PATHS) $(CPAN_PATHS) $(PLUGIN_PATHS) dummy/dummy/dummy/dummy:
	mkdir -p $@

#-------------------------------------------------------------------------------
core: $(CORE_PATHS) $(CORE_MODULES) \
	dummy/dummy/dummy/dummy \

$(CORE_LEVEL_1):
	ln -s ../core/*/lib/$@ $@

$(CORE_LEVEL_2):
	@( \
	cd dummy; \
	lib=../../core/*/lib/$@; \
	ln -fs $$lib ../$@; \
	echo ln -s $$lib $@ \
	)

$(CORE_LEVEL_3):
	@( \
	cd dummy/dummy; \
	lib=../../../core/*/lib/$@; \
	ln -fs $$lib ../../$@; \
	echo ln -s $$lib $@ \
	)

#-------------------------------------------------------------------------------
cpan: $(CPAN_PATHS) $(CPAN_MODULES) \
	dummy/dummy/dummy/dummy 

$(CPAN_LEVEL_1):
	ln -s ../cpan/*/lib/$@ $@

$(CPAN_LEVEL_2):
	@( \
	cd dummy; \
	lib=../../cpan/*/lib/$@; \
	ln -fs $$lib ../$@; \
	echo ln -s $$lib $@ \
	)

$(CPAN_LEVEL_3):
	@( \
	cd dummy/dummy; \
	lib=../../../cpan/*/lib/$@; \
	ln -fs $$lib ../../$@; \
	echo ln -s $$lib $@ \
	)

#-------------------------------------------------------------------------------
plugins: $(PLUGIN_PATHS) $(PLUGIN_MODULES) \
	dummy/dummy/dummy/dummy 

$(PLUGIN_LEVEL_2):
	@( \
	cd dummy; \
	lib=../../plugins/*/*/lib/$@; \
	ln -fs $$lib ../$@; \
	echo ln -s $$lib $@ \
	)

$(PLUGIN_LEVEL_3):
	@( \
	cd dummy/dummy; \
	lib=../../../plugins/*/*/lib/$@; \
	ln -fs $$lib ../../$@; \
	echo ln -s $$lib $@ \
	)

$(PLUGIN_LEVEL_4):
	@( \
	cd dummy/dummy/dummy; \
	lib=../../../../plugins/*/*/lib/$@; \
	ln -fs $$lib ../../../$@; \
	echo ln -s $$lib $@ \
	)

$(PLUGIN_LEVEL_5):
	@( \
	cd dummy/dummy/dummy/dummy; \
	lib=../../../plugins/*/*/lib/$@; \
	ln -fs $$lib ../../$@; \
	echo ln -s $$lib $@ \
	)

#-------------------------------------------------------------------------------
clean:
	ls | grep -v Makefile | xargs rm -rf
