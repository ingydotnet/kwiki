.PHONY: deps run-files

all: deps run-files

deps: run
	cp -r ../../Test-Simple/lib/Test run/lib/

run:
	mkdir $@

run-files:
	make -C run clean all
