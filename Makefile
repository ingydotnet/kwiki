all:
	@echo No default target

links:
	$(MAKE) -C lib

clean:
	$(MAKE) -C lib $@
	rm -f config.*

distclean: PURGE clean

PURGE:
	$(MAKE) -C kwiki/sample $@
