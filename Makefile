all:
	@echo No default target

clean:
	$(MAKE) -C lib clean
	rm -f config.*
