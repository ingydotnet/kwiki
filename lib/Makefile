include ../core/modules.mk

all: core

core: $(CORE_PATHS) $(CORE_MODULES)

$(CORE_LEVEL_1):
	ln -s ../core/*/lib/$@ $@

$(CORE_LEVEL_2): dummy
	@( \
	cd dummy; \
	lib=../../core/*/lib/$@; \
	ln -s $$lib ../$@; \
	echo ln -s $$lib $@ \
	)

$(CORE_LEVEL_3): dummy/dummy
	@( \
	cd dummy/dummy; \
	lib=../../../core/*/lib/$@; \
	ln -s $$lib ../../$@; \
	echo ln -s $$lib $@ \
	)

$(CORE_PATHS) dummy dummy/dummy:
	mkdir -p $@

clean:
	ls | grep -v Makefile | xargs rm -rf
