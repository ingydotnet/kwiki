package Kwiki::Htaccess;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';

const class_id => 'htaccess';
const class_title => 'Apache htaccess Files';

__DATA__

__.htaccess__
<Files config.yaml>
    Deny from all
</Files>
__config/.htaccess__
Deny from all
__plugin/.htaccess__
Deny from all
__template/.htaccess__
Deny from all
__theme/.htaccess__
Deny from all
__theme/basic/css/.htaccess__
Allow from all
