#
# This Makefile is for developers only.
#
# Read INSTALL for help installing Kwiki.
#

.PHONY: help lib doc

help:
	@cat doc/make.help

lib:
	make -C src
	make -C lib

doc:
	make -C doc/pod
