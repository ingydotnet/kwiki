use inc::Module::Install;

name('Kwiki-Indexer-Swish');
abstract('Kwiki Plugin index and search a Kwiki using swish-e');
author('Russell Heilling <chewtoy@s8n.net');
version('0.1.1');
license('perl');
requires( qw(perl 5.6.0
	     Kwiki 0.32
	     Kwiki::Indexer 0.1.0
             SWISH::API 0.01) );

&WriteAll;
