CORE_LEVEL_1 = \
	Kwiki.pod \
	Spiffy.pod \
	Spoon.pod \

CORE_LEVEL_2 = \
	Kwiki/Archive.pod \
	Kwiki/Base.pod \
	Kwiki/CGI.pod \
	Kwiki/Command.pod \
	Kwiki/Config.pod \
	Kwiki/Configure.pod \
	Kwiki/ContentObject.pod \
	Kwiki/Cookie.pod \
	Kwiki/CSS.pod \
	Kwiki/Display.pod \
	Kwiki/Edit.pod \
	Kwiki/Files.pod \
	Kwiki/Formatter.pod \
	Kwiki/Hub.pod \
	Kwiki/Icons.pod \
	Kwiki/Installer.pod \
	Kwiki/Javascript.pod \
	Kwiki/Pages.pod \
	Kwiki/Plugin.pod \
	Kwiki/Preferences.pod \
	Kwiki/Registry.pod \
	Kwiki/Status.pod \
	Kwiki/Template.pod \
	Kwiki/Theme.pod \
	Kwiki/Toolbar.pod \
	Kwiki/Users.pod \
	Kwiki/WebFile.pod \
	Kwiki/Widgets.pod \
	Spoon/Base.pod \
	Spoon/CGI.pod \
	Spoon/Command.pod \
	Spoon/Config.pod \
	Spoon/ContentObject.pod \
	Spoon/Cookie.pod \
	Spoon/DataObject.pod \
	Spoon/Formatter.pod \
	Spoon/Hooks.pod \
	Spoon/Hub.pod \
	Spoon/Installer.pod \
	Spoon/MetadataObject.pod \
	Spoon/Plugin.pod \
	Spoon/Registry.pod \
	Spoon/Template.pod \
	Spoon/Utils.pod \

CORE_LEVEL_3 = \
	Kwiki/Template/TT2.pod \
	Kwiki/Theme/Basic.pod \
	Spoon/Template/TT2.pod \

CORE_DOCS = $(CORE_LEVEL_1) $(CORE_LEVEL_2) $(CORE_LEVEL_3) 

core: $(CORE_PATHS) $(CORE_DOCS)

$(CORE_LEVEL_1):
	link=`perl -e '$$_=shift;s!\.pod$$!!;print' $@`; \
	ln -fs ../../src/core/*/src/doc/$@ $$link;
$(CORE_LEVEL_2):
	lib=../../src/core/*/src/doc/$@; \
        link=`perl -e '$$_=shift;s!/!-!g;s!\.pod$$!!;print' $@`; \
	ln -fs $$lib $$link;
$(CORE_LEVEL_3):
	lib=../../src/core/*/src/doc/$@; \
        link=`perl -e '$$_=shift;s!/!-!g;s!\.pod$$!!;print' $@`; \
	ln -fs $$lib $$link;
