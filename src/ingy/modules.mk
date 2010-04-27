INGY_PATHS = \
	Class \
	Document \
	Document/AST \
	Document/Emitter \
	IO \
	IO/All \
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
	WikiText \
	WikiText/Creole \
	WikiText/Socialtext \
	WikiText/Wikrad \

INGY_LEVEL_1 = \
	Perldoc.pm \
	WikiByte.pm \

INGY_LEVEL_2 = \
	Class/Field.pm \
	Document/Parser.pm \
	Document/Receiver.pm \
	Document/Tools.pm \
	IO/All.pm \
	Module/Compile.pm \
	Module/Optimize.pm \
	Module/Make.pm \
	Perldoc/Base.pm \
	Perldoc/Convert.pm \
	Perldoc/Document.pm \
	Perldoc/Dom.pm \
	Perldoc/Make.pm \
	Perl/Folder.pm \
	Script/Hater.pm \
	WikiText/Creole.pm \
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
