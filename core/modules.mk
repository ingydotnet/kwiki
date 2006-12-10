CORE_PATHS = \
	IO IO/All \
	Kwiki Kwiki/Archive Kwiki/Template Kwiki/Theme \
	Script \
	Spiffy \
	Spoon Spoon/Template \
	Template/Namespace Template/Plugin Template/Stash \
	YAML YAML/Loader YAML/Dumper \

CORE_LEVEL_1 = \
	Kwiki.pm \
	Spiffy.pm \
	Spoon.pm \
	Template.pm \
	YAML.pm \

CORE_LEVEL_2 = \
	IO/All.pm \
	Kwiki/Archive.pm Kwiki/Base.pm Kwiki/BrowserDetect.pm Kwiki/CGI.pm \
	Kwiki/Command.pm Kwiki/Config.pm Kwiki/ContentObject.pm \
	Kwiki/Cookie.pm Kwiki/CSS.pm Kwiki/Display.pm Kwiki/Edit.pm \
	Kwiki/Files.pm Kwiki/Formatter.pm Kwiki/Hub.pm Kwiki/Icons.pm \
	Kwiki/Installer.pm Kwiki/Javascript.pm Kwiki/Pages.pm \
	Kwiki/Pane.pm Kwiki/Plugin.pm Kwiki/Preferences.pm \
	Kwiki/Registry.pm Kwiki/Status.pm Kwiki/Template.pm Kwiki/Theme.pm \
	Kwiki/Toolbar.pm Kwiki/Users.pm Kwiki/WebFile.pm Kwiki/Widgets.pm \
	Script/Hater.pm \
	Spoon/Base.pm Spoon/CGI.pm Spoon/Command.pm Spoon/Config.pm \
	Spoon/ContentObject.pm Spoon/Cookie.pm Spoon/DataObject.pm \
	Spoon/Formatter.pm Spoon/Headers.pm Spoon/Hooks.pm Spoon/Hub.pm \
	Spoon/IndexList.pm Spoon/Installer.pm Spoon/MetadataObject.pm \
	Spoon/Plugin.pm Spoon/Registry.pm Spoon/Template.pm Spoon/Trace.pm \
	Spoon/Utils.pm \
	Spiffy/mixin.pm \
	Template/Base.pm Template/Config.pm Template/Constants.pm \
	Template/Context.pm Template/Directive.pm Template/Document.pm \
	Template/Exception.pm Template/Filters.pm Template/Grammar.pm \
	Template/Iterator.pm Template/Parser.pm Template/Plugin.pm \
	Template/Plugins.pm Template/Provider.pm Template/Service.pm \
	Template/Stash.pm Template/Test.pm Template/View.pm \
	YAML/Base.pm YAML/Dumper.pm YAML/Error.pm YAML/Loader.pm \
	YAML/Marshall.pm YAML/Node.pm YAML/Tag.pm YAML/Types.pm \

CORE_LEVEL_3 = \
	IO/All/Base.pm IO/All/DBM.pm IO/All/Dir.pm IO/All/File.pm \
	IO/All/Filesys.pm IO/All/Link.pm IO/All/MLDBM.pm IO/All/Pipe.pm \
	IO/All/Socket.pm IO/All/STDIO.pm IO/All/String.pm IO/All/Temp.pm \
	Kwiki/Archive/Simple.pm Kwiki/Template/TT2.pm Kwiki/Theme/Basic.pm \
	Spoon/Template/TT2.pm \
	Template/Namespace/Constants.pm Template/Plugin/Autoformat.pm \
	Template/Plugin/CGI.pm Template/Plugin/Datafile.pm \
	Template/Plugin/Date.pm Template/Plugin/DBI.pm \
	Template/Plugin/Directory.pm Template/Plugin/Dumper.pm \
	Template/Plugin/File.pm Template/Plugin/Filter.pm \
	Template/Plugin/Format.pm Template/Plugin/HTML.pm \
	Template/Plugin/Image.pm Template/Plugin/Iterator.pm \
	Template/Plugin/Pod.pm Template/Plugin/Procedural.pm \
	Template/Plugin/String.pm Template/Plugin/Table.pm \
	Template/Plugin/URL.pm Template/Plugin/View.pm \
	Template/Plugin/Wrap.pm Template/Stash/Context.pm \
	Template/Stash/XS.pm \
	YAML/Dumper/Base.pm YAML/Loader/Base.pm \

CORE_MODULES = $(CORE_LEVEL_1) $(CORE_LEVEL_2) $(CORE_LEVEL_3)
