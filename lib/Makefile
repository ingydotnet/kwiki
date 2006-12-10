include ../core/modules.mk

all: core

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

$(CORE_PATHS) dummy/dummy:
	mkdir -p $@

clean:
	ls | grep -v Makefile | xargs rm -rf
