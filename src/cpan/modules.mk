CPAN_PATHS = \
	Algorithm \
	CGI \
	CGI/Session \
	CGI/Session/Driver \
	CGI/Session/ID \
	CGI/Session/Serialize \
	CGI/Session/Test \
	Class \
	Class/Accessor \
	Crypt \
	Date \
	Devel \
	File \
	HTTP/Server \
	HTTP/Server/Simple \
	HTTP/Server/Simple/CGI \
	IO \
	IO/Capture \
	LWPx \
	LWPx/Protocol \
	MIME \
	Module \
	Module/Pluggable \
	Net/OpenID \
	Pod \
	Pod/Simple \
	String \
	Text \
	Text/Microformat \
	Text/Microformat/Element \
	Text/Microformat/Plugin \
	Text/Microformat/Plugin/Parser \
	URI \
	URI/Fetch \
	URI/file \
	URI/urn \

CPAN_LEVEL_1 = \
	URI.pm \

CPAN_LEVEL_2 = \
	Algorithm/DiffOld.pm \
	Algorithm/Diff.pm \
	CGI/Session.pm \
	Class/Accessor.pm \
	Class/Field.pm \
	Crypt/DH.pm \
	Date/Manip.pm \
	File/MMagic.pm \
	IO/Capture.pm \
	LWPx/ParanoidAgent.pm \
	MIME/Type.pm \
	MIME/Types.pm \
	Devel/InnerPackage.pm \
	Module/Pluggable.pm \
	Pod/Escapes.pm \
	Pod/Simple.pm \
	String/Diff.pm \
	Text/Microformat.pm \
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
	URI/Fetch.pm \

CPAN_LEVEL_3 = \
	CGI/Session/Driver.pm \
	CGI/Session/ErrorHandler.pm \
	CGI/Session/Tutorial.pm \
	Class/Accessor/Faster.pm \
	Class/Accessor/Fast.pm \
	HTTP/Server/Simple.pm \
	IO/Capture/Stderr.pm \
	IO/Capture/Stdout.pm \
	IO/Capture/Tie_STDx.pm \
	LWPx/Protocol/http_paranoid.pm \
	LWPx/Protocol/https_paranoid.pm \
	Module/Pluggable/Object.pm \
	Net/OpenID/Association.pm \
	Net/OpenID/ClaimedIdentity.pm \
	Net/OpenID/Consumer.pm \
	Net/OpenID/VerifiedIdentity.pm \
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
	Text/Microformat/Element.pm \
	URI/file/Base.pm \
	URI/file/FAT.pm \
	URI/file/Mac.pm \
	URI/file/OS2.pm \
	URI/file/QNX.pm \
	URI/file/Unix.pm \
	URI/file/Win32.pm \
	URI/urn/isbn.pm \
	URI/urn/oid.pm \
	URI/Fetch/Response.pm \

CPAN_LEVEL_4 = \
	CGI/Session/Driver/db_file.pm \
	CGI/Session/Driver/DBI.pm \
	CGI/Session/Driver/file.pm \
	CGI/Session/Driver/mysql.pm \
	CGI/Session/Driver/postgresql.pm \
	CGI/Session/Driver/sqlite.pm \
	CGI/Session/ID/incr.pm \
	CGI/Session/ID/md5.pm \
	CGI/Session/ID/static.pm \
	CGI/Session/Serialize/default.pm \
	CGI/Session/Serialize/freezethaw.pm \
	CGI/Session/Serialize/json.pm \
	CGI/Session/Serialize/storable.pm \
	CGI/Session/Serialize/yaml.pm \
	CGI/Session/Test/Default.pm \
	HTTP/Server/Simple/CGI.pm \
	HTTP/Server/Simple/Static.pm \
	Text/Microformat/Element/hCal.pm \
	Text/Microformat/Element/hCard.pm \
	Text/Microformat/Element/hGrant.pm \
	Text/Microformat/Element/rel_tag.pm \
	Text/Microformat/Element/URI.pm \
	Text/Microformat/Plugin/Include.pm \

CPAN_LEVEL_5 = \
	HTTP/Server/Simple/CGI/Environment.pm \
	Text/Microformat/Plugin/Parser/HTML.pm \
	Text/Microformat/Plugin/Parser/RSS.pm \
	Text/Microformat/Plugin/Parser/XML.pm \

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
