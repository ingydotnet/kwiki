.PHONY: docs.mk

docs.mk:
	find . | \
	grep '\.pod$$' | \
	grep '/src/doc/' | \
	sort -fd | \
	perl ../../bin/make-make.pl $@ $(TYPE) $(GLOB_LEVEL)
