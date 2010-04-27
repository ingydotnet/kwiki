.PHONY: modules.mk

modules.mk:
	find . | \
	grep '\.pm$$' | \
	grep '/lib/' | \
	grep -v '/t/' | \
	grep -v '/JS/' | \
	sort -fd | \
	perl ../../bin/make-make.pl $@ $(TYPE) $(GLOB_LEVEL)
