CPAN_PATHS = \
	URI URI/file URI/urn \

CPAN_LEVEL_1 = \
	URI.pm \

CPAN_LEVEL_2 = \
	URI/_foreign.pm URI/_generic.pm URI/_ldap.pm URI/_login.pm URI/_query.pm URI/_segment.pm URI/_server.pm URI/_userpass.pm URI/data.pm URI/Escape.pm URI/file.pm URI/ftp.pm URI/gopher.pm URI/Heuristic.pm URI/http.pm URI/https.pm URI/ldap.pm URI/ldapi.pm URI/ldaps.pm URI/mailto.pm URI/mms.pm URI/news.pm URI/nntp.pm URI/pop.pm URI/QueryParam.pm URI/rlogin.pm URI/rsync.pm URI/rtsp.pm URI/rtspu.pm URI/sip.pm URI/sips.pm URI/snews.pm URI/Split.pm URI/ssh.pm URI/telnet.pm URI/tn3270.pm URI/URL.pm URI/urn.pm URI/WithBase.pm \

CPAN_LEVEL_3 = \
	URI/file/Base.pm URI/file/FAT.pm URI/file/Mac.pm URI/file/OS2.pm URI/file/QNX.pm URI/file/Unix.pm URI/file/Win32.pm \

CPAN_MODULES = $(CPAN_LEVEL_1) $(CPAN_LEVEL_2) $(CPAN_LEVEL_3)
