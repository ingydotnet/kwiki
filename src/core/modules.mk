CORE_PATHS = \
	Kwiki \
	Kwiki/Archive \
	Kwiki/Boot \
	Kwiki/Command \
	Kwiki/Files \
	Kwiki/Formatter \
	Kwiki/Paths \
	Kwiki/Theme \
	Spiffy \
	Spoon \
	Spoon/Boot \
	Spork \
	Spork/Boot \
	Spork/Config \
	Spork/Emitter \
	Spork/Formatter \
	Spork/Template \
	Template \
	Template/Namespace \
	Template/Plugin \
	Template/Plugin/GD \
	Template/Plugin/GD/Graph \
	Template/Plugin/GD/Text \
	Template/Plugin/XML \
	Template/Stash \

CORE_LEVEL_1 = \
	Kwiki.pm \
	Spiffy.pm \
	Spoon.pm \
	Spork.pm \
	Template.pm \

CORE_LEVEL_2 = \
	Kwiki/Archive.pm \
	Kwiki/Base.pm \
	Kwiki/Boot.pm \
	Kwiki/BrowserDetect.pm \
	Kwiki/CGI.pm \
	Kwiki/Config.pm \
	Kwiki/Configure.pm \
	Kwiki/ContentObject.pm \
	Kwiki/Cookie.pm \
	Kwiki/CSS.pm \
	Kwiki/Display.pm \
	Kwiki/Edit.pm \
	Kwiki/Formatter.pm \
	Kwiki/Hub.pm \
	Kwiki/Icons.pm \
	Kwiki/Images.pm \
	Kwiki/Installer.pm \
	Kwiki/Javascript.pm \
	Kwiki/Pages.pm \
	Kwiki/Pane.pm \
	Kwiki/Plugin.pm \
	Kwiki/Preferences.pm \
	Kwiki/Registry.pm \
	Kwiki/Status.pm \
	Kwiki/Theme.pm \
	Kwiki/Toolbar.pm \
	Kwiki/Users.pm \
	Kwiki/WebFile.pm \
	Kwiki/Widgets.pm \
	Spiffy/mixin.pm \
	Spoon/Base.pm \
	Spoon/CGI.pm \
	Spoon/Command.pm \
	Spoon/Config.pm \
	Spoon/ContentObject.pm \
	Spoon/Cookie.pm \
	Spoon/DataObject.pm \
	Spoon/Formatter.pm \
	Spoon/Headers.pm \
	Spoon/Hooks.pm \
	Spoon/Hub.pm \
	Spoon/IndexList.pm \
	Spoon/Installer.pm \
	Spoon/MetadataObject.pm \
	Spoon/Paths.pm \
	Spoon/Plugin.pm \
	Spoon/Registry.pm \
	Spoon/Template.pm \
	Spoon/Trace.pm \
	Spoon/Utils.pm \
	Spork/Boot.pm \
	Spork/Command.pm \
	Spork/Config.pm \
	Spork/Formatter2.pm \
	Spork/Formatter.pm \
	Spork/Hub.pm \
	Spork/Parser.pm \
	Spork/Paths.pm \
	Spork/Plugin.pm \
	Spork/Registry.pm \
	Spork/Slides.pm \
	Template/Base.pm \
	Template/Config.pm \
	Template/Constants.pm \
	Template/Context.pm \
	Template/Directive.pm \
	Template/Document.pm \
	Template/Exception.pm \
	Template/Filters.pm \
	Template/Grammar.pm \
	Template/Iterator.pm \
	Template/Parser.pm \
	Template/Plugin.pm \
	Template/Plugins.pm \
	Template/Provider.pm \
	Template/Service.pm \
	Template/Stash.pm \
	Template/Test.pm \
	Template/View.pm \
	Template/VMethods.pm \

CORE_LEVEL_3 = \
	Kwiki/Archive/Simple.pm \
	Kwiki/Boot/V1.pm \
	Kwiki/Boot/V2.pm \
	Kwiki/Boot/V3.pm \
	Kwiki/Command/Base.pm \
	Kwiki/Command/V1.pm \
	Kwiki/Command/V2.pm \
	Kwiki/Files/V1.pm \
	Kwiki/Files/V2.pm \
	Kwiki/Formatter/V3.pm \
	Kwiki/Paths/V1.pm \
	Kwiki/Paths/V2.pm \
	Kwiki/Theme/Basic.pm \
	Spoon/Boot/Base.pm \
	Spork/Boot/V1.pm \
	Spork/Config/Default.pm \
	Spork/Emitter/HTML.pm \
	Spork/Formatter/Autringy.pm \
	Spork/Template/TT2.pm \
	Template/Namespace/Constants.pm \
	Template/Plugin/Autoformat.pm \
	Template/Plugin/CGI.pm \
	Template/Plugin/Datafile.pm \
	Template/Plugin/Date.pm \
	Template/Plugin/DBI.pm \
	Template/Plugin/Directory.pm \
	Template/Plugin/Dumper.pm \
	Template/Plugin/File.pm \
	Template/Plugin/Filter.pm \
	Template/Plugin/Format.pm \
	Template/Plugin/HTML.pm \
	Template/Plugin/Image.pm \
	Template/Plugin/Iterator.pm \
	Template/Plugin/Pod.pm \
	Template/Plugin/Procedural.pm \
	Template/Plugin/String.pm \
	Template/Plugin/Table.pm \
	Template/Plugin/URL.pm \
	Template/Plugin/View.pm \
	Template/Plugin/Wrap.pm \
	Template/Stash/Context.pm \
	Template/Stash/XS.pm \

CORE_LEVEL_4 = \
	Template/Plugin/GD/Constants.pm \
	Template/Plugin/GD/Image.pm \
	Template/Plugin/GD/Polygon.pm \
	Template/Plugin/GD/Text.pm \
	Template/Plugin/XML/DOM.pm \
	Template/Plugin/XML/RSS.pm \
	Template/Plugin/XML/Simple.pm \
	Template/Plugin/XML/Style.pm \
	Template/Plugin/XML/XPath.pm \

CORE_LEVEL_5 = \
	Template/Plugin/GD/Graph/area.pm \
	Template/Plugin/GD/Graph/bars3d.pm \
	Template/Plugin/GD/Graph/bars.pm \
	Template/Plugin/GD/Graph/lines3d.pm \
	Template/Plugin/GD/Graph/lines.pm \
	Template/Plugin/GD/Graph/linespoints.pm \
	Template/Plugin/GD/Graph/mixed.pm \
	Template/Plugin/GD/Graph/pie3d.pm \
	Template/Plugin/GD/Graph/pie.pm \
	Template/Plugin/GD/Graph/points.pm \
	Template/Plugin/GD/Text/Align.pm \
	Template/Plugin/GD/Text/Wrap.pm \

CORE_MODULES = $(CORE_LEVEL_1) $(CORE_LEVEL_2) $(CORE_LEVEL_3) $(CORE_LEVEL_4) $(CORE_LEVEL_5) 

core: $(CORE_PATHS) $(CORE_MODULES)

$(CORE_LEVEL_1):
	ln -fs ../src/core/*/lib/$@ $@
$(CORE_LEVEL_2):
	cd dummy; \
	lib=../../src/core/*/lib/$@; \
	ln -fs $$lib ../$@;
$(CORE_LEVEL_3):
	cd dummy/dummy; \
	lib=../../../src/core/*/lib/$@; \
	ln -fs $$lib ../../$@;
$(CORE_LEVEL_4):
	cd dummy/dummy/dummy; \
	lib=../../../../src/core/*/lib/$@; \
	ln -fs $$lib ../../../$@;
$(CORE_LEVEL_5):
	cd dummy/dummy/dummy/dummy; \
	lib=../../../../../src/core/*/lib/$@; \
	ln -fs $$lib ../../../../$@;
