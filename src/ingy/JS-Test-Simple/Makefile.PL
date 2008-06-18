use inc::Module::Install;

name     'JS-Test-Simple';
version  '0.23';
# license_  'lgpl';
all_from 'doc/pod/Test/Simple.pod';

requires 'JS';

WriteAll;
