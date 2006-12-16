PLUGINS_PATHS = \
	Kwiki \
	Kwiki/Ajax \
	Kwiki/Archive \
	Kwiki/Atom \
	Kwiki/Command \
	Kwiki/DB \
	Kwiki/Edit \
	Kwiki/Formatter \
	Kwiki/Icons \
	Kwiki/Notify \
	Kwiki/Pages \
	Kwiki/Purple \
	Kwiki/SOAP \
	Kwiki/Search \
	Kwiki/Template/TT2 \
	Kwiki/Template/TT2/UTF8 \
	Kwiki/Theme \
	Kwiki/UniUI \
	Kwiki/UserMessage \
	Kwiki/UserName \
	Kwiki/Users \
	Kwiki/Widgets \

PLUGINS_LEVEL_2 = \
	Kwiki/Atom.pm \
	Kwiki/ShellBlocks.pm \
	Kwiki/Backlinks.pm \
	Kwiki/Blog.pm \
	Kwiki/DatedAnnounce.pm \
	Kwiki/FetchRSS.pm \
	Kwiki/Keywords.pm \
	Kwiki/Orphans.pm \
	Kwiki/PageStats.pm \
	Kwiki/PageTemperature.pm \
	Kwiki/PPerl.pm \
	Kwiki/Purple.pm \
	Kwiki/Raw.pm \
	Kwiki/SOAP.pm \
	Kwiki/Technorati.pm \
	Kwiki/Test.pm \
	Kwiki/Trackback.pm \
	Kwiki/WeblogUpdates.pm \
	Kwiki/Yahoo.pm \
	Kwiki/Attachments.pm \
	Kwiki/Ajax.pm \
	Kwiki/AnchorLink.pm \
	Kwiki/AuthorOnlyPageEditing.pm \
	Kwiki/CachedDisplay.pm \
	Kwiki/Comments.pm \
	Kwiki/ConfigBlocks.pm \
	Kwiki/DB.pm \
	Kwiki/Docsite.pm \
	Kwiki/Emoticon.pm \
	Kwiki/HanConvert.pm \
	Kwiki/Infobox.pm \
	Kwiki/Invite.pm \
	Kwiki/LiveSearch.pm \
	Kwiki/Markdown.pm \
	Kwiki/MindMap.pm \
	Kwiki/ModPerl.pm \
	Kwiki/NavigationToolbar.pm \
	Kwiki/Oreo.pm \
	Kwiki/Outline2HTML.pm \
	Kwiki/PageInclude.pm \
	Kwiki/PageTemplate.pm \
	Kwiki/Scode.pm \
	Kwiki/Session.pm \
	Kwiki/SocialMap.pm \
	Kwiki/Textile.pm \
	Kwiki/UserMessage.pm \
	Kwiki/UserPhoto.pm \
	Kwiki/Autoformat.pm \
	Kwiki/Diff.pm \
	Kwiki/ForeignLinkGlyphs.pm \
	Kwiki/GDGraphGenerator.pm \
	Kwiki/VimMode.pm \
	Kwiki/Weather.pm \
	Kwiki/AdSense.pm \
	Kwiki/BreadCrumbs.pm \
	Kwiki/Cache.pm \
	Kwiki/DeletePage.pm \
	Kwiki/Doolittle.pm \
	Kwiki/DoubleClickToEdit.pm \
	Kwiki/Favorites.pm \
	Kwiki/GuestBook.pm \
	Kwiki/HomePagePreference.pm \
	Kwiki/HtmlBlocks.pm \
	Kwiki/NewPage.pm \
	Kwiki/PagePrivacy.pm \
	Kwiki/ParagraphBlocks.pm \
	Kwiki/PerlTidyBlocks.pm \
	Kwiki/PerlTidyModule.pm \
	Kwiki/PodBlocks.pm \
	Kwiki/PoweredBy.pm \
	Kwiki/PreformattedBlocks.pm \
	Kwiki/RecentChanges.pm \
	Kwiki/Revisions.pm \
	Kwiki/Search.pm \
	Kwiki/Sifr.pm \
	Kwiki/Spork.pm \
	Kwiki/TimeZone.pm \
	Kwiki/Transclude.pm \
	Kwiki/UniUI.pm \
	Kwiki/UserName.pm \
	Kwiki/UserPreferences.pm \
	Kwiki/Wikiwyg.pm \
	Kwiki/Zipcode.pm \
	Kwiki/CoolURI.pm \
	Kwiki/DNSBL.pm \
	Kwiki/Spaces.pm \
	Kwiki/URLBlock.pm \
	Kwiki/IRCMode.pm \

PLUGINS_LEVEL_3 = \
	Kwiki/Archive/SVK.pm \
	Kwiki/Atom/Server.pm \
	Kwiki/Edit/SubEtha.pm \
	Kwiki/Theme/HLB.pm \
	Kwiki/Purple/Sequence.pm \
	Kwiki/SOAP/Fortune.pm \
	Kwiki/SOAP/Google.pm \
	Kwiki/Theme/CPB.pm \
	Kwiki/Command/Edit.pm \
	Kwiki/Command/RecentChanges.pm \
	Kwiki/DB/ClassDBI.pm \
	Kwiki/DB/DBI.pm \
	Kwiki/Edit/Scode.pm \
	Kwiki/Search/Plucene.pm \
	Kwiki/Theme/Ajax.pm \
	Kwiki/Theme/ColumnLayout.pm \
	Kwiki/UserMessage/CDBI.pm \
	Kwiki/UserName/Auth.pm \
	Kwiki/Users/Auth.pm \
	Kwiki/Widgets/Links.pm \
	Kwiki/Icons/Gnome.pm \
	Kwiki/Notify/IRC.pm \
	Kwiki/UserName/Remote.pm \
	Kwiki/Users/Remote.pm \
	Kwiki/Ajax/Toolman.pm \
	Kwiki/Archive/Rcs.pm \
	Kwiki/Formatter/Pod.pm \
	Kwiki/Pages/Perldoc.pm \
	Kwiki/Theme/Klassik.pm \
	Kwiki/Theme/Selectable.pm \
	Kwiki/Theme/YAPCChicago.pm \
	Kwiki/UniUI/Theme.pm \
	Kwiki/Theme/Bluepole.pm \

PLUGINS_LEVEL_4 = \
	Kwiki/Template/TT2/UTF8.pm \

PLUGINS_LEVEL_5 = \
	Kwiki/Template/TT2/UTF8/Provider.pm \

PLUGINS_MODULES = $(PLUGINS_LEVEL_2) $(PLUGINS_LEVEL_3) $(PLUGINS_LEVEL_4) $(PLUGINS_LEVEL_5) 

plugins: $(PLUGINS_PATHS) $(PLUGINS_MODULES)

$(PLUGINS_LEVEL_2):
	@( \
	cd dummy; \
	lib=../../plugins/*/*/lib/$@; \
	echo "ln -s $$lib $@;"; \
	ln -fs $$lib ../$@; \
	)

$(PLUGINS_LEVEL_3):
	@( \
	cd dummy/dummy; \
	lib=../../../plugins/*/*/lib/$@; \
	echo "ln -s $$lib $@;"; \
	ln -fs $$lib ../../$@; \
	)

$(PLUGINS_LEVEL_4):
	@( \
	cd dummy/dummy/dummy; \
	lib=../../../../plugins/*/*/lib/$@; \
	echo "ln -s $$lib $@;"; \
	ln -fs $$lib ../../../$@; \
	)

$(PLUGINS_LEVEL_5):
	@( \
	cd dummy/dummy/dummy/dummy; \
	lib=../../../../../plugins/*/*/lib/$@; \
	echo "ln -s $$lib $@;"; \
	ln -fs $$lib ../../../../$@; \
	)

