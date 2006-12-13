all:
	@echo No default target

links:
	$(MAKE) -C lib all

clean:
	$(MAKE) -C lib $@
	rm -f config.*
