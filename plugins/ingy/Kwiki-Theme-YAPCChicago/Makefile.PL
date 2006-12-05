use inc::Module::Install;

name        'Kwiki-Theme-YAPCChicago';
all_from    'lib/Kwiki/Theme/YAPCChicago.pm';

requires    perl => '5.6.1';
requires    Kwiki => 0.34;

WriteAll;
