CORE_PATHS = \
	Kwiki Kwiki/Archive Kwiki/Template Kwiki/Theme \
	Spoon Spoon/Template \
	Spiffy \
	YAML YAML/Loader YAML/Dumper \
	IO IO/All \
	Script \

CORE_LEVEL_1 = \
	Kwiki.pm \
	Spoon.pm \
	Spiffy.pm \
	YAML.pm \

CORE_LEVEL_2 = \
	Kwiki/Archive.pm Kwiki/Base.pm Kwiki/BrowserDetect.pm Kwiki/CGI.pm \
	Kwiki/Command.pm Kwiki/Config.pm Kwiki/ContentObject.pm \
	Kwiki/Cookie.pm Kwiki/CSS.pm Kwiki/Display.pm Kwiki/Edit.pm \
	Kwiki/Files.pm Kwiki/Formatter.pm Kwiki/Hub.pm Kwiki/Icons.pm \
	Kwiki/Installer.pm Kwiki/Javascript.pm Kwiki/Pages.pm \
	Kwiki/Pane.pm Kwiki/Plugin.pm Kwiki/Preferences.pm \
	Kwiki/Registry.pm Kwiki/Status.pm Kwiki/Template.pm Kwiki/Theme.pm \
	Kwiki/Toolbar.pm Kwiki/Users.pm Kwiki/WebFile.pm Kwiki/Widgets.pm \
	Spoon/Base.pm Spoon/CGI.pm Spoon/Command.pm Spoon/Config.pm \
	Spoon/ContentObject.pm Spoon/Cookie.pm Spoon/DataObject.pm \
	Spoon/Formatter.pm Spoon/Headers.pm Spoon/Hooks.pm Spoon/Hub.pm \
	Spoon/IndexList.pm Spoon/Installer.pm Spoon/MetadataObject.pm \
	Spoon/Plugin.pm Spoon/Registry.pm Spoon/Template.pm Spoon/Trace.pm \
	Spoon/Utils.pm \
	Spiffy/mixin.pm \
	YAML/Base.pm YAML/Dumper.pm YAML/Error.pm YAML/Loader.pm \
	YAML/Marshall.pm YAML/Node.pm YAML/Tag.pm YAML/Types.pm \
	IO/All.pm \
	Script/Hater.pm \

CORE_LEVEL_3 = \
	Kwiki/Archive/Simple.pm Kwiki/Template/TT2.pm Kwiki/Theme/Basic.pm \
	Spoon/Template/TT2.pm \
	YAML/Dumper/Base.pm YAML/Loader/Base.pm \
	IO/All/Base.pm IO/All/DBM.pm IO/All/Dir.pm IO/All/File.pm \
	IO/All/Filesys.pm IO/All/Link.pm IO/All/MLDBM.pm IO/All/Pipe.pm \
	IO/All/Socket.pm IO/All/STDIO.pm IO/All/String.pm IO/All/Temp.pm \

CORE_MODULES = $(CORE_LEVEL_1) $(CORE_LEVEL_2) $(CORE_LEVEL_3)

