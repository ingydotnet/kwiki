#
# This Makefile is for developers only.
#
# Read INSTALL for help installing Kwiki.
#

.PHONY: help all_links

help:
	@cat doc/make.help

all_links:
	make -C src
	make -C lib
	#make -C doc/pod
