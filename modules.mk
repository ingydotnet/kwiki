.PHONY: modules.mk

modules.mk:
	find . -type f | \
	grep -v '/Kwiki-Kwiki/' | \
	grep -v '/jcap/' | \
	grep '\.pm$$' | \
	grep '/lib/' | \
	grep -v '/t/' | \
	sort -f | \
	perl ../bin/make-make.pl $(TYPE) $(GLOB_LEVEL) > $@
