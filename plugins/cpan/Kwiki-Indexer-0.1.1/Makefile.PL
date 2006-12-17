use inc::Module::Install;

name('Kwiki-Indexer');
abstract('Kwiki Indexer class.');
author('Russell Heilling <chewtoy@s8n.net');
version('0.1.1');
license('perl');
requires( qw(perl 5.6.0
	     Kwiki 0.32
	     ) );

&WriteAll;
