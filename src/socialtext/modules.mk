SOCIALTEXT_PATHS = \
	Socialtext \
	Socialtext/Formatter \

SOCIALTEXT_LEVEL_2 = \
	Socialtext/Formatter.pm \

SOCIALTEXT_LEVEL_3 = \
	Socialtext/Formatter/AbsoluteLinkDictionary.pm \
	Socialtext/Formatter/Block.pm \
	Socialtext/Formatter/LinkDictionary.pm \
	Socialtext/Formatter/LiteLinkDictionary.pm \
	Socialtext/Formatter/Parser.pm \
	Socialtext/Formatter/Phrase.pm \
	Socialtext/Formatter/RailsDemoLinkDictionary.pm \
	Socialtext/Formatter/RESTLinkDictionary.pm \
	Socialtext/Formatter/SharepointLinkDictionary.pm \
	Socialtext/Formatter/Unit.pm \
	Socialtext/Formatter/Viewer.pm \
	Socialtext/Formatter/WaflBlock.pm \
	Socialtext/Formatter/WaflPhrase.pm \
	Socialtext/Formatter/Wafl.pm \

SOCIALTEXT_MODULES = $(SOCIALTEXT_LEVEL_2) $(SOCIALTEXT_LEVEL_3) 

socialtext: $(SOCIALTEXT_PATHS) $(SOCIALTEXT_MODULES)

$(SOCIALTEXT_LEVEL_2):
	cd dummy; \
	lib=../../src/socialtext/*/lib/$@; \
	ln -fs $$lib ../$@;
$(SOCIALTEXT_LEVEL_3):
	cd dummy/dummy; \
	lib=../../../src/socialtext/*/lib/$@; \
	ln -fs $$lib ../../$@;
