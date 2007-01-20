CPAN_PATHS = \
	Date \
	URI \
	URI/file \
	URI/urn \

CPAN_LEVEL_1 = \
	URI.pm \

CPAN_LEVEL_2 = \
	Date/Manip.pm \
	URI/data.pm \
	URI/Escape.pm \
	URI/file.pm \
	URI/_foreign.pm \
	URI/ftp.pm \
	URI/_generic.pm \
	URI/gopher.pm \
	URI/Heuristic.pm \
	URI/http.pm \
	URI/https.pm \
	URI/ldapi.pm \
	URI/_ldap.pm \
	URI/ldap.pm \
	URI/ldaps.pm \
	URI/_login.pm \
	URI/mailto.pm \
	URI/mms.pm \
	URI/news.pm \
	URI/nntp.pm \
	URI/pop.pm \
	URI/QueryParam.pm \
	URI/_query.pm \
	URI/rlogin.pm \
	URI/rsync.pm \
	URI/rtsp.pm \
	URI/rtspu.pm \
	URI/_segment.pm \
	URI/_server.pm \
	URI/sip.pm \
	URI/sips.pm \
	URI/snews.pm \
	URI/Split.pm \
	URI/ssh.pm \
	URI/telnet.pm \
	URI/tn3270.pm \
	URI/URL.pm \
	URI/urn.pm \
	URI/_userpass.pm \
	URI/WithBase.pm \

CPAN_LEVEL_3 = \
	URI/file/Base.pm \
	URI/file/FAT.pm \
	URI/file/Mac.pm \
	URI/file/OS2.pm \
	URI/file/QNX.pm \
	URI/file/Unix.pm \
	URI/file/Win32.pm \
	URI/urn/isbn.pm \
	URI/urn/oid.pm \

CPAN_MODULES = $(CPAN_LEVEL_1) $(CPAN_LEVEL_2) $(CPAN_LEVEL_3) 

cpan: $(CPAN_PATHS) $(CPAN_MODULES)

$(CPAN_LEVEL_1):
	ln -fs ../src/cpan/*/lib/$@ $@
$(CPAN_LEVEL_2):
	cd dummy; \
	lib=../../src/cpan/*/lib/$@; \
	ln -fs $$lib ../$@;
$(CPAN_LEVEL_3):
	cd dummy/dummy; \
	lib=../../../src/cpan/*/lib/$@; \
	ln -fs $$lib ../../$@;
