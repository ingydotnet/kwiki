CPAN_PATHS = \
	Algorithm \
	Class \
	Date \
	File \
	HTTP/Server \
	HTTP/Server/Simple \
	HTTP/Server/Simple/CGI \
	IO \
	IO/Capture \
	Pod \
	Pod/Simple \
	String \
	URI \
	URI/file \
	URI/urn \

CPAN_LEVEL_1 = \
	URI.pm \
	XXX.pm \

CPAN_LEVEL_2 = \
	Algorithm/DiffOld.pm \
	Algorithm/Diff.pm \
	Class/Field.pm \
	Date/Manip.pm \
	File/MMagic.pm \
	IO/Capture.pm \
	Pod/Escapes.pm \
	Pod/Simple.pm \
	String/Diff.pm \
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
	HTTP/Server/Simple.pm \
	IO/Capture/Stderr.pm \
	IO/Capture/Stdout.pm \
	IO/Capture/Tie_STDx.pm \
	Pod/Simple/BlackBox.pm \
	Pod/Simple/Checker.pm \
	Pod/Simple/Debug.pm \
	Pod/Simple/DumpAsText.pm \
	Pod/Simple/DumpAsXML.pm \
	Pod/Simple/HTMLBatch.pm \
	Pod/Simple/HTMLLegacy.pm \
	Pod/Simple/HTML.pm \
	Pod/Simple/LinkSection.pm \
	Pod/Simple/Methody.pm \
	Pod/Simple/Progress.pm \
	Pod/Simple/PullParserEndToken.pm \
	Pod/Simple/PullParser.pm \
	Pod/Simple/PullParserStartToken.pm \
	Pod/Simple/PullParserTextToken.pm \
	Pod/Simple/PullParserToken.pm \
	Pod/Simple/RTF.pm \
	Pod/Simple/Search.pm \
	Pod/Simple/SimpleTree.pm \
	Pod/Simple/TextContent.pm \
	Pod/Simple/Text.pm \
	Pod/Simple/TiedOutFH.pm \
	Pod/Simple/TranscodeDumb.pm \
	Pod/Simple/Transcode.pm \
	Pod/Simple/TranscodeSmart.pm \
	Pod/Simple/XMLOutStream.pm \
	URI/file/Base.pm \
	URI/file/FAT.pm \
	URI/file/Mac.pm \
	URI/file/OS2.pm \
	URI/file/QNX.pm \
	URI/file/Unix.pm \
	URI/file/Win32.pm \
	URI/urn/isbn.pm \
	URI/urn/oid.pm \

CPAN_LEVEL_4 = \
	HTTP/Server/Simple/CGI.pm \
	HTTP/Server/Simple/Static.pm \

CPAN_LEVEL_5 = \
	HTTP/Server/Simple/CGI/Environment.pm \

CPAN_MODULES = $(CPAN_LEVEL_1) $(CPAN_LEVEL_2) $(CPAN_LEVEL_3) $(CPAN_LEVEL_4) $(CPAN_LEVEL_5) 

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
$(CPAN_LEVEL_4):
	cd dummy/dummy/dummy; \
	lib=../../../../src/cpan/*/lib/$@; \
	ln -fs $$lib ../../../$@;
$(CPAN_LEVEL_5):
	cd dummy/dummy/dummy/dummy; \
	lib=../../../../../src/cpan/*/lib/$@; \
	ln -fs $$lib ../../../../$@;
