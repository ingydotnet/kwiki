INGY_PATHS = \
	Class \
	Document \
	Document/AST \
	Document/Emitter \
	IO \
	IO/All \
	JS \
	JS/Foo \
	JS/Test \
	Module \
	Module/Compile \
	Module/Install \
	Module/Install/Admin \
	Module/Make \
	Perl \
	Perldoc \
	Perldoc/Emitter \
	Perldoc/Parser \
	Script \
	Vroom \
	WikiText \
	WikiText/Creole \
	WikiText/HTML \
	WikiText/Sample \
	WikiText/Socialtext \
	WikiText/WikiByte \
	WikiText/Wikrad \
	pQuery \

INGY_LEVEL_1 = \
	JS.pm \
	Perldoc.pm \
	pQuery.pm \
	Vroom.pm \
	WikiByte.pm \
	WikiText.pm \
	XXX.pm \
	YYY.pm \

INGY_LEVEL_2 = \
	Class/Field.pm \
	Document/Parser.pm \
	Document/Receiver.pm \
	Document/Tools.pm \
	IO/All.pm \
	JS/jQuery.pm \
	Module/Compile.pm \
	Module/Optimize.pm \
	Module/Make.pm \
	Perldoc/Base.pm \
	Perldoc/Convert.pm \
	Perldoc/Document.pm \
	Perldoc/Dom.pm \
	Perldoc/Make.pm \
	Perl/Folder.pm \
	pQuery/DOM.pm \
	Script/Hater.pm \
	Vroom/Vroom.pm \
	WikiText/Creole.pm \
	WikiText/Creole.pm \
	WikiText/DokuWiki.pm \
	WikiText/Emitter.pm \
	WikiText/HTML.pm \
	WikiText/Kwiki.pm \
	WikiText/MediaWiki.pm \
	WikiText/MoinMoin.pm \
	WikiText/OddMuse.pm \
	WikiText/Parser.pm \
	WikiText/PBWiki.pm \
	WikiText/Pod.pm \
	WikiText/PurpleWiki.pm \
	WikiText/Receiver.pm \
	WikiText/Sample.pm \
	WikiText/TiddlyWiki.pm \
	WikiText/Trac.pm \
	WikiText/TWiki.pm \
	WikiText/UseMod.pm \
	WikiText/Wifty.pm \
	WikiText/WikiByte.pm \
	WikiText/Wikiwyg.pm \
	WikiText/Socialtext.pm \
	WikiText/Wikrad.pm \

INGY_LEVEL_3 = \
	Document/AST/Tree.pm \
	Document/Emitter/HTML.pm \
	Document/Emitter/Wikibyte.pm \
	IO/All/Base.pm \
	IO/All/DBM.pm \
	IO/All/Dir.pm \
	IO/All/File.pm \
	IO/All/Filesys.pm \
	IO/All/Link.pm \
	IO/All/MLDBM.pm \
	IO/All/Pipe.pm \
	IO/All/Socket.pm \
	IO/All/STDIO.pm \
	IO/All/String.pm \
	IO/All/Temp.pm \
	JS/Foo/Bar.pm \
	JS/Test/Simple.pm \
	Module/Compile/Opt.pm \
	Module/Install/PMC.pm \
	Module/Make/Base.pm \
	Module/Make/Config.pm \
	Module/Make/Maker.pm \
	Module/Install/Perldoc.pm \
	Perldoc/Emitter/HTML.pm \
	Perldoc/Emitter/Pod.pm \
	Perldoc/Parser/Kwid.pm \
	Perldoc/Parser/Perldoc.pm \
	WikiText/Creole/Parser.pm \
	WikiText/HTML/Emitter.pm \
	WikiText/Sample/Parser.pm \
	WikiText/WikiByte/Emitter.pm \
	WikiText/Socialtext/Parser.pm \
	WikiText/Wikrad/Emitter.pm \

INGY_LEVEL_4 = \
	Module/Install/Admin/PMC.pm \

INGY_MODULES = $(INGY_LEVEL_1) $(INGY_LEVEL_2) $(INGY_LEVEL_3) $(INGY_LEVEL_4) 

ingy: $(INGY_PATHS) $(INGY_MODULES)

$(INGY_LEVEL_1):
	ln -fs ../src/ingy/*/lib/$@ $@
$(INGY_LEVEL_2):
	cd dummy; \
	lib=../../src/ingy/*/lib/$@; \
	ln -fs $$lib ../$@;
$(INGY_LEVEL_3):
	cd dummy/dummy; \
	lib=../../../src/ingy/*/lib/$@; \
	ln -fs $$lib ../../$@;
$(INGY_LEVEL_4):
	cd dummy/dummy/dummy; \
	lib=../../../../src/ingy/*/lib/$@; \
	ln -fs $$lib ../../../$@;
