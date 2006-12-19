.PHONY: modules.mk

modules.mk:
	find . -type f | \
	grep -v '/Kwiki-Kwiki/' | \
	grep '\.pm$$' | \
	grep '/lib/' | \
	grep -v '/t/' | \
	sort -fd | \
	perl ../bin/make-make.pl $(TYPE) $(GLOB_LEVEL) > $@
