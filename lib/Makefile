include ../core/modules.mk
include ../cpan/modules.mk

all: core cpan

#-------------------------------------------------------------------------------
core: dummy/dummy $(CORE_PATHS) $(CORE_MODULES)

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
cpan: dummy/dummy $(CPAN_PATHS) $(CPAN_MODULES)

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
$(CORE_PATHS) $(CPAN_PATHS) dummy/dummy:
	mkdir -p $@

#-------------------------------------------------------------------------------
clean:
	ls | grep -v Makefile | xargs rm -rf
