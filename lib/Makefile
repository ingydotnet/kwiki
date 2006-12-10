include ../core/modules.mk
include ../cpan/modules.mk
include ../plugins/modules.mk

#-------------------------------------------------------------------------------
all: core cpan plugins

$(CORE_PATHS) $(CPAN_PATHS) $(PLUGIN_PATHS) dummy/dummy/dummy/dummy:
	mkdir -p $@

#-------------------------------------------------------------------------------
core: dummy/dummy/dummy/dummy $(CORE_PATHS) $(CORE_MODULES)

$(CORE_LEVEL_1):
	ln -s ../core/*/lib/$@ $@

$(CORE_LEVEL_2):
	@( \
	cd dummy; \
	lib=../../core/*/lib/$@; \
	echo "ln -s $$lib $@"; \
	ln -fs $$lib ../$@; \
	)

$(CORE_LEVEL_3):
	@( \
	cd dummy/dummy; \
	lib=../../../core/*/lib/$@; \
	echo "ln -s $$lib $@"; \
	ln -fs $$lib ../../$@; \
	)

#-------------------------------------------------------------------------------
cpan: dummy/dummy/dummy/dummy $(CPAN_PATHS) $(CPAN_MODULES)

$(CPAN_LEVEL_1):
	ln -s ../cpan/*/lib/$@ $@

$(CPAN_LEVEL_2):
	@( \
	cd dummy; \
	lib=../../cpan/*/lib/$@; \
	echo "ln -s $$lib $@"; \
	ln -fs $$lib ../$@; \
	)

$(CPAN_LEVEL_3):
	@( \
	cd dummy/dummy; \
	lib=../../../cpan/*/lib/$@; \
	echo "ln -s $$lib $@"; \
	ln -fs $$lib ../../$@; \
	)

#-------------------------------------------------------------------------------
plugins: dummy/dummy/dummy/dummy $(PLUGIN_PATHS) $(PLUGIN_MODULES)

$(PLUGIN_LEVEL_2):
	@( \
	cd dummy; \
	lib=../../plugins/*/*/lib/$@; \
	echo "ln -s $$lib $@"; \
	ln -fs $$lib ../$@; \
	)

$(PLUGIN_LEVEL_3):
	@( \
	cd dummy/dummy; \
	lib=../../../plugins/*/*/lib/$@; \
	echo "ln -s $$lib $@"; \
	ln -fs $$lib ../../$@; \
	)

$(PLUGIN_LEVEL_4):
	@( \
	cd dummy/dummy/dummy; \
	lib=../../../../plugins/*/*/lib/$@; \
	echo "ln -s $$lib $@"; \
	ln -fs $$lib ../../../$@; \
	)

$(PLUGIN_LEVEL_5):
	@( \
	cd dummy/dummy/dummy/dummy; \
	lib=../../../../../plugins/*/*/lib/$@; \
	echo "ln -s $$lib $@"; \
	ln -fs $$lib ../../../../$@; \
	)

#-------------------------------------------------------------------------------
clean:
	ls | grep -v Makefile | xargs rm -rf
