package Kwiki::Theme::OSCON2008;
use Kwiki::Theme -Base;
our $VERSION = '0.01';

const theme_id => 'oscon2008';
const class_title => 'OSCON2008 Theme';

__DATA__
__theme/oscon2008/template/tt2/kwiki_wrapper.html__
[%- INCLUDE kwiki_doctype.html %]
<!-- BEGIN kwiki_screen -->
[% INCLUDE kwiki_begin.html %]
[% content %]
[% INCLUDE kwiki_end.html -%]
__theme/oscon2008/template/tt2/kwiki_begin.html__

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>
[% IF hub.action == 'display' || 
      hub.action == 'edit' || 
      hub.action == 'revisions' 
%]
  [% hub.cgi.page_name %] -
[% END %]
[% IF hub.action != 'display' %]
  [% self.class_title %] - 
[% END %]
  [% site_title %]</title>
[%# FOR link = hub.links.all -%]
<!-- XXX Kwiki::Atom might need this, but it breaks Hub::AUTOLOAD
  <link rel="[% link.rel %]" type="[% link.type %]" href="[% link.href %]" />
-->
[%# END %]
[% url = hub.images.get_url(favicon) %]
[% IF url %]
   <link rel="shortcut icon" href="[% url %]"/>
[% END %]
[% FOR css_file = hub.css.files -%]
  [% IF css_file -%]
    <link rel="stylesheet" type="text/css" href="[% css_file %]" />
  [% END -%]
[% END -%]

<script type="text/javascript" src="theme/oscon2008/javascript/jquery-1.2.3.min.js"></script>
<script type="text/javascript" src="theme/oscon2008/javascript/jquery.corner.js"></script>
<script type="text/javascript" src="theme/oscon2008/javascript/oscon2008.js"></script>

[% FOR javascript_file = hub.javascript.files -%]
  [% IF javascript_file -%]
    <script type="text/javascript" src="[% javascript_file %]"></script>
  [% END -%]
[% END -%]
  <link rel="start" href="[% script_name %]" title="Home" />
</head>
[% INCLUDE body_tag.html %]
__theme/oscon2008/template/tt2/kwiki_screen.html__
[% WRAPPER kwiki_wrapper.html %]

<div id="page">
    <div id="header">
        <div id="page-title">[% screen_title || self.class_title %]</div>
    </div>


    [% hub.toolbar.html %]

    <div id="mid">
        <div id="left_col">
            <div id="left_nav">
            </div>
        </div>

        <div id="content">[% INCLUDE $content_pane %]</div>

        <div id="right_col">
            <div id="sponsors">
                <div id="logo">
                <img src="palm90.png" />
                </div>

                [% hub.widgets.html %]
                <span class="nav_rule"></span>
                <ul>
                    <li><a href="http://conferences.oreillynet.com/os2007/">OSCON 2007</a></li>
                    <li><a href="http://conferences.oreillynet.com/pub/w/58/about.html">About OSCON</a></li>
                </ul>
                <span class="nav_rule"></span>
                <ul>
                    <!--<li><a href = "#">Wiki</a></li>-->
                    <li><a href="http://conferences.oreillynet.com/os2006/">OSCON 2006</a></li>
                    <li><a href="http://www.oreillynet.com/conferences/blog/oscon">News &amp; Coverage</a></li>
                    <li><a href="http://conferences.oreilly.com/">O&#8217;Reilly Conferences</a></li>
                    <li><a href="http://www.oreilly.com">O&#8217;Reilly Home</a></li>
                </ul>
                [% hub.status.html %]
            </div>
        </div>

        <div id="end_mid">&nbsp;</div>
    </div>
    <div id="footer">
        <a href="http://www.kwiki.org">Kwiki</a> |
        <a href="http://www.oreilly.com">O'Reilly Home</a> |
        <a href="http://www.oreillynet.com/pub/a/mediakit/privacy.html">Privacy Policy</a>
    </div>
</div>

[% END %]
__theme/oscon2008/css/kwiki.css__
img { margin: 0; padding: 0; border: none; }

body {
    background: #011C48 none repeat scroll 0%;
    font-family:Corbel,Verdana,Arial,Helvetica,sans-serif;
    font-size:small;
    margin:20px 0pt 0pt;
    padding:0pt;
}

#page {
    width: 910px;
    margin: 0 auto;
}

#mid {
    background: white;
}

#header {
    width: 100%;
    height: 125px;
    background: url(/theme/oscon2008/images/oscon2008.jpg) no-repeat top center;
}

.toolbar {
    margin: 12px 0;
}

.toolbar .toolbar_button {
    background: url(http://en.oreilly.com/oscon2008/public/asset/asset/619) no-repeat bottom right;
    padding: 0 11px 0 0;
}

.toolbar a {
    padding: 0;
    margin: 0;
    color: white;
    text-transform: uppercase;
    text-decoration: none;
}

.toolbar a:hover {
    color: rgb(97,149,197);
}

/* RSS icon won't aline properly without this */
.toolbar_button img { margin: -4px 0; }

.toolbar_button a[title="RSS"]:before {
    content: "RSS ";
    color: #fff;
}

div.wiki {
    margin: 0 10px;
}

#page-title {
    font-size: 24px;
    position: relative;
    width: 630px;
    top: 80px;
    left: 275px;
    color: white;
    text-decoration: none;
}

#page-title a {
    color: white;
    text-decoration: none;
}

#page-title a:hover {
    color: #ffc;
}

#page-title:before {
    content: "Wiki: ";
}


#footer {
    padding: 10px 0;
    margin-top: 24px;
    background: #ccc;
    text-align: center;
}

#logo {
    margin: 20px 0px;
}

#right_col {
    text-align: center;
}

#right_col ul {
    text-align: left;
}

/* positioning (width must ad up to 910) */
#left_col {
    float: left;
    width: 0px;
}

#content {
    float: left;
    width: 730px;
}

#right_col {
    float: left;
    width: 180px;
}

#end_mid {
    clear: both;
}

__theme/oscon2008/javascript/jquery-1.2.3.min.js__
/*
 * jQuery 1.2.3 - New Wave Javascript
 *
 * Copyright (c) 2008 John Resig (jquery.com)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * $Date: 2008-02-06 00:21:25 -0500 (Wed, 06 Feb 2008) $
 * $Rev: 4663 $
 */
(function(){if(window.jQuery)var _jQuery=window.jQuery;var jQuery=window.jQuery=function(selector,context){return new jQuery.prototype.init(selector,context);};if(window.$)var _$=window.$;window.$=jQuery;var quickExpr=/^[^<]*(<(.|\s)+>)[^>]*$|^#(\w+)$/;var isSimple=/^.[^:#\[\.]*$/;jQuery.fn=jQuery.prototype={init:function(selector,context){selector=selector||document;if(selector.nodeType){this[0]=selector;this.length=1;return this;}else if(typeof selector=="string"){var match=quickExpr.exec(selector);if(match&&(match[1]||!context)){if(match[1])selector=jQuery.clean([match[1]],context);else{var elem=document.getElementById(match[3]);if(elem)if(elem.id!=match[3])return jQuery().find(selector);else{this[0]=elem;this.length=1;return this;}else
selector=[];}}else
return new jQuery(context).find(selector);}else if(jQuery.isFunction(selector))return new jQuery(document)[jQuery.fn.ready?"ready":"load"](selector);return this.setArray(selector.constructor==Array&&selector||(selector.jquery||selector.length&&selector!=window&&!selector.nodeType&&selector[0]!=undefined&&selector[0].nodeType)&&jQuery.makeArray(selector)||[selector]);},jquery:"1.2.3",size:function(){return this.length;},length:0,get:function(num){return num==undefined?jQuery.makeArray(this):this[num];},pushStack:function(elems){var ret=jQuery(elems);ret.prevObject=this;return ret;},setArray:function(elems){this.length=0;Array.prototype.push.apply(this,elems);return this;},each:function(callback,args){return jQuery.each(this,callback,args);},index:function(elem){var ret=-1;this.each(function(i){if(this==elem)ret=i;});return ret;},attr:function(name,value,type){var options=name;if(name.constructor==String)if(value==undefined)return this.length&&jQuery[type||"attr"](this[0],name)||undefined;else{options={};options[name]=value;}return this.each(function(i){for(name in options)jQuery.attr(type?this.style:this,name,jQuery.prop(this,options[name],type,i,name));});},css:function(key,value){if((key=='width'||key=='height')&&parseFloat(value)<0)value=undefined;return this.attr(key,value,"curCSS");},text:function(text){if(typeof text!="object"&&text!=null)return this.empty().append((this[0]&&this[0].ownerDocument||document).createTextNode(text));var ret="";jQuery.each(text||this,function(){jQuery.each(this.childNodes,function(){if(this.nodeType!=8)ret+=this.nodeType!=1?this.nodeValue:jQuery.fn.text([this]);});});return ret;},wrapAll:function(html){if(this[0])jQuery(html,this[0].ownerDocument).clone().insertBefore(this[0]).map(function(){var elem=this;while(elem.firstChild)elem=elem.firstChild;return elem;}).append(this);return this;},wrapInner:function(html){return this.each(function(){jQuery(this).contents().wrapAll(html);});},wrap:function(html){return this.each(function(){jQuery(this).wrapAll(html);});},append:function(){return this.domManip(arguments,true,false,function(elem){if(this.nodeType==1)this.appendChild(elem);});},prepend:function(){return this.domManip(arguments,true,true,function(elem){if(this.nodeType==1)this.insertBefore(elem,this.firstChild);});},before:function(){return this.domManip(arguments,false,false,function(elem){this.parentNode.insertBefore(elem,this);});},after:function(){return this.domManip(arguments,false,true,function(elem){this.parentNode.insertBefore(elem,this.nextSibling);});},end:function(){return this.prevObject||jQuery([]);},find:function(selector){var elems=jQuery.map(this,function(elem){return jQuery.find(selector,elem);});return this.pushStack(/[^+>] [^+>]/.test(selector)||selector.indexOf("..")>-1?jQuery.unique(elems):elems);},clone:function(events){var ret=this.map(function(){if(jQuery.browser.msie&&!jQuery.isXMLDoc(this)){var clone=this.cloneNode(true),container=document.createElement("div");container.appendChild(clone);return jQuery.clean([container.innerHTML])[0];}else
return this.cloneNode(true);});var clone=ret.find("*").andSelf().each(function(){if(this[expando]!=undefined)this[expando]=null;});if(events===true)this.find("*").andSelf().each(function(i){if(this.nodeType==3)return;var events=jQuery.data(this,"events");for(var type in events)for(var handler in events[type])jQuery.event.add(clone[i],type,events[type][handler],events[type][handler].data);});return ret;},filter:function(selector){return this.pushStack(jQuery.isFunction(selector)&&jQuery.grep(this,function(elem,i){return selector.call(elem,i);})||jQuery.multiFilter(selector,this));},not:function(selector){if(selector.constructor==String)if(isSimple.test(selector))return this.pushStack(jQuery.multiFilter(selector,this,true));else
selector=jQuery.multiFilter(selector,this);var isArrayLike=selector.length&&selector[selector.length-1]!==undefined&&!selector.nodeType;return this.filter(function(){return isArrayLike?jQuery.inArray(this,selector)<0:this!=selector;});},add:function(selector){return!selector?this:this.pushStack(jQuery.merge(this.get(),selector.constructor==String?jQuery(selector).get():selector.length!=undefined&&(!selector.nodeName||jQuery.nodeName(selector,"form"))?selector:[selector]));},is:function(selector){return selector?jQuery.multiFilter(selector,this).length>0:false;},hasClass:function(selector){return this.is("."+selector);},val:function(value){if(value==undefined){if(this.length){var elem=this[0];if(jQuery.nodeName(elem,"select")){var index=elem.selectedIndex,values=[],options=elem.options,one=elem.type=="select-one";if(index<0)return null;for(var i=one?index:0,max=one?index+1:options.length;i<max;i++){var option=options[i];if(option.selected){value=jQuery.browser.msie&&!option.attributes.value.specified?option.text:option.value;if(one)return value;values.push(value);}}return values;}else
return(this[0].value||"").replace(/\r/g,"");}return undefined;}return this.each(function(){if(this.nodeType!=1)return;if(value.constructor==Array&&/radio|checkbox/.test(this.type))this.checked=(jQuery.inArray(this.value,value)>=0||jQuery.inArray(this.name,value)>=0);else if(jQuery.nodeName(this,"select")){var values=value.constructor==Array?value:[value];jQuery("option",this).each(function(){this.selected=(jQuery.inArray(this.value,values)>=0||jQuery.inArray(this.text,values)>=0);});if(!values.length)this.selectedIndex=-1;}else
this.value=value;});},html:function(value){return value==undefined?(this.length?this[0].innerHTML:null):this.empty().append(value);},replaceWith:function(value){return this.after(value).remove();},eq:function(i){return this.slice(i,i+1);},slice:function(){return this.pushStack(Array.prototype.slice.apply(this,arguments));},map:function(callback){return this.pushStack(jQuery.map(this,function(elem,i){return callback.call(elem,i,elem);}));},andSelf:function(){return this.add(this.prevObject);},data:function(key,value){var parts=key.split(".");parts[1]=parts[1]?"."+parts[1]:"";if(value==null){var data=this.triggerHandler("getData"+parts[1]+"!",[parts[0]]);if(data==undefined&&this.length)data=jQuery.data(this[0],key);return data==null&&parts[1]?this.data(parts[0]):data;}else
return this.trigger("setData"+parts[1]+"!",[parts[0],value]).each(function(){jQuery.data(this,key,value);});},removeData:function(key){return this.each(function(){jQuery.removeData(this,key);});},domManip:function(args,table,reverse,callback){var clone=this.length>1,elems;return this.each(function(){if(!elems){elems=jQuery.clean(args,this.ownerDocument);if(reverse)elems.reverse();}var obj=this;if(table&&jQuery.nodeName(this,"table")&&jQuery.nodeName(elems[0],"tr"))obj=this.getElementsByTagName("tbody")[0]||this.appendChild(this.ownerDocument.createElement("tbody"));var scripts=jQuery([]);jQuery.each(elems,function(){var elem=clone?jQuery(this).clone(true)[0]:this;if(jQuery.nodeName(elem,"script")){scripts=scripts.add(elem);}else{if(elem.nodeType==1)scripts=scripts.add(jQuery("script",elem).remove());callback.call(obj,elem);}});scripts.each(evalScript);});}};jQuery.prototype.init.prototype=jQuery.prototype;function evalScript(i,elem){if(elem.src)jQuery.ajax({url:elem.src,async:false,dataType:"script"});else
jQuery.globalEval(elem.text||elem.textContent||elem.innerHTML||"");if(elem.parentNode)elem.parentNode.removeChild(elem);}jQuery.extend=jQuery.fn.extend=function(){var target=arguments[0]||{},i=1,length=arguments.length,deep=false,options;if(target.constructor==Boolean){deep=target;target=arguments[1]||{};i=2;}if(typeof target!="object"&&typeof target!="function")target={};if(length==1){target=this;i=0;}for(;i<length;i++)if((options=arguments[i])!=null)for(var name in options){if(target===options[name])continue;if(deep&&options[name]&&typeof options[name]=="object"&&target[name]&&!options[name].nodeType)target[name]=jQuery.extend(target[name],options[name]);else if(options[name]!=undefined)target[name]=options[name];}return target;};var expando="jQuery"+(new Date()).getTime(),uuid=0,windowData={};var exclude=/z-?index|font-?weight|opacity|zoom|line-?height/i;jQuery.extend({noConflict:function(deep){window.$=_$;if(deep)window.jQuery=_jQuery;return jQuery;},isFunction:function(fn){return!!fn&&typeof fn!="string"&&!fn.nodeName&&fn.constructor!=Array&&/function/i.test(fn+"");},isXMLDoc:function(elem){return elem.documentElement&&!elem.body||elem.tagName&&elem.ownerDocument&&!elem.ownerDocument.body;},globalEval:function(data){data=jQuery.trim(data);if(data){var head=document.getElementsByTagName("head")[0]||document.documentElement,script=document.createElement("script");script.type="text/javascript";if(jQuery.browser.msie)script.text=data;else
script.appendChild(document.createTextNode(data));head.appendChild(script);head.removeChild(script);}},nodeName:function(elem,name){return elem.nodeName&&elem.nodeName.toUpperCase()==name.toUpperCase();},cache:{},data:function(elem,name,data){elem=elem==window?windowData:elem;var id=elem[expando];if(!id)id=elem[expando]=++uuid;if(name&&!jQuery.cache[id])jQuery.cache[id]={};if(data!=undefined)jQuery.cache[id][name]=data;return name?jQuery.cache[id][name]:id;},removeData:function(elem,name){elem=elem==window?windowData:elem;var id=elem[expando];if(name){if(jQuery.cache[id]){delete jQuery.cache[id][name];name="";for(name in jQuery.cache[id])break;if(!name)jQuery.removeData(elem);}}else{try{delete elem[expando];}catch(e){if(elem.removeAttribute)elem.removeAttribute(expando);}delete jQuery.cache[id];}},each:function(object,callback,args){if(args){if(object.length==undefined){for(var name in object)if(callback.apply(object[name],args)===false)break;}else
for(var i=0,length=object.length;i<length;i++)if(callback.apply(object[i],args)===false)break;}else{if(object.length==undefined){for(var name in object)if(callback.call(object[name],name,object[name])===false)break;}else
for(var i=0,length=object.length,value=object[0];i<length&&callback.call(value,i,value)!==false;value=object[++i]){}}return object;},prop:function(elem,value,type,i,name){if(jQuery.isFunction(value))value=value.call(elem,i);return value&&value.constructor==Number&&type=="curCSS"&&!exclude.test(name)?value+"px":value;},className:{add:function(elem,classNames){jQuery.each((classNames||"").split(/\s+/),function(i,className){if(elem.nodeType==1&&!jQuery.className.has(elem.className,className))elem.className+=(elem.className?" ":"")+className;});},remove:function(elem,classNames){if(elem.nodeType==1)elem.className=classNames!=undefined?jQuery.grep(elem.className.split(/\s+/),function(className){return!jQuery.className.has(classNames,className);}).join(" "):"";},has:function(elem,className){return jQuery.inArray(className,(elem.className||elem).toString().split(/\s+/))>-1;}},swap:function(elem,options,callback){var old={};for(var name in options){old[name]=elem.style[name];elem.style[name]=options[name];}callback.call(elem);for(var name in options)elem.style[name]=old[name];},css:function(elem,name,force){if(name=="width"||name=="height"){var val,props={position:"absolute",visibility:"hidden",display:"block"},which=name=="width"?["Left","Right"]:["Top","Bottom"];function getWH(){val=name=="width"?elem.offsetWidth:elem.offsetHeight;var padding=0,border=0;jQuery.each(which,function(){padding+=parseFloat(jQuery.curCSS(elem,"padding"+this,true))||0;border+=parseFloat(jQuery.curCSS(elem,"border"+this+"Width",true))||0;});val-=Math.round(padding+border);}if(jQuery(elem).is(":visible"))getWH();else
jQuery.swap(elem,props,getWH);return Math.max(0,val);}return jQuery.curCSS(elem,name,force);},curCSS:function(elem,name,force){var ret;function color(elem){if(!jQuery.browser.safari)return false;var ret=document.defaultView.getComputedStyle(elem,null);return!ret||ret.getPropertyValue("color")=="";}if(name=="opacity"&&jQuery.browser.msie){ret=jQuery.attr(elem.style,"opacity");return ret==""?"1":ret;}if(jQuery.browser.opera&&name=="display"){var save=elem.style.outline;elem.style.outline="0 solid black";elem.style.outline=save;}if(name.match(/float/i))name=styleFloat;if(!force&&elem.style&&elem.style[name])ret=elem.style[name];else if(document.defaultView&&document.defaultView.getComputedStyle){if(name.match(/float/i))name="float";name=name.replace(/([A-Z])/g,"-$1").toLowerCase();var getComputedStyle=document.defaultView.getComputedStyle(elem,null);if(getComputedStyle&&!color(elem))ret=getComputedStyle.getPropertyValue(name);else{var swap=[],stack=[];for(var a=elem;a&&color(a);a=a.parentNode)stack.unshift(a);for(var i=0;i<stack.length;i++)if(color(stack[i])){swap[i]=stack[i].style.display;stack[i].style.display="block";}ret=name=="display"&&swap[stack.length-1]!=null?"none":(getComputedStyle&&getComputedStyle.getPropertyValue(name))||"";for(var i=0;i<swap.length;i++)if(swap[i]!=null)stack[i].style.display=swap[i];}if(name=="opacity"&&ret=="")ret="1";}else if(elem.currentStyle){var camelCase=name.replace(/\-(\w)/g,function(all,letter){return letter.toUpperCase();});ret=elem.currentStyle[name]||elem.currentStyle[camelCase];if(!/^\d+(px)?$/i.test(ret)&&/^\d/.test(ret)){var style=elem.style.left,runtimeStyle=elem.runtimeStyle.left;elem.runtimeStyle.left=elem.currentStyle.left;elem.style.left=ret||0;ret=elem.style.pixelLeft+"px";elem.style.left=style;elem.runtimeStyle.left=runtimeStyle;}}return ret;},clean:function(elems,context){var ret=[];context=context||document;if(typeof context.createElement=='undefined')context=context.ownerDocument||context[0]&&context[0].ownerDocument||document;jQuery.each(elems,function(i,elem){if(!elem)return;if(elem.constructor==Number)elem=elem.toString();if(typeof elem=="string"){elem=elem.replace(/(<(\w+)[^>]*?)\/>/g,function(all,front,tag){return tag.match(/^(abbr|br|col|img|input|link|meta|param|hr|area|embed)$/i)?all:front+"></"+tag+">";});var tags=jQuery.trim(elem).toLowerCase(),div=context.createElement("div");var wrap=!tags.indexOf("<opt")&&[1,"<select multiple='multiple'>","</select>"]||!tags.indexOf("<leg")&&[1,"<fieldset>","</fieldset>"]||tags.match(/^<(thead|tbody|tfoot|colg|cap)/)&&[1,"<table>","</table>"]||!tags.indexOf("<tr")&&[2,"<table><tbody>","</tbody></table>"]||(!tags.indexOf("<td")||!tags.indexOf("<th"))&&[3,"<table><tbody><tr>","</tr></tbody></table>"]||!tags.indexOf("<col")&&[2,"<table><tbody></tbody><colgroup>","</colgroup></table>"]||jQuery.browser.msie&&[1,"div<div>","</div>"]||[0,"",""];div.innerHTML=wrap[1]+elem+wrap[2];while(wrap[0]--)div=div.lastChild;if(jQuery.browser.msie){var tbody=!tags.indexOf("<table")&&tags.indexOf("<tbody")<0?div.firstChild&&div.firstChild.childNodes:wrap[1]=="<table>"&&tags.indexOf("<tbody")<0?div.childNodes:[];for(var j=tbody.length-1;j>=0;--j)if(jQuery.nodeName(tbody[j],"tbody")&&!tbody[j].childNodes.length)tbody[j].parentNode.removeChild(tbody[j]);if(/^\s/.test(elem))div.insertBefore(context.createTextNode(elem.match(/^\s*/)[0]),div.firstChild);}elem=jQuery.makeArray(div.childNodes);}if(elem.length===0&&(!jQuery.nodeName(elem,"form")&&!jQuery.nodeName(elem,"select")))return;if(elem[0]==undefined||jQuery.nodeName(elem,"form")||elem.options)ret.push(elem);else
ret=jQuery.merge(ret,elem);});return ret;},attr:function(elem,name,value){if(!elem||elem.nodeType==3||elem.nodeType==8)return undefined;var fix=jQuery.isXMLDoc(elem)?{}:jQuery.props;if(name=="selected"&&jQuery.browser.safari)elem.parentNode.selectedIndex;if(fix[name]){if(value!=undefined)elem[fix[name]]=value;return elem[fix[name]];}else if(jQuery.browser.msie&&name=="style")return jQuery.attr(elem.style,"cssText",value);else if(value==undefined&&jQuery.browser.msie&&jQuery.nodeName(elem,"form")&&(name=="action"||name=="method"))return elem.getAttributeNode(name).nodeValue;else if(elem.tagName){if(value!=undefined){if(name=="type"&&jQuery.nodeName(elem,"input")&&elem.parentNode)throw"type property can't be changed";elem.setAttribute(name,""+value);}if(jQuery.browser.msie&&/href|src/.test(name)&&!jQuery.isXMLDoc(elem))return elem.getAttribute(name,2);return elem.getAttribute(name);}else{if(name=="opacity"&&jQuery.browser.msie){if(value!=undefined){elem.zoom=1;elem.filter=(elem.filter||"").replace(/alpha\([^)]*\)/,"")+(parseFloat(value).toString()=="NaN"?"":"alpha(opacity="+value*100+")");}return elem.filter&&elem.filter.indexOf("opacity=")>=0?(parseFloat(elem.filter.match(/opacity=([^)]*)/)[1])/100).toString():"";}name=name.replace(/-([a-z])/ig,function(all,letter){return letter.toUpperCase();});if(value!=undefined)elem[name]=value;return elem[name];}},trim:function(text){return(text||"").replace(/^\s+|\s+$/g,"");},makeArray:function(array){var ret=[];if(typeof array!="array")for(var i=0,length=array.length;i<length;i++)ret.push(array[i]);else
ret=array.slice(0);return ret;},inArray:function(elem,array){for(var i=0,length=array.length;i<length;i++)if(array[i]==elem)return i;return-1;},merge:function(first,second){if(jQuery.browser.msie){for(var i=0;second[i];i++)if(second[i].nodeType!=8)first.push(second[i]);}else
for(var i=0;second[i];i++)first.push(second[i]);return first;},unique:function(array){var ret=[],done={};try{for(var i=0,length=array.length;i<length;i++){var id=jQuery.data(array[i]);if(!done[id]){done[id]=true;ret.push(array[i]);}}}catch(e){ret=array;}return ret;},grep:function(elems,callback,inv){var ret=[];for(var i=0,length=elems.length;i<length;i++)if(!inv&&callback(elems[i],i)||inv&&!callback(elems[i],i))ret.push(elems[i]);return ret;},map:function(elems,callback){var ret=[];for(var i=0,length=elems.length;i<length;i++){var value=callback(elems[i],i);if(value!==null&&value!=undefined){if(value.constructor!=Array)value=[value];ret=ret.concat(value);}}return ret;}});var userAgent=navigator.userAgent.toLowerCase();jQuery.browser={version:(userAgent.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/)||[])[1],safari:/webkit/.test(userAgent),opera:/opera/.test(userAgent),msie:/msie/.test(userAgent)&&!/opera/.test(userAgent),mozilla:/mozilla/.test(userAgent)&&!/(compatible|webkit)/.test(userAgent)};var styleFloat=jQuery.browser.msie?"styleFloat":"cssFloat";jQuery.extend({boxModel:!jQuery.browser.msie||document.compatMode=="CSS1Compat",props:{"for":"htmlFor","class":"className","float":styleFloat,cssFloat:styleFloat,styleFloat:styleFloat,innerHTML:"innerHTML",className:"className",value:"value",disabled:"disabled",checked:"checked",readonly:"readOnly",selected:"selected",maxlength:"maxLength",selectedIndex:"selectedIndex",defaultValue:"defaultValue",tagName:"tagName",nodeName:"nodeName"}});jQuery.each({parent:function(elem){return elem.parentNode;},parents:function(elem){return jQuery.dir(elem,"parentNode");},next:function(elem){return jQuery.nth(elem,2,"nextSibling");},prev:function(elem){return jQuery.nth(elem,2,"previousSibling");},nextAll:function(elem){return jQuery.dir(elem,"nextSibling");},prevAll:function(elem){return jQuery.dir(elem,"previousSibling");},siblings:function(elem){return jQuery.sibling(elem.parentNode.firstChild,elem);},children:function(elem){return jQuery.sibling(elem.firstChild);},contents:function(elem){return jQuery.nodeName(elem,"iframe")?elem.contentDocument||elem.contentWindow.document:jQuery.makeArray(elem.childNodes);}},function(name,fn){jQuery.fn[name]=function(selector){var ret=jQuery.map(this,fn);if(selector&&typeof selector=="string")ret=jQuery.multiFilter(selector,ret);return this.pushStack(jQuery.unique(ret));};});jQuery.each({appendTo:"append",prependTo:"prepend",insertBefore:"before",insertAfter:"after",replaceAll:"replaceWith"},function(name,original){jQuery.fn[name]=function(){var args=arguments;return this.each(function(){for(var i=0,length=args.length;i<length;i++)jQuery(args[i])[original](this);});};});jQuery.each({removeAttr:function(name){jQuery.attr(this,name,"");if(this.nodeType==1)this.removeAttribute(name);},addClass:function(classNames){jQuery.className.add(this,classNames);},removeClass:function(classNames){jQuery.className.remove(this,classNames);},toggleClass:function(classNames){jQuery.className[jQuery.className.has(this,classNames)?"remove":"add"](this,classNames);},remove:function(selector){if(!selector||jQuery.filter(selector,[this]).r.length){jQuery("*",this).add(this).each(function(){jQuery.event.remove(this);jQuery.removeData(this);});if(this.parentNode)this.parentNode.removeChild(this);}},empty:function(){jQuery(">*",this).remove();while(this.firstChild)this.removeChild(this.firstChild);}},function(name,fn){jQuery.fn[name]=function(){return this.each(fn,arguments);};});jQuery.each(["Height","Width"],function(i,name){var type=name.toLowerCase();jQuery.fn[type]=function(size){return this[0]==window?jQuery.browser.opera&&document.body["client"+name]||jQuery.browser.safari&&window["inner"+name]||document.compatMode=="CSS1Compat"&&document.documentElement["client"+name]||document.body["client"+name]:this[0]==document?Math.max(Math.max(document.body["scroll"+name],document.documentElement["scroll"+name]),Math.max(document.body["offset"+name],document.documentElement["offset"+name])):size==undefined?(this.length?jQuery.css(this[0],type):null):this.css(type,size.constructor==String?size:size+"px");};});var chars=jQuery.browser.safari&&parseInt(jQuery.browser.version)<417?"(?:[\\w*_-]|\\\\.)":"(?:[\\w\u0128-\uFFFF*_-]|\\\\.)",quickChild=new RegExp("^>\\s*("+chars+"+)"),quickID=new RegExp("^("+chars+"+)(#)("+chars+"+)"),quickClass=new RegExp("^([#.]?)("+chars+"*)");jQuery.extend({expr:{"":function(a,i,m){return m[2]=="*"||jQuery.nodeName(a,m[2]);},"#":function(a,i,m){return a.getAttribute("id")==m[2];},":":{lt:function(a,i,m){return i<m[3]-0;},gt:function(a,i,m){return i>m[3]-0;},nth:function(a,i,m){return m[3]-0==i;},eq:function(a,i,m){return m[3]-0==i;},first:function(a,i){return i==0;},last:function(a,i,m,r){return i==r.length-1;},even:function(a,i){return i%2==0;},odd:function(a,i){return i%2;},"first-child":function(a){return a.parentNode.getElementsByTagName("*")[0]==a;},"last-child":function(a){return jQuery.nth(a.parentNode.lastChild,1,"previousSibling")==a;},"only-child":function(a){return!jQuery.nth(a.parentNode.lastChild,2,"previousSibling");},parent:function(a){return a.firstChild;},empty:function(a){return!a.firstChild;},contains:function(a,i,m){return(a.textContent||a.innerText||jQuery(a).text()||"").indexOf(m[3])>=0;},visible:function(a){return"hidden"!=a.type&&jQuery.css(a,"display")!="none"&&jQuery.css(a,"visibility")!="hidden";},hidden:function(a){return"hidden"==a.type||jQuery.css(a,"display")=="none"||jQuery.css(a,"visibility")=="hidden";},enabled:function(a){return!a.disabled;},disabled:function(a){return a.disabled;},checked:function(a){return a.checked;},selected:function(a){return a.selected||jQuery.attr(a,"selected");},text:function(a){return"text"==a.type;},radio:function(a){return"radio"==a.type;},checkbox:function(a){return"checkbox"==a.type;},file:function(a){return"file"==a.type;},password:function(a){return"password"==a.type;},submit:function(a){return"submit"==a.type;},image:function(a){return"image"==a.type;},reset:function(a){return"reset"==a.type;},button:function(a){return"button"==a.type||jQuery.nodeName(a,"button");},input:function(a){return/input|select|textarea|button/i.test(a.nodeName);},has:function(a,i,m){return jQuery.find(m[3],a).length;},header:function(a){return/h\d/i.test(a.nodeName);},animated:function(a){return jQuery.grep(jQuery.timers,function(fn){return a==fn.elem;}).length;}}},parse:[/^(\[) *@?([\w-]+) *([!*$^~=]*) *('?"?)(.*?)\4 *\]/,/^(:)([\w-]+)\("?'?(.*?(\(.*?\))?[^(]*?)"?'?\)/,new RegExp("^([:.#]*)("+chars+"+)")],multiFilter:function(expr,elems,not){var old,cur=[];while(expr&&expr!=old){old=expr;var f=jQuery.filter(expr,elems,not);expr=f.t.replace(/^\s*,\s*/,"");cur=not?elems=f.r:jQuery.merge(cur,f.r);}return cur;},find:function(t,context){if(typeof t!="string")return[t];if(context&&context.nodeType!=1&&context.nodeType!=9)return[];context=context||document;var ret=[context],done=[],last,nodeName;while(t&&last!=t){var r=[];last=t;t=jQuery.trim(t);var foundToken=false;var re=quickChild;var m=re.exec(t);if(m){nodeName=m[1].toUpperCase();for(var i=0;ret[i];i++)for(var c=ret[i].firstChild;c;c=c.nextSibling)if(c.nodeType==1&&(nodeName=="*"||c.nodeName.toUpperCase()==nodeName))r.push(c);ret=r;t=t.replace(re,"");if(t.indexOf(" ")==0)continue;foundToken=true;}else{re=/^([>+~])\s*(\w*)/i;if((m=re.exec(t))!=null){r=[];var merge={};nodeName=m[2].toUpperCase();m=m[1];for(var j=0,rl=ret.length;j<rl;j++){var n=m=="~"||m=="+"?ret[j].nextSibling:ret[j].firstChild;for(;n;n=n.nextSibling)if(n.nodeType==1){var id=jQuery.data(n);if(m=="~"&&merge[id])break;if(!nodeName||n.nodeName.toUpperCase()==nodeName){if(m=="~")merge[id]=true;r.push(n);}if(m=="+")break;}}ret=r;t=jQuery.trim(t.replace(re,""));foundToken=true;}}if(t&&!foundToken){if(!t.indexOf(",")){if(context==ret[0])ret.shift();done=jQuery.merge(done,ret);r=ret=[context];t=" "+t.substr(1,t.length);}else{var re2=quickID;var m=re2.exec(t);if(m){m=[0,m[2],m[3],m[1]];}else{re2=quickClass;m=re2.exec(t);}m[2]=m[2].replace(/\\/g,"");var elem=ret[ret.length-1];if(m[1]=="#"&&elem&&elem.getElementById&&!jQuery.isXMLDoc(elem)){var oid=elem.getElementById(m[2]);if((jQuery.browser.msie||jQuery.browser.opera)&&oid&&typeof oid.id=="string"&&oid.id!=m[2])oid=jQuery('[@id="'+m[2]+'"]',elem)[0];ret=r=oid&&(!m[3]||jQuery.nodeName(oid,m[3]))?[oid]:[];}else{for(var i=0;ret[i];i++){var tag=m[1]=="#"&&m[3]?m[3]:m[1]!=""||m[0]==""?"*":m[2];if(tag=="*"&&ret[i].nodeName.toLowerCase()=="object")tag="param";r=jQuery.merge(r,ret[i].getElementsByTagName(tag));}if(m[1]==".")r=jQuery.classFilter(r,m[2]);if(m[1]=="#"){var tmp=[];for(var i=0;r[i];i++)if(r[i].getAttribute("id")==m[2]){tmp=[r[i]];break;}r=tmp;}ret=r;}t=t.replace(re2,"");}}if(t){var val=jQuery.filter(t,r);ret=r=val.r;t=jQuery.trim(val.t);}}if(t)ret=[];if(ret&&context==ret[0])ret.shift();done=jQuery.merge(done,ret);return done;},classFilter:function(r,m,not){m=" "+m+" ";var tmp=[];for(var i=0;r[i];i++){var pass=(" "+r[i].className+" ").indexOf(m)>=0;if(!not&&pass||not&&!pass)tmp.push(r[i]);}return tmp;},filter:function(t,r,not){var last;while(t&&t!=last){last=t;var p=jQuery.parse,m;for(var i=0;p[i];i++){m=p[i].exec(t);if(m){t=t.substring(m[0].length);m[2]=m[2].replace(/\\/g,"");break;}}if(!m)break;if(m[1]==":"&&m[2]=="not")r=isSimple.test(m[3])?jQuery.filter(m[3],r,true).r:jQuery(r).not(m[3]);else if(m[1]==".")r=jQuery.classFilter(r,m[2],not);else if(m[1]=="["){var tmp=[],type=m[3];for(var i=0,rl=r.length;i<rl;i++){var a=r[i],z=a[jQuery.props[m[2]]||m[2]];if(z==null||/href|src|selected/.test(m[2]))z=jQuery.attr(a,m[2])||'';if((type==""&&!!z||type=="="&&z==m[5]||type=="!="&&z!=m[5]||type=="^="&&z&&!z.indexOf(m[5])||type=="$="&&z.substr(z.length-m[5].length)==m[5]||(type=="*="||type=="~=")&&z.indexOf(m[5])>=0)^not)tmp.push(a);}r=tmp;}else if(m[1]==":"&&m[2]=="nth-child"){var merge={},tmp=[],test=/(-?)(\d*)n((?:\+|-)?\d*)/.exec(m[3]=="even"&&"2n"||m[3]=="odd"&&"2n+1"||!/\D/.test(m[3])&&"0n+"+m[3]||m[3]),first=(test[1]+(test[2]||1))-0,last=test[3]-0;for(var i=0,rl=r.length;i<rl;i++){var node=r[i],parentNode=node.parentNode,id=jQuery.data(parentNode);if(!merge[id]){var c=1;for(var n=parentNode.firstChild;n;n=n.nextSibling)if(n.nodeType==1)n.nodeIndex=c++;merge[id]=true;}var add=false;if(first==0){if(node.nodeIndex==last)add=true;}else if((node.nodeIndex-last)%first==0&&(node.nodeIndex-last)/first>=0)add=true;if(add^not)tmp.push(node);}r=tmp;}else{var fn=jQuery.expr[m[1]];if(typeof fn=="object")fn=fn[m[2]];if(typeof fn=="string")fn=eval("false||function(a,i){return "+fn+";}");r=jQuery.grep(r,function(elem,i){return fn(elem,i,m,r);},not);}}return{r:r,t:t};},dir:function(elem,dir){var matched=[];var cur=elem[dir];while(cur&&cur!=document){if(cur.nodeType==1)matched.push(cur);cur=cur[dir];}return matched;},nth:function(cur,result,dir,elem){result=result||1;var num=0;for(;cur;cur=cur[dir])if(cur.nodeType==1&&++num==result)break;return cur;},sibling:function(n,elem){var r=[];for(;n;n=n.nextSibling){if(n.nodeType==1&&(!elem||n!=elem))r.push(n);}return r;}});jQuery.event={add:function(elem,types,handler,data){if(elem.nodeType==3||elem.nodeType==8)return;if(jQuery.browser.msie&&elem.setInterval!=undefined)elem=window;if(!handler.guid)handler.guid=this.guid++;if(data!=undefined){var fn=handler;handler=function(){return fn.apply(this,arguments);};handler.data=data;handler.guid=fn.guid;}var events=jQuery.data(elem,"events")||jQuery.data(elem,"events",{}),handle=jQuery.data(elem,"handle")||jQuery.data(elem,"handle",function(){var val;if(typeof jQuery=="undefined"||jQuery.event.triggered)return val;val=jQuery.event.handle.apply(arguments.callee.elem,arguments);return val;});handle.elem=elem;jQuery.each(types.split(/\s+/),function(index,type){var parts=type.split(".");type=parts[0];handler.type=parts[1];var handlers=events[type];if(!handlers){handlers=events[type]={};if(!jQuery.event.special[type]||jQuery.event.special[type].setup.call(elem)===false){if(elem.addEventListener)elem.addEventListener(type,handle,false);else if(elem.attachEvent)elem.attachEvent("on"+type,handle);}}handlers[handler.guid]=handler;jQuery.event.global[type]=true;});elem=null;},guid:1,global:{},remove:function(elem,types,handler){if(elem.nodeType==3||elem.nodeType==8)return;var events=jQuery.data(elem,"events"),ret,index;if(events){if(types==undefined||(typeof types=="string"&&types.charAt(0)=="."))for(var type in events)this.remove(elem,type+(types||""));else{if(types.type){handler=types.handler;types=types.type;}jQuery.each(types.split(/\s+/),function(index,type){var parts=type.split(".");type=parts[0];if(events[type]){if(handler)delete events[type][handler.guid];else
for(handler in events[type])if(!parts[1]||events[type][handler].type==parts[1])delete events[type][handler];for(ret in events[type])break;if(!ret){if(!jQuery.event.special[type]||jQuery.event.special[type].teardown.call(elem)===false){if(elem.removeEventListener)elem.removeEventListener(type,jQuery.data(elem,"handle"),false);else if(elem.detachEvent)elem.detachEvent("on"+type,jQuery.data(elem,"handle"));}ret=null;delete events[type];}}});}for(ret in events)break;if(!ret){var handle=jQuery.data(elem,"handle");if(handle)handle.elem=null;jQuery.removeData(elem,"events");jQuery.removeData(elem,"handle");}}},trigger:function(type,data,elem,donative,extra){data=jQuery.makeArray(data||[]);if(type.indexOf("!")>=0){type=type.slice(0,-1);var exclusive=true;}if(!elem){if(this.global[type])jQuery("*").add([window,document]).trigger(type,data);}else{if(elem.nodeType==3||elem.nodeType==8)return undefined;var val,ret,fn=jQuery.isFunction(elem[type]||null),event=!data[0]||!data[0].preventDefault;if(event)data.unshift(this.fix({type:type,target:elem}));data[0].type=type;if(exclusive)data[0].exclusive=true;if(jQuery.isFunction(jQuery.data(elem,"handle")))val=jQuery.data(elem,"handle").apply(elem,data);if(!fn&&elem["on"+type]&&elem["on"+type].apply(elem,data)===false)val=false;if(event)data.shift();if(extra&&jQuery.isFunction(extra)){ret=extra.apply(elem,val==null?data:data.concat(val));if(ret!==undefined)val=ret;}if(fn&&donative!==false&&val!==false&&!(jQuery.nodeName(elem,'a')&&type=="click")){this.triggered=true;try{elem[type]();}catch(e){}}this.triggered=false;}return val;},handle:function(event){var val;event=jQuery.event.fix(event||window.event||{});var parts=event.type.split(".");event.type=parts[0];var handlers=jQuery.data(this,"events")&&jQuery.data(this,"events")[event.type],args=Array.prototype.slice.call(arguments,1);args.unshift(event);for(var j in handlers){var handler=handlers[j];args[0].handler=handler;args[0].data=handler.data;if(!parts[1]&&!event.exclusive||handler.type==parts[1]){var ret=handler.apply(this,args);if(val!==false)val=ret;if(ret===false){event.preventDefault();event.stopPropagation();}}}if(jQuery.browser.msie)event.target=event.preventDefault=event.stopPropagation=event.handler=event.data=null;return val;},fix:function(event){var originalEvent=event;event=jQuery.extend({},originalEvent);event.preventDefault=function(){if(originalEvent.preventDefault)originalEvent.preventDefault();originalEvent.returnValue=false;};event.stopPropagation=function(){if(originalEvent.stopPropagation)originalEvent.stopPropagation();originalEvent.cancelBubble=true;};if(!event.target)event.target=event.srcElement||document;if(event.target.nodeType==3)event.target=originalEvent.target.parentNode;if(!event.relatedTarget&&event.fromElement)event.relatedTarget=event.fromElement==event.target?event.toElement:event.fromElement;if(event.pageX==null&&event.clientX!=null){var doc=document.documentElement,body=document.body;event.pageX=event.clientX+(doc&&doc.scrollLeft||body&&body.scrollLeft||0)-(doc.clientLeft||0);event.pageY=event.clientY+(doc&&doc.scrollTop||body&&body.scrollTop||0)-(doc.clientTop||0);}if(!event.which&&((event.charCode||event.charCode===0)?event.charCode:event.keyCode))event.which=event.charCode||event.keyCode;if(!event.metaKey&&event.ctrlKey)event.metaKey=event.ctrlKey;if(!event.which&&event.button)event.which=(event.button&1?1:(event.button&2?3:(event.button&4?2:0)));return event;},special:{ready:{setup:function(){bindReady();return;},teardown:function(){return;}},mouseenter:{setup:function(){if(jQuery.browser.msie)return false;jQuery(this).bind("mouseover",jQuery.event.special.mouseenter.handler);return true;},teardown:function(){if(jQuery.browser.msie)return false;jQuery(this).unbind("mouseover",jQuery.event.special.mouseenter.handler);return true;},handler:function(event){if(withinElement(event,this))return true;arguments[0].type="mouseenter";return jQuery.event.handle.apply(this,arguments);}},mouseleave:{setup:function(){if(jQuery.browser.msie)return false;jQuery(this).bind("mouseout",jQuery.event.special.mouseleave.handler);return true;},teardown:function(){if(jQuery.browser.msie)return false;jQuery(this).unbind("mouseout",jQuery.event.special.mouseleave.handler);return true;},handler:function(event){if(withinElement(event,this))return true;arguments[0].type="mouseleave";return jQuery.event.handle.apply(this,arguments);}}}};jQuery.fn.extend({bind:function(type,data,fn){return type=="unload"?this.one(type,data,fn):this.each(function(){jQuery.event.add(this,type,fn||data,fn&&data);});},one:function(type,data,fn){return this.each(function(){jQuery.event.add(this,type,function(event){jQuery(this).unbind(event);return(fn||data).apply(this,arguments);},fn&&data);});},unbind:function(type,fn){return this.each(function(){jQuery.event.remove(this,type,fn);});},trigger:function(type,data,fn){return this.each(function(){jQuery.event.trigger(type,data,this,true,fn);});},triggerHandler:function(type,data,fn){if(this[0])return jQuery.event.trigger(type,data,this[0],false,fn);return undefined;},toggle:function(){var args=arguments;return this.click(function(event){this.lastToggle=0==this.lastToggle?1:0;event.preventDefault();return args[this.lastToggle].apply(this,arguments)||false;});},hover:function(fnOver,fnOut){return this.bind('mouseenter',fnOver).bind('mouseleave',fnOut);},ready:function(fn){bindReady();if(jQuery.isReady)fn.call(document,jQuery);else
jQuery.readyList.push(function(){return fn.call(this,jQuery);});return this;}});jQuery.extend({isReady:false,readyList:[],ready:function(){if(!jQuery.isReady){jQuery.isReady=true;if(jQuery.readyList){jQuery.each(jQuery.readyList,function(){this.apply(document);});jQuery.readyList=null;}jQuery(document).triggerHandler("ready");}}});var readyBound=false;function bindReady(){if(readyBound)return;readyBound=true;if(document.addEventListener&&!jQuery.browser.opera)document.addEventListener("DOMContentLoaded",jQuery.ready,false);if(jQuery.browser.msie&&window==top)(function(){if(jQuery.isReady)return;try{document.documentElement.doScroll("left");}catch(error){setTimeout(arguments.callee,0);return;}jQuery.ready();})();if(jQuery.browser.opera)document.addEventListener("DOMContentLoaded",function(){if(jQuery.isReady)return;for(var i=0;i<document.styleSheets.length;i++)if(document.styleSheets[i].disabled){setTimeout(arguments.callee,0);return;}jQuery.ready();},false);if(jQuery.browser.safari){var numStyles;(function(){if(jQuery.isReady)return;if(document.readyState!="loaded"&&document.readyState!="complete"){setTimeout(arguments.callee,0);return;}if(numStyles===undefined)numStyles=jQuery("style, link[rel=stylesheet]").length;if(document.styleSheets.length!=numStyles){setTimeout(arguments.callee,0);return;}jQuery.ready();})();}jQuery.event.add(window,"load",jQuery.ready);}jQuery.each(("blur,focus,load,resize,scroll,unload,click,dblclick,"+"mousedown,mouseup,mousemove,mouseover,mouseout,change,select,"+"submit,keydown,keypress,keyup,error").split(","),function(i,name){jQuery.fn[name]=function(fn){return fn?this.bind(name,fn):this.trigger(name);};});var withinElement=function(event,elem){var parent=event.relatedTarget;while(parent&&parent!=elem)try{parent=parent.parentNode;}catch(error){parent=elem;}return parent==elem;};jQuery(window).bind("unload",function(){jQuery("*").add(document).unbind();});jQuery.fn.extend({load:function(url,params,callback){if(jQuery.isFunction(url))return this.bind("load",url);var off=url.indexOf(" ");if(off>=0){var selector=url.slice(off,url.length);url=url.slice(0,off);}callback=callback||function(){};var type="GET";if(params)if(jQuery.isFunction(params)){callback=params;params=null;}else{params=jQuery.param(params);type="POST";}var self=this;jQuery.ajax({url:url,type:type,dataType:"html",data:params,complete:function(res,status){if(status=="success"||status=="notmodified")self.html(selector?jQuery("<div/>").append(res.responseText.replace(/<script(.|\s)*?\/script>/g,"")).find(selector):res.responseText);self.each(callback,[res.responseText,status,res]);}});return this;},serialize:function(){return jQuery.param(this.serializeArray());},serializeArray:function(){return this.map(function(){return jQuery.nodeName(this,"form")?jQuery.makeArray(this.elements):this;}).filter(function(){return this.name&&!this.disabled&&(this.checked||/select|textarea/i.test(this.nodeName)||/text|hidden|password/i.test(this.type));}).map(function(i,elem){var val=jQuery(this).val();return val==null?null:val.constructor==Array?jQuery.map(val,function(val,i){return{name:elem.name,value:val};}):{name:elem.name,value:val};}).get();}});jQuery.each("ajaxStart,ajaxStop,ajaxComplete,ajaxError,ajaxSuccess,ajaxSend".split(","),function(i,o){jQuery.fn[o]=function(f){return this.bind(o,f);};});var jsc=(new Date).getTime();jQuery.extend({get:function(url,data,callback,type){if(jQuery.isFunction(data)){callback=data;data=null;}return jQuery.ajax({type:"GET",url:url,data:data,success:callback,dataType:type});},getScript:function(url,callback){return jQuery.get(url,null,callback,"script");},getJSON:function(url,data,callback){return jQuery.get(url,data,callback,"json");},post:function(url,data,callback,type){if(jQuery.isFunction(data)){callback=data;data={};}return jQuery.ajax({type:"POST",url:url,data:data,success:callback,dataType:type});},ajaxSetup:function(settings){jQuery.extend(jQuery.ajaxSettings,settings);},ajaxSettings:{global:true,type:"GET",timeout:0,contentType:"application/x-www-form-urlencoded",processData:true,async:true,data:null,username:null,password:null,accepts:{xml:"application/xml, text/xml",html:"text/html",script:"text/javascript, application/javascript",json:"application/json, text/javascript",text:"text/plain",_default:"*/*"}},lastModified:{},ajax:function(s){var jsonp,jsre=/=\?(&|$)/g,status,data;s=jQuery.extend(true,s,jQuery.extend(true,{},jQuery.ajaxSettings,s));if(s.data&&s.processData&&typeof s.data!="string")s.data=jQuery.param(s.data);if(s.dataType=="jsonp"){if(s.type.toLowerCase()=="get"){if(!s.url.match(jsre))s.url+=(s.url.match(/\?/)?"&":"?")+(s.jsonp||"callback")+"=?";}else if(!s.data||!s.data.match(jsre))s.data=(s.data?s.data+"&":"")+(s.jsonp||"callback")+"=?";s.dataType="json";}if(s.dataType=="json"&&(s.data&&s.data.match(jsre)||s.url.match(jsre))){jsonp="jsonp"+jsc++;if(s.data)s.data=(s.data+"").replace(jsre,"="+jsonp+"$1");s.url=s.url.replace(jsre,"="+jsonp+"$1");s.dataType="script";window[jsonp]=function(tmp){data=tmp;success();complete();window[jsonp]=undefined;try{delete window[jsonp];}catch(e){}if(head)head.removeChild(script);};}if(s.dataType=="script"&&s.cache==null)s.cache=false;if(s.cache===false&&s.type.toLowerCase()=="get"){var ts=(new Date()).getTime();var ret=s.url.replace(/(\?|&)_=.*?(&|$)/,"$1_="+ts+"$2");s.url=ret+((ret==s.url)?(s.url.match(/\?/)?"&":"?")+"_="+ts:"");}if(s.data&&s.type.toLowerCase()=="get"){s.url+=(s.url.match(/\?/)?"&":"?")+s.data;s.data=null;}if(s.global&&!jQuery.active++)jQuery.event.trigger("ajaxStart");if((!s.url.indexOf("http")||!s.url.indexOf("//"))&&s.dataType=="script"&&s.type.toLowerCase()=="get"){var head=document.getElementsByTagName("head")[0];var script=document.createElement("script");script.src=s.url;if(s.scriptCharset)script.charset=s.scriptCharset;if(!jsonp){var done=false;script.onload=script.onreadystatechange=function(){if(!done&&(!this.readyState||this.readyState=="loaded"||this.readyState=="complete")){done=true;success();complete();head.removeChild(script);}};}head.appendChild(script);return undefined;}var requestDone=false;var xml=window.ActiveXObject?new ActiveXObject("Microsoft.XMLHTTP"):new XMLHttpRequest();xml.open(s.type,s.url,s.async,s.username,s.password);try{if(s.data)xml.setRequestHeader("Content-Type",s.contentType);if(s.ifModified)xml.setRequestHeader("If-Modified-Since",jQuery.lastModified[s.url]||"Thu, 01 Jan 1970 00:00:00 GMT");xml.setRequestHeader("X-Requested-With","XMLHttpRequest");xml.setRequestHeader("Accept",s.dataType&&s.accepts[s.dataType]?s.accepts[s.dataType]+", */*":s.accepts._default);}catch(e){}if(s.beforeSend)s.beforeSend(xml);if(s.global)jQuery.event.trigger("ajaxSend",[xml,s]);var onreadystatechange=function(isTimeout){if(!requestDone&&xml&&(xml.readyState==4||isTimeout=="timeout")){requestDone=true;if(ival){clearInterval(ival);ival=null;}status=isTimeout=="timeout"&&"timeout"||!jQuery.httpSuccess(xml)&&"error"||s.ifModified&&jQuery.httpNotModified(xml,s.url)&&"notmodified"||"success";if(status=="success"){try{data=jQuery.httpData(xml,s.dataType);}catch(e){status="parsererror";}}if(status=="success"){var modRes;try{modRes=xml.getResponseHeader("Last-Modified");}catch(e){}if(s.ifModified&&modRes)jQuery.lastModified[s.url]=modRes;if(!jsonp)success();}else
jQuery.handleError(s,xml,status);complete();if(s.async)xml=null;}};if(s.async){var ival=setInterval(onreadystatechange,13);if(s.timeout>0)setTimeout(function(){if(xml){xml.abort();if(!requestDone)onreadystatechange("timeout");}},s.timeout);}try{xml.send(s.data);}catch(e){jQuery.handleError(s,xml,null,e);}if(!s.async)onreadystatechange();function success(){if(s.success)s.success(data,status);if(s.global)jQuery.event.trigger("ajaxSuccess",[xml,s]);}function complete(){if(s.complete)s.complete(xml,status);if(s.global)jQuery.event.trigger("ajaxComplete",[xml,s]);if(s.global&&!--jQuery.active)jQuery.event.trigger("ajaxStop");}return xml;},handleError:function(s,xml,status,e){if(s.error)s.error(xml,status,e);if(s.global)jQuery.event.trigger("ajaxError",[xml,s,e]);},active:0,httpSuccess:function(r){try{return!r.status&&location.protocol=="file:"||(r.status>=200&&r.status<300)||r.status==304||r.status==1223||jQuery.browser.safari&&r.status==undefined;}catch(e){}return false;},httpNotModified:function(xml,url){try{var xmlRes=xml.getResponseHeader("Last-Modified");return xml.status==304||xmlRes==jQuery.lastModified[url]||jQuery.browser.safari&&xml.status==undefined;}catch(e){}return false;},httpData:function(r,type){var ct=r.getResponseHeader("content-type");var xml=type=="xml"||!type&&ct&&ct.indexOf("xml")>=0;var data=xml?r.responseXML:r.responseText;if(xml&&data.documentElement.tagName=="parsererror")throw"parsererror";if(type=="script")jQuery.globalEval(data);if(type=="json")data=eval("("+data+")");return data;},param:function(a){var s=[];if(a.constructor==Array||a.jquery)jQuery.each(a,function(){s.push(encodeURIComponent(this.name)+"="+encodeURIComponent(this.value));});else
for(var j in a)if(a[j]&&a[j].constructor==Array)jQuery.each(a[j],function(){s.push(encodeURIComponent(j)+"="+encodeURIComponent(this));});else
s.push(encodeURIComponent(j)+"="+encodeURIComponent(a[j]));return s.join("&").replace(/%20/g,"+");}});jQuery.fn.extend({show:function(speed,callback){return speed?this.animate({height:"show",width:"show",opacity:"show"},speed,callback):this.filter(":hidden").each(function(){this.style.display=this.oldblock||"";if(jQuery.css(this,"display")=="none"){var elem=jQuery("<"+this.tagName+" />").appendTo("body");this.style.display=elem.css("display");if(this.style.display=="none")this.style.display="block";elem.remove();}}).end();},hide:function(speed,callback){return speed?this.animate({height:"hide",width:"hide",opacity:"hide"},speed,callback):this.filter(":visible").each(function(){this.oldblock=this.oldblock||jQuery.css(this,"display");this.style.display="none";}).end();},_toggle:jQuery.fn.toggle,toggle:function(fn,fn2){return jQuery.isFunction(fn)&&jQuery.isFunction(fn2)?this._toggle(fn,fn2):fn?this.animate({height:"toggle",width:"toggle",opacity:"toggle"},fn,fn2):this.each(function(){jQuery(this)[jQuery(this).is(":hidden")?"show":"hide"]();});},slideDown:function(speed,callback){return this.animate({height:"show"},speed,callback);},slideUp:function(speed,callback){return this.animate({height:"hide"},speed,callback);},slideToggle:function(speed,callback){return this.animate({height:"toggle"},speed,callback);},fadeIn:function(speed,callback){return this.animate({opacity:"show"},speed,callback);},fadeOut:function(speed,callback){return this.animate({opacity:"hide"},speed,callback);},fadeTo:function(speed,to,callback){return this.animate({opacity:to},speed,callback);},animate:function(prop,speed,easing,callback){var optall=jQuery.speed(speed,easing,callback);return this[optall.queue===false?"each":"queue"](function(){if(this.nodeType!=1)return false;var opt=jQuery.extend({},optall);var hidden=jQuery(this).is(":hidden"),self=this;for(var p in prop){if(prop[p]=="hide"&&hidden||prop[p]=="show"&&!hidden)return jQuery.isFunction(opt.complete)&&opt.complete.apply(this);if(p=="height"||p=="width"){opt.display=jQuery.css(this,"display");opt.overflow=this.style.overflow;}}if(opt.overflow!=null)this.style.overflow="hidden";opt.curAnim=jQuery.extend({},prop);jQuery.each(prop,function(name,val){var e=new jQuery.fx(self,opt,name);if(/toggle|show|hide/.test(val))e[val=="toggle"?hidden?"show":"hide":val](prop);else{var parts=val.toString().match(/^([+-]=)?([\d+-.]+)(.*)$/),start=e.cur(true)||0;if(parts){var end=parseFloat(parts[2]),unit=parts[3]||"px";if(unit!="px"){self.style[name]=(end||1)+unit;start=((end||1)/e.cur(true))*start;self.style[name]=start+unit;}if(parts[1])end=((parts[1]=="-="?-1:1)*end)+start;e.custom(start,end,unit);}else
e.custom(start,val,"");}});return true;});},queue:function(type,fn){if(jQuery.isFunction(type)||(type&&type.constructor==Array)){fn=type;type="fx";}if(!type||(typeof type=="string"&&!fn))return queue(this[0],type);return this.each(function(){if(fn.constructor==Array)queue(this,type,fn);else{queue(this,type).push(fn);if(queue(this,type).length==1)fn.apply(this);}});},stop:function(clearQueue,gotoEnd){var timers=jQuery.timers;if(clearQueue)this.queue([]);this.each(function(){for(var i=timers.length-1;i>=0;i--)if(timers[i].elem==this){if(gotoEnd)timers[i](true);timers.splice(i,1);}});if(!gotoEnd)this.dequeue();return this;}});var queue=function(elem,type,array){if(!elem)return undefined;type=type||"fx";var q=jQuery.data(elem,type+"queue");if(!q||array)q=jQuery.data(elem,type+"queue",array?jQuery.makeArray(array):[]);return q;};jQuery.fn.dequeue=function(type){type=type||"fx";return this.each(function(){var q=queue(this,type);q.shift();if(q.length)q[0].apply(this);});};jQuery.extend({speed:function(speed,easing,fn){var opt=speed&&speed.constructor==Object?speed:{complete:fn||!fn&&easing||jQuery.isFunction(speed)&&speed,duration:speed,easing:fn&&easing||easing&&easing.constructor!=Function&&easing};opt.duration=(opt.duration&&opt.duration.constructor==Number?opt.duration:{slow:600,fast:200}[opt.duration])||400;opt.old=opt.complete;opt.complete=function(){if(opt.queue!==false)jQuery(this).dequeue();if(jQuery.isFunction(opt.old))opt.old.apply(this);};return opt;},easing:{linear:function(p,n,firstNum,diff){return firstNum+diff*p;},swing:function(p,n,firstNum,diff){return((-Math.cos(p*Math.PI)/2)+0.5)*diff+firstNum;}},timers:[],timerId:null,fx:function(elem,options,prop){this.options=options;this.elem=elem;this.prop=prop;if(!options.orig)options.orig={};}});jQuery.fx.prototype={update:function(){if(this.options.step)this.options.step.apply(this.elem,[this.now,this]);(jQuery.fx.step[this.prop]||jQuery.fx.step._default)(this);if(this.prop=="height"||this.prop=="width")this.elem.style.display="block";},cur:function(force){if(this.elem[this.prop]!=null&&this.elem.style[this.prop]==null)return this.elem[this.prop];var r=parseFloat(jQuery.css(this.elem,this.prop,force));return r&&r>-10000?r:parseFloat(jQuery.curCSS(this.elem,this.prop))||0;},custom:function(from,to,unit){this.startTime=(new Date()).getTime();this.start=from;this.end=to;this.unit=unit||this.unit||"px";this.now=this.start;this.pos=this.state=0;this.update();var self=this;function t(gotoEnd){return self.step(gotoEnd);}t.elem=this.elem;jQuery.timers.push(t);if(jQuery.timerId==null){jQuery.timerId=setInterval(function(){var timers=jQuery.timers;for(var i=0;i<timers.length;i++)if(!timers[i]())timers.splice(i--,1);if(!timers.length){clearInterval(jQuery.timerId);jQuery.timerId=null;}},13);}},show:function(){this.options.orig[this.prop]=jQuery.attr(this.elem.style,this.prop);this.options.show=true;this.custom(0,this.cur());if(this.prop=="width"||this.prop=="height")this.elem.style[this.prop]="1px";jQuery(this.elem).show();},hide:function(){this.options.orig[this.prop]=jQuery.attr(this.elem.style,this.prop);this.options.hide=true;this.custom(this.cur(),0);},step:function(gotoEnd){var t=(new Date()).getTime();if(gotoEnd||t>this.options.duration+this.startTime){this.now=this.end;this.pos=this.state=1;this.update();this.options.curAnim[this.prop]=true;var done=true;for(var i in this.options.curAnim)if(this.options.curAnim[i]!==true)done=false;if(done){if(this.options.display!=null){this.elem.style.overflow=this.options.overflow;this.elem.style.display=this.options.display;if(jQuery.css(this.elem,"display")=="none")this.elem.style.display="block";}if(this.options.hide)this.elem.style.display="none";if(this.options.hide||this.options.show)for(var p in this.options.curAnim)jQuery.attr(this.elem.style,p,this.options.orig[p]);}if(done&&jQuery.isFunction(this.options.complete))this.options.complete.apply(this.elem);return false;}else{var n=t-this.startTime;this.state=n/this.options.duration;this.pos=jQuery.easing[this.options.easing||(jQuery.easing.swing?"swing":"linear")](this.state,n,0,1,this.options.duration);this.now=this.start+((this.end-this.start)*this.pos);this.update();}return true;}};jQuery.fx.step={scrollLeft:function(fx){fx.elem.scrollLeft=fx.now;},scrollTop:function(fx){fx.elem.scrollTop=fx.now;},opacity:function(fx){jQuery.attr(fx.elem.style,"opacity",fx.now);},_default:function(fx){fx.elem.style[fx.prop]=fx.now+fx.unit;}};jQuery.fn.offset=function(){var left=0,top=0,elem=this[0],results;if(elem)with(jQuery.browser){var parent=elem.parentNode,offsetChild=elem,offsetParent=elem.offsetParent,doc=elem.ownerDocument,safari2=safari&&parseInt(version)<522&&!/adobeair/i.test(userAgent),fixed=jQuery.css(elem,"position")=="fixed";if(elem.getBoundingClientRect){var box=elem.getBoundingClientRect();add(box.left+Math.max(doc.documentElement.scrollLeft,doc.body.scrollLeft),box.top+Math.max(doc.documentElement.scrollTop,doc.body.scrollTop));add(-doc.documentElement.clientLeft,-doc.documentElement.clientTop);}else{add(elem.offsetLeft,elem.offsetTop);while(offsetParent){add(offsetParent.offsetLeft,offsetParent.offsetTop);if(mozilla&&!/^t(able|d|h)$/i.test(offsetParent.tagName)||safari&&!safari2)border(offsetParent);if(!fixed&&jQuery.css(offsetParent,"position")=="fixed")fixed=true;offsetChild=/^body$/i.test(offsetParent.tagName)?offsetChild:offsetParent;offsetParent=offsetParent.offsetParent;}while(parent&&parent.tagName&&!/^body|html$/i.test(parent.tagName)){if(!/^inline|table.*$/i.test(jQuery.css(parent,"display")))add(-parent.scrollLeft,-parent.scrollTop);if(mozilla&&jQuery.css(parent,"overflow")!="visible")border(parent);parent=parent.parentNode;}if((safari2&&(fixed||jQuery.css(offsetChild,"position")=="absolute"))||(mozilla&&jQuery.css(offsetChild,"position")!="absolute"))add(-doc.body.offsetLeft,-doc.body.offsetTop);if(fixed)add(Math.max(doc.documentElement.scrollLeft,doc.body.scrollLeft),Math.max(doc.documentElement.scrollTop,doc.body.scrollTop));}results={top:top,left:left};}function border(elem){add(jQuery.curCSS(elem,"borderLeftWidth",true),jQuery.curCSS(elem,"borderTopWidth",true));}function add(l,t){left+=parseInt(l)||0;top+=parseInt(t)||0;}return results;};})();
__theme/oscon2008/javascript/jquery.corner.js__
/*
 * jQuery corner plugin
 *
 * version 1.7 (1/26/2007)
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */

/**
 * The corner() method provides a simple way of styling DOM elements.  
 *
 * corner() takes a single string argument:  $().corner("effect corners width")
 *
 *   effect:  The name of the effect to apply, such as round or bevel. 
 *            If you don't specify an effect, rounding is used.
 *
 *   corners: The corners can be one or more of top, bottom, tr, tl, br, or bl. 
 *            By default, all four corners are adorned. 
 *
 *   width:   The width specifies the width of the effect; in the case of rounded corners this 
 *            will be the radius of the width. 
 *            Specify this value using the px suffix such as 10px, and yes it must be pixels.
 *
 * For more details see: http://methvin.com/jquery/jq-corner.html
 * For a full demo see:  http://malsup.com/jquery/corner/
 *
 *
 * @example $('.adorn').corner();
 * @desc Create round, 10px corners 
 *
 * @example $('.adorn').corner("25px");
 * @desc Create round, 25px corners 
 *
 * @example $('.adorn').corner("notch bottom");
 * @desc Create notched, 10px corners on bottom only
 *
 * @example $('.adorn').corner("tr dog 25px");
 * @desc Create dogeared, 25px corner on the top-right corner only
 *
 * @example $('.adorn').corner("round 8px").parent().css('padding', '4px').corner("round 10px");
 * @desc Create a rounded border effect by styling both the element and its parent
 * 
 * @name corner
 * @type jQuery
 * @param String options Options which control the corner style
 * @cat Plugins/Corner
 * @return jQuery
 * @author Dave Methvin (dave.methvin@gmail.com)
 * @author Mike Alsup (malsup@gmail.com)
 */
jQuery.fn.corner = function(o) {
    function hex2(s) {
        var s = parseInt(s).toString(16);
        return ( s.length < 2 ) ? '0'+s : s;
    };
    function gpc(node) {
        for ( ; node && node.nodeName.toLowerCase() != 'html'; node = node.parentNode  ) {
            var v = jQuery.css(node,'backgroundColor');
            if ( v.indexOf('rgb') >= 0 ) { 
                rgb = v.match(/\d+/g); 
                return '#'+ hex2(rgb[0]) + hex2(rgb[1]) + hex2(rgb[2]);
            }
            if ( v && v != 'transparent' )
                return v;
        }
        return '#ffffff';
    };
    function getW(i) {
        switch(fx) {
        case 'round':  return Math.round(width*(1-Math.cos(Math.asin(i/width))));
        case 'cool':   return Math.round(width*(1+Math.cos(Math.asin(i/width))));
        case 'sharp':  return Math.round(width*(1-Math.cos(Math.acos(i/width))));
        case 'bite':   return Math.round(width*(Math.cos(Math.asin((width-i-1)/width))));
        case 'slide':  return Math.round(width*(Math.atan2(i,width/i)));
        case 'jut':    return Math.round(width*(Math.atan2(width,(width-i-1))));
        case 'curl':   return Math.round(width*(Math.atan(i)));
        case 'tear':   return Math.round(width*(Math.cos(i)));
        case 'wicked': return Math.round(width*(Math.tan(i)));
        case 'long':   return Math.round(width*(Math.sqrt(i)));
        case 'sculpt': return Math.round(width*(Math.log((width-i-1),width)));
        case 'dog':    return (i&1) ? (i+1) : width;
        case 'dog2':   return (i&2) ? (i+1) : width;
        case 'dog3':   return (i&3) ? (i+1) : width;
        case 'fray':   return (i%2)*width;
        case 'notch':  return width; 
        case 'bevel':  return i+1;
        }
    };
    o = (o||"").toLowerCase();
    var keep = /keep/.test(o);                       // keep borders?
    var cc = ((o.match(/cc:(#[0-9a-f]+)/)||[])[1]);  // corner color
    var sc = ((o.match(/sc:(#[0-9a-f]+)/)||[])[1]);  // strip color
    var width = parseInt((o.match(/(\d+)px/)||[])[1]) || 10; // corner width
    var re = /round|bevel|notch|bite|cool|sharp|slide|jut|curl|tear|fray|wicked|sculpt|long|dog3|dog2|dog/;
    var fx = ((o.match(re)||['round'])[0]);
    var edges = { T:0, B:1 };
    var opts = {
        TL:  /top|tl/.test(o),       TR:  /top|tr/.test(o),
        BL:  /bottom|bl/.test(o),    BR:  /bottom|br/.test(o)
    };
    if ( !opts.TL && !opts.TR && !opts.BL && !opts.BR )
        opts = { TL:1, TR:1, BL:1, BR:1 };
    var strip = document.createElement('div');
    strip.style.overflow = 'hidden';
    strip.style.height = '1px';
    strip.style.backgroundColor = sc || 'transparent';
    strip.style.borderStyle = 'solid';
    return this.each(function(index){
        var pad = {
            T: parseInt(jQuery.css(this,'paddingTop'))||0,     R: parseInt(jQuery.css(this,'paddingRight'))||0,
            B: parseInt(jQuery.css(this,'paddingBottom'))||0,  L: parseInt(jQuery.css(this,'paddingLeft'))||0
        };

        if (jQuery.browser.msie) this.style.zoom = 1; // force 'hasLayout' in IE
        if (!keep) this.style.border = 'none';
        strip.style.borderColor = cc || gpc(this.parentNode);
        var cssHeight = jQuery.curCSS(this, 'height');

        for (var j in edges) {
            var bot = edges[j];
            strip.style.borderStyle = 'none '+(opts[j+'R']?'solid':'none')+' none '+(opts[j+'L']?'solid':'none');
            var d = document.createElement('div');
            var ds = d.style;

            bot ? this.appendChild(d) : this.insertBefore(d, this.firstChild);

            if (bot && cssHeight != 'auto') {
                if (jQuery.css(this,'position') == 'static')
                    this.style.position = 'relative';
                ds.position = 'absolute';
                ds.bottom = ds.left = ds.padding = ds.margin = '0';
                if (jQuery.browser.msie)
                    ds.setExpression('width', 'this.parentNode.offsetWidth');
                else
                    ds.width = '100%';
            }
            else {
                ds.margin = !bot ? '-'+pad.T+'px -'+pad.R+'px '+(pad.T-width)+'px -'+pad.L+'px' : 
                                    (pad.B-width)+'px -'+pad.R+'px -'+pad.B+'px -'+pad.L+'px';                
            }

            for (var i=0; i < width; i++) {
                var w = Math.max(0,getW(i));
                var e = strip.cloneNode(false);
                e.style.borderWidth = '0 '+(opts[j+'R']?w:0)+'px 0 '+(opts[j+'L']?w:0)+'px';
                bot ? d.appendChild(e) : d.insertBefore(e, d.firstChild);
            }
        }
    });
};
__theme/oscon2008/javascript/oscon2008.js__
jQuery(function() {
    jQuery("#mid").corner();
    jQuery("#footer").corner("top");

});

__theme/oscon2008/images/oscon2008.jpg__
/9j/4AAQSkZJRgABAgEASABIAAD/4QgiRXhpZgAATU0AKgAAAAgABwESAAMAAAABAAEAAAEaAAUA
AAABAAAAYgEbAAUAAAABAAAAagEoAAMAAAABAAIAAAExAAIAAAAeAAAAcgEyAAIAAAAUAAAAkIdp
AAQAAAABAAAApAAAANAACvyAAAAnEAAK/IAAACcQQWRvYmUgUGhvdG9zaG9wIENTMyBNYWNpbnRv
c2gAMjAwODowMjoxNSAxMDowNzoxOQAAA6ABAAMAAAAB//8AAKACAAQAAAABAAADjqADAAQAAAAB
AAAAfQAAAAAAAAAGAQMAAwAAAAEABgAAARoABQAAAAEAAAEeARsABQAAAAEAAAEmASgAAwAAAAEA
AgAAAgEABAAAAAEAAAEuAgIABAAAAAEAAAbsAAAAAAAAAEgAAAABAAAASAAAAAH/2P/gABBKRklG
AAECAABIAEgAAP/tAAxBZG9iZV9DTQAC/+4ADkFkb2JlAGSAAAAAAf/bAIQADAgICAkIDAkJDBEL
CgsRFQ8MDA8VGBMTFRMTGBEMDAwMDAwRDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAENCwsN
Dg0QDg4QFA4ODhQUDg4ODhQRDAwMDAwREQwMDAwMDBEMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM
DAwM/8AAEQgAFgCgAwEiAAIRAQMRAf/dAAQACv/EAT8AAAEFAQEBAQEBAAAAAAAAAAMAAQIEBQYH
CAkKCwEAAQUBAQEBAQEAAAAAAAAAAQACAwQFBgcICQoLEAABBAEDAgQCBQcGCAUDDDMBAAIRAwQh
EjEFQVFhEyJxgTIGFJGhsUIjJBVSwWIzNHKC0UMHJZJT8OHxY3M1FqKygyZEk1RkRcKjdDYX0lXi
ZfKzhMPTdePzRieUpIW0lcTU5PSltcXV5fVWZnaGlqa2xtbm9jdHV2d3h5ent8fX5/cRAAICAQIE
BAMEBQYHBwYFNQEAAhEDITESBEFRYXEiEwUygZEUobFCI8FS0fAzJGLhcoKSQ1MVY3M08SUGFqKy
gwcmNcLSRJNUoxdkRVU2dGXi8rOEw9N14/NGlKSFtJXE1OT0pbXF1eX1VmZ2hpamtsbW5vYnN0dX
Z3eHl6e3x//aAAwDAQACEQMRAD8A56irELLTkXDHFbJrGgBMO/e+ns21t9Bn6W31f+CVt2D0QtBr
6o33Fu31NrRBdW27sPdWx19rP9N6bEfo8sbmfZTS3qxbT9gdeah7d5+3fZTm/qn2z0/R2er7/R9f
0Vp0WY5fkVizDxcm3Fq/aXUaTiPZXkBt3r1nDyQ+rIxbWvxftv7J2f5Q/m960JkgnwacIggbavLZ
AxWPbXRY6xwa11hJbAcWtc6uv0/p+k/fV6v+F/nGIIewgkOBA5MjRdMLMP1cT1HYrfqmHYpfU443
rh22oXtubH7T+1fa9/2/9/B9X/BouFe6u6izr7un25db7Dghn2ZzPSbi5hcMj7Dtq/Zz8n7H9jZk
frPq/wA2lx0Nk+34vKyJidfBIiQR46LV6r+zR0zAs6a9gqy7cm9+MCHW0NcMTZhZLoFjvs2QzJbi
vf8AzlH6RZSfE2L2Y5CjTpt+sGSyvYKKJ9oa/bBa1gaGNbt/O9v6S3+cs/61WpU9fdQw1swcYtc5
zpIcbAXuda+Lv61j2N9n8x+h/wCEWUnAS4I9lcZ7ujR1l9GKMSvGqNTQ5rXu1sAJJb+kjb7d3v21
/pP0n836iWX1izKo9B2LRW31G272gl4LTOxtjyf0dn+Eb/pP0ypVM3uIHZFGLrHMODo+KcMYOtLT
kI6pMbPGPW+v7NXYLHOc9zid3vBq9sfze2l72/8AGfp/8Go/tK2Lpqrcb9odIhu1tL8TZsZs+m2z
1Xvb6b/VQzT7YGhcTr89UJwhxbGg5PZIwA6KEyerbd1Td9mLsdoOJYyyra4iQxtdb6nuj1Nlnose
33/oVK/rVt+JZiux6WixjWGwA7htNbtzfzWud6P+Z+j/AMCqBCZDhHZPEVJJwE4Y907Wl0cwJSKl
lJoT+jYCN0Nkx7nAQR9KRO72olbKQf0lwjT6DS4mR57UOIefl6v+inhPXT+96f8ApM6myrbKg4QQ
CDoQeCCh0Nr0hr3TxOgWkyp7Wz6QZzqSSePNSxkBXj3MQxSiTddOwkX/0KGE69nrmhtFlcN9duTs
9Pb79m/131s2bv3/AGer6P8Ah/s6Tn5oe+GdMLdjN8DE9GNz/S+jb6Hq7vU/4T/ra85SWpk3Ozn4
9hu+g+pn72mqvp/qe4gY4x/U2ljt7f1e37R6Dat3/oxSbZmyfTr6PJI4GBzPt2/pV54ko/8AFZP8
Z7jqbslzmfaG4jX7nT9l9HdPt3faPsr7LP6nr/8AW1SXKJKSO3T6LJb/AMXq1NsLkUk4LC91iCku
JcdsCXgcnwbp+ctMklmgAbGm2ONfpQvMkk3Lt/Lh/wDR2TBv/D5/8L/Vvo9/pbot89R9KPztizbm
1FpJcAwGGjXUfvO2hcUkhD5Tv/3Kc1ccdvx4/wDC/wC5exLKAzWzc7SAwe2Pi+HKJdREMrM/vPcT
/wBGtrVyCSX97i/l/s0f3eD+X+1e4xxc4k0mpgMSBBjw/nN3/S/PTX12B/6e2wugzDT9H8FxCSi1
4tK26cPH/hWyiuHW9+vH7f04fS9iHYbDox1nb3EAf1tEeix7nH0Kq2P0kyDp5bz/AJy4dJE1R3v+
vxcP+F+gtF30r/V8PF/g/pvoLTlSN4I1/N+f7qt1TGs/NeZpK1g2/R/wWrzG/wCl/hv/2f/tJPxQ
aG90b3Nob3AgMy4wADhCSU0EBAAAAAAABxwCAAACAAAAOEJJTQQlAAAAAAAQ6PFc8y/BGKGie2et
xWTVujhCSU0D6gAAAAAYEDw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9IlVURi04Ij8+Cjwh
RE9DVFlQRSBwbGlzdCBQVUJMSUMgIi0vL0FwcGxlLy9EVEQgUExJU1QgMS4wLy9FTiIgImh0dHA6
Ly93d3cuYXBwbGUuY29tL0RURHMvUHJvcGVydHlMaXN0LTEuMC5kdGQiPgo8cGxpc3QgdmVyc2lv
bj0iMS4wIj4KPGRpY3Q+Cgk8a2V5PmNvbS5hcHBsZS5wcmludC5QYWdlRm9ybWF0LlBNSG9yaXpv
bnRhbFJlczwva2V5PgoJPGRpY3Q+CgkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LmNyZWF0
b3I8L2tleT4KCQk8c3RyaW5nPmNvbS5hcHBsZS5qb2J0aWNrZXQ8L3N0cmluZz4KCQk8a2V5PmNv
bS5hcHBsZS5wcmludC50aWNrZXQuaXRlbUFycmF5PC9rZXk+CgkJPGFycmF5PgoJCQk8ZGljdD4K
CQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LlBhZ2VGb3JtYXQuUE1Ib3Jpem9udGFsUmVzPC9rZXk+
CgkJCQk8cmVhbD43MjwvcmVhbD4KCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5zdGF0
ZUZsYWc8L2tleT4KCQkJCTxpbnRlZ2VyPjA8L2ludGVnZXI+CgkJCTwvZGljdD4KCQk8L2FycmF5
PgoJPC9kaWN0PgoJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTU9yaWVudGF0aW9u
PC9rZXk+Cgk8ZGljdD4KCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5
PgoJCTxzdHJpbmc+Y29tLmFwcGxlLmpvYnRpY2tldDwvc3RyaW5nPgoJCTxrZXk+Y29tLmFwcGxl
LnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tleT4KCQk8YXJyYXk+CgkJCTxkaWN0PgoJCQkJPGtl
eT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTU9yaWVudGF0aW9uPC9rZXk+CgkJCQk8aW50
ZWdlcj4xPC9pbnRlZ2VyPgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxh
Zzwva2V5PgoJCQkJPGludGVnZXI+MDwvaW50ZWdlcj4KCQkJPC9kaWN0PgoJCTwvYXJyYXk+Cgk8
L2RpY3Q+Cgk8a2V5PmNvbS5hcHBsZS5wcmludC5QYWdlRm9ybWF0LlBNU2NhbGluZzwva2V5PgoJ
PGRpY3Q+CgkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LmNyZWF0b3I8L2tleT4KCQk8c3Ry
aW5nPmNvbS5hcHBsZS5qb2J0aWNrZXQ8L3N0cmluZz4KCQk8a2V5PmNvbS5hcHBsZS5wcmludC50
aWNrZXQuaXRlbUFycmF5PC9rZXk+CgkJPGFycmF5PgoJCQk8ZGljdD4KCQkJCTxrZXk+Y29tLmFw
cGxlLnByaW50LlBhZ2VGb3JtYXQuUE1TY2FsaW5nPC9rZXk+CgkJCQk8cmVhbD4xPC9yZWFsPgoJ
CQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJPGludGVn
ZXI+MDwvaW50ZWdlcj4KCQkJPC9kaWN0PgoJCTwvYXJyYXk+Cgk8L2RpY3Q+Cgk8a2V5PmNvbS5h
cHBsZS5wcmludC5QYWdlRm9ybWF0LlBNVmVydGljYWxSZXM8L2tleT4KCTxkaWN0PgoJCTxrZXk+
Y29tLmFwcGxlLnByaW50LnRpY2tldC5jcmVhdG9yPC9rZXk+CgkJPHN0cmluZz5jb20uYXBwbGUu
am9idGlja2V0PC9zdHJpbmc+CgkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lml0ZW1BcnJh
eTwva2V5PgoJCTxhcnJheT4KCQkJPGRpY3Q+CgkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC5QYWdl
Rm9ybWF0LlBNVmVydGljYWxSZXM8L2tleT4KCQkJCTxyZWFsPjcyPC9yZWFsPgoJCQkJPGtleT5j
b20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJPGludGVnZXI+MDwvaW50
ZWdlcj4KCQkJPC9kaWN0PgoJCTwvYXJyYXk+Cgk8L2RpY3Q+Cgk8a2V5PmNvbS5hcHBsZS5wcmlu
dC5QYWdlRm9ybWF0LlBNVmVydGljYWxTY2FsaW5nPC9rZXk+Cgk8ZGljdD4KCQk8a2V5PmNvbS5h
cHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCTxzdHJpbmc+Y29tLmFwcGxlLmpvYnRp
Y2tldDwvc3RyaW5nPgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tl
eT4KCQk8YXJyYXk+CgkJCTxkaWN0PgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1h
dC5QTVZlcnRpY2FsU2NhbGluZzwva2V5PgoJCQkJPHJlYWw+MTwvcmVhbD4KCQkJCTxrZXk+Y29t
LmFwcGxlLnByaW50LnRpY2tldC5zdGF0ZUZsYWc8L2tleT4KCQkJCTxpbnRlZ2VyPjA8L2ludGVn
ZXI+CgkJCTwvZGljdD4KCQk8L2FycmF5PgoJPC9kaWN0PgoJPGtleT5jb20uYXBwbGUucHJpbnQu
c3ViVGlja2V0LnBhcGVyX2luZm9fdGlja2V0PC9rZXk+Cgk8ZGljdD4KCQk8a2V5PlBNUFBEUGFw
ZXJDb2RlTmFtZTwva2V5PgoJCTxkaWN0PgoJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQu
Y3JlYXRvcjwva2V5PgoJCQk8c3RyaW5nPmNvbS5hcHBsZS5qb2J0aWNrZXQ8L3N0cmluZz4KCQkJ
PGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lml0ZW1BcnJheTwva2V5PgoJCQk8YXJyYXk+CgkJ
CQk8ZGljdD4KCQkJCQk8a2V5PlBNUFBEUGFwZXJDb2RlTmFtZTwva2V5PgoJCQkJCTxzdHJpbmc+
TGV0dGVyPC9zdHJpbmc+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxh
Zzwva2V5PgoJCQkJCTxpbnRlZ2VyPjA8L2ludGVnZXI+CgkJCQk8L2RpY3Q+CgkJCTwvYXJyYXk+
CgkJPC9kaWN0PgoJCTxrZXk+UE1UaW9nYVBhcGVyTmFtZTwva2V5PgoJCTxkaWN0PgoJCQk8a2V5
PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCQk8c3RyaW5nPmNvbS5hcHBs
ZS5qb2J0aWNrZXQ8L3N0cmluZz4KCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lml0ZW1B
cnJheTwva2V5PgoJCQk8YXJyYXk+CgkJCQk8ZGljdD4KCQkJCQk8a2V5PlBNVGlvZ2FQYXBlck5h
bWU8L2tleT4KCQkJCQk8c3RyaW5nPm5hLWxldHRlcjwvc3RyaW5nPgoJCQkJCTxrZXk+Y29tLmFw
cGxlLnByaW50LnRpY2tldC5zdGF0ZUZsYWc8L2tleT4KCQkJCQk8aW50ZWdlcj4wPC9pbnRlZ2Vy
PgoJCQkJPC9kaWN0PgoJCQk8L2FycmF5PgoJCTwvZGljdD4KCQk8a2V5PmNvbS5hcHBsZS5wcmlu
dC5QYWdlRm9ybWF0LlBNQWRqdXN0ZWRQYWdlUmVjdDwva2V5PgoJCTxkaWN0PgoJCQk8a2V5PmNv
bS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCQk8c3RyaW5nPmNvbS5hcHBsZS5q
b2J0aWNrZXQ8L3N0cmluZz4KCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lml0ZW1BcnJh
eTwva2V5PgoJCQk8YXJyYXk+CgkJCQk8ZGljdD4KCQkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC5Q
YWdlRm9ybWF0LlBNQWRqdXN0ZWRQYWdlUmVjdDwva2V5PgoJCQkJCTxhcnJheT4KCQkJCQkJPHJl
YWw+MC4wPC9yZWFsPgoJCQkJCQk8cmVhbD4wLjA8L3JlYWw+CgkJCQkJCTxyZWFsPjczNDwvcmVh
bD4KCQkJCQkJPHJlYWw+NTc2PC9yZWFsPgoJCQkJCTwvYXJyYXk+CgkJCQkJPGtleT5jb20uYXBw
bGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJCTxpbnRlZ2VyPjA8L2ludGVnZXI+
CgkJCQk8L2RpY3Q+CgkJCTwvYXJyYXk+CgkJPC9kaWN0PgoJCTxrZXk+Y29tLmFwcGxlLnByaW50
LlBhZ2VGb3JtYXQuUE1BZGp1c3RlZFBhcGVyUmVjdDwva2V5PgoJCTxkaWN0PgoJCQk8a2V5PmNv
bS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCQk8c3RyaW5nPmNvbS5hcHBsZS5q
b2J0aWNrZXQ8L3N0cmluZz4KCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lml0ZW1BcnJh
eTwva2V5PgoJCQk8YXJyYXk+CgkJCQk8ZGljdD4KCQkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC5Q
YWdlRm9ybWF0LlBNQWRqdXN0ZWRQYXBlclJlY3Q8L2tleT4KCQkJCQk8YXJyYXk+CgkJCQkJCTxy
ZWFsPi0xODwvcmVhbD4KCQkJCQkJPHJlYWw+LTE4PC9yZWFsPgoJCQkJCQk8cmVhbD43NzQ8L3Jl
YWw+CgkJCQkJCTxyZWFsPjU5NDwvcmVhbD4KCQkJCQk8L2FycmF5PgoJCQkJCTxrZXk+Y29tLmFw
cGxlLnByaW50LnRpY2tldC5zdGF0ZUZsYWc8L2tleT4KCQkJCQk8aW50ZWdlcj4wPC9pbnRlZ2Vy
PgoJCQkJPC9kaWN0PgoJCQk8L2FycmF5PgoJCTwvZGljdD4KCQk8a2V5PmNvbS5hcHBsZS5wcmlu
dC5QYXBlckluZm8uUE1QYXBlck5hbWU8L2tleT4KCQk8ZGljdD4KCQkJPGtleT5jb20uYXBwbGUu
cHJpbnQudGlja2V0LmNyZWF0b3I8L2tleT4KCQkJPHN0cmluZz5jb20uYXBwbGUuam9idGlja2V0
PC9zdHJpbmc+CgkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tleT4K
CQkJPGFycmF5PgoJCQkJPGRpY3Q+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFwZXJJbmZv
LlBNUGFwZXJOYW1lPC9rZXk+CgkJCQkJPHN0cmluZz5uYS1sZXR0ZXI8L3N0cmluZz4KCQkJCQk8
a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuc3RhdGVGbGFnPC9rZXk+CgkJCQkJPGludGVnZXI+
MDwvaW50ZWdlcj4KCQkJCTwvZGljdD4KCQkJPC9hcnJheT4KCQk8L2RpY3Q+CgkJPGtleT5jb20u
YXBwbGUucHJpbnQuUGFwZXJJbmZvLlBNVW5hZGp1c3RlZFBhZ2VSZWN0PC9rZXk+CgkJPGRpY3Q+
CgkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5jcmVhdG9yPC9rZXk+CgkJCTxzdHJpbmc+
Y29tLmFwcGxlLmpvYnRpY2tldDwvc3RyaW5nPgoJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNr
ZXQuaXRlbUFycmF5PC9rZXk+CgkJCTxhcnJheT4KCQkJCTxkaWN0PgoJCQkJCTxrZXk+Y29tLmFw
cGxlLnByaW50LlBhcGVySW5mby5QTVVuYWRqdXN0ZWRQYWdlUmVjdDwva2V5PgoJCQkJCTxhcnJh
eT4KCQkJCQkJPHJlYWw+MC4wPC9yZWFsPgoJCQkJCQk8cmVhbD4wLjA8L3JlYWw+CgkJCQkJCTxy
ZWFsPjczNDwvcmVhbD4KCQkJCQkJPHJlYWw+NTc2PC9yZWFsPgoJCQkJCTwvYXJyYXk+CgkJCQkJ
PGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJCTxpbnRlZ2Vy
PjA8L2ludGVnZXI+CgkJCQk8L2RpY3Q+CgkJCTwvYXJyYXk+CgkJPC9kaWN0PgoJCTxrZXk+Y29t
LmFwcGxlLnByaW50LlBhcGVySW5mby5QTVVuYWRqdXN0ZWRQYXBlclJlY3Q8L2tleT4KCQk8ZGlj
dD4KCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LmNyZWF0b3I8L2tleT4KCQkJPHN0cmlu
Zz5jb20uYXBwbGUuam9idGlja2V0PC9zdHJpbmc+CgkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRp
Y2tldC5pdGVtQXJyYXk8L2tleT4KCQkJPGFycmF5PgoJCQkJPGRpY3Q+CgkJCQkJPGtleT5jb20u
YXBwbGUucHJpbnQuUGFwZXJJbmZvLlBNVW5hZGp1c3RlZFBhcGVyUmVjdDwva2V5PgoJCQkJCTxh
cnJheT4KCQkJCQkJPHJlYWw+LTE4PC9yZWFsPgoJCQkJCQk8cmVhbD4tMTg8L3JlYWw+CgkJCQkJ
CTxyZWFsPjc3NDwvcmVhbD4KCQkJCQkJPHJlYWw+NTk0PC9yZWFsPgoJCQkJCTwvYXJyYXk+CgkJ
CQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJCTxpbnRl
Z2VyPjA8L2ludGVnZXI+CgkJCQk8L2RpY3Q+CgkJCTwvYXJyYXk+CgkJPC9kaWN0PgoJCTxrZXk+
Y29tLmFwcGxlLnByaW50LlBhcGVySW5mby5wcGQuUE1QYXBlck5hbWU8L2tleT4KCQk8ZGljdD4K
CQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LmNyZWF0b3I8L2tleT4KCQkJPHN0cmluZz5j
b20uYXBwbGUuam9idGlja2V0PC9zdHJpbmc+CgkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tl
dC5pdGVtQXJyYXk8L2tleT4KCQkJPGFycmF5PgoJCQkJPGRpY3Q+CgkJCQkJPGtleT5jb20uYXBw
bGUucHJpbnQuUGFwZXJJbmZvLnBwZC5QTVBhcGVyTmFtZTwva2V5PgoJCQkJCTxzdHJpbmc+VVMg
TGV0dGVyPC9zdHJpbmc+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxh
Zzwva2V5PgoJCQkJCTxpbnRlZ2VyPjA8L2ludGVnZXI+CgkJCQk8L2RpY3Q+CgkJCTwvYXJyYXk+
CgkJPC9kaWN0PgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5BUElWZXJzaW9uPC9rZXk+
CgkJPHN0cmluZz4wMC4yMDwvc3RyaW5nPgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC50
eXBlPC9rZXk+CgkJPHN0cmluZz5jb20uYXBwbGUucHJpbnQuUGFwZXJJbmZvVGlja2V0PC9zdHJp
bmc+Cgk8L2RpY3Q+Cgk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuQVBJVmVyc2lvbjwva2V5
PgoJPHN0cmluZz4wMC4yMDwvc3RyaW5nPgoJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnR5
cGU8L2tleT4KCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50LlBhZ2VGb3JtYXRUaWNrZXQ8L3N0cmlu
Zz4KPC9kaWN0Pgo8L3BsaXN0Pgo4QklNA+0AAAAAABAASAAAAAEAAQBIAAAAAQABOEJJTQQmAAAA
AAAOAAAAAAAAAAAAAD+AAAA4QklNBA0AAAAAAAQAAAAeOEJJTQQZAAAAAAAEAAAAHjhCSU0D8wAA
AAAACQAAAAAAAAAAAQA4QklNBAoAAAAAAAEAADhCSU0nEAAAAAAACgABAAAAAAAAAAE4QklNA/UA
AAAAAEgAL2ZmAAEAbGZmAAYAAAAAAAEAL2ZmAAEAoZmaAAYAAAAAAAEAMgAAAAEAWgAAAAYAAAAA
AAEANQAAAAEALQAAAAYAAAAAAAE4QklNA/gAAAAAAHAAAP////////////////////////////8D
6AAAAAD/////////////////////////////A+gAAAAA/////////////////////////////wPo
AAAAAP////////////////////////////8D6AAAOEJJTQQIAAAAAAAQAAAAAQAAAkAAAAJAAAAA
ADhCSU0EHgAAAAAABAAAAAA4QklNBBoAAAAAA0cAAAAGAAAAAAAAAAAAAAB9AAADjgAAAAkAbwBz
AGMAbwBuADIAMAAwADgAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAA44AAAB9AAAA
AAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAEAAAAAAABudWxsAAAAAgAAAAZi
b3VuZHNPYmpjAAAAAQAAAAAAAFJjdDEAAAAEAAAAAFRvcCBsb25nAAAAAAAAAABMZWZ0bG9uZwAA
AAAAAAAAQnRvbWxvbmcAAAB9AAAAAFJnaHRsb25nAAADjgAAAAZzbGljZXNWbExzAAAAAU9iamMA
AAABAAAAAAAFc2xpY2UAAAASAAAAB3NsaWNlSURsb25nAAAAAAAAAAdncm91cElEbG9uZwAAAAAA
AAAGb3JpZ2luZW51bQAAAAxFU2xpY2VPcmlnaW4AAAANYXV0b0dlbmVyYXRlZAAAAABUeXBlZW51
bQAAAApFU2xpY2VUeXBlAAAAAEltZyAAAAAGYm91bmRzT2JqYwAAAAEAAAAAAABSY3QxAAAABAAA
AABUb3AgbG9uZwAAAAAAAAAATGVmdGxvbmcAAAAAAAAAAEJ0b21sb25nAAAAfQAAAABSZ2h0bG9u
ZwAAA44AAAADdXJsVEVYVAAAAAEAAAAAAABudWxsVEVYVAAAAAEAAAAAAABNc2dlVEVYVAAAAAEA
AAAAAAZhbHRUYWdURVhUAAAAAQAAAAAADmNlbGxUZXh0SXNIVE1MYm9vbAEAAAAIY2VsbFRleHRU
RVhUAAAAAQAAAAAACWhvcnpBbGlnbmVudW0AAAAPRVNsaWNlSG9yekFsaWduAAAAB2RlZmF1bHQA
AAAJdmVydEFsaWduZW51bQAAAA9FU2xpY2VWZXJ0QWxpZ24AAAAHZGVmYXVsdAAAAAtiZ0NvbG9y
VHlwZWVudW0AAAARRVNsaWNlQkdDb2xvclR5cGUAAAAATm9uZQAAAAl0b3BPdXRzZXRsb25nAAAA
AAAAAApsZWZ0T3V0c2V0bG9uZwAAAAAAAAAMYm90dG9tT3V0c2V0bG9uZwAAAAAAAAALcmlnaHRP
dXRzZXRsb25nAAAAAAA4QklNBCgAAAAAAAwAAAABP/AAAAAAAAA4QklNBBEAAAAAAAEBADhCSU0E
FAAAAAAABAAAAAE4QklNBAwAAAAABwgAAAABAAAAoAAAABYAAAHgAAApQAAABuwAGAAB/9j/4AAQ
SkZJRgABAgAASABIAAD/7QAMQWRvYmVfQ00AAv/uAA5BZG9iZQBkgAAAAAH/2wCEAAwICAgJCAwJ
CQwRCwoLERUPDAwPFRgTExUTExgRDAwMDAwMEQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwB
DQsLDQ4NEA4OEBQODg4UFA4ODg4UEQwMDAwMEREMDAwMDAwRDAwMDAwMDAwMDAwMDAwMDAwMDAwM
DAwMDAwMDP/AABEIABYAoAMBIgACEQEDEQH/3QAEAAr/xAE/AAABBQEBAQEBAQAAAAAAAAADAAEC
BAUGBwgJCgsBAAEFAQEBAQEBAAAAAAAAAAEAAgMEBQYHCAkKCxAAAQQBAwIEAgUHBggFAwwzAQAC
EQMEIRIxBUFRYRMicYEyBhSRobFCIyQVUsFiMzRygtFDByWSU/Dh8WNzNRaisoMmRJNUZEXCo3Q2
F9JV4mXys4TD03Xj80YnlKSFtJXE1OT0pbXF1eX1VmZ2hpamtsbW5vY3R1dnd4eXp7fH1+f3EQAC
AgECBAQDBAUGBwcGBTUBAAIRAyExEgRBUWFxIhMFMoGRFKGxQiPBUtHwMyRi4XKCkkNTFWNzNPEl
BhaisoMHJjXC0kSTVKMXZEVVNnRl4vKzhMPTdePzRpSkhbSVxNTk9KW1xdXl9VZmdoaWprbG1ub2
JzdHV2d3h5ent8f/2gAMAwEAAhEDEQA/AOeoqxCy05FwxxWyaxoATDv3vp7NtbfQZ+lt9X/glbdg
9ELQa+qN9xbt9Ta0QXVtu7D3Vsdfaz/TemxH6PLG5n2U0t6sW0/YHXmoe3eft32U5v6p9s9P0dnq
+/0fX9FadFmOX5FYsw8XJtxav2l1Gk4j2V5Abd69Zw8kPqyMW1r8X7b+ydn+UP5vetCZIJ8GnCII
G2ry2QMVj210WOscGtdYSWwHFrXOrr9P6fpP31er/hf5xiCHsIJDgQOTI0XTCzD9XE9R2K36ph2K
X1OON64dtqF7bmx+0/tX2vf9v/fwfV/waLhXuruos6+7p9uXW+w4IZ9mcz0m4uYXDI+w7av2c/J+
x/Y2ZH6z6v8ANpcdDZPt+LysiYnXwSIkEeOi1eq/s0dMwLOmvYKsu3JvfjAh1tDXDE2YWS6BY77N
kMyW4r3/AM5R+kWUnxNi9mOQo06bfrBksr2CiifaGv2wWtYGhjW7fzvb+kt/nLP+tVqVPX3UMNbM
HGLXOc6SHGwF7nWvi7+tY9jfZ/Mfof8AhFlJwEuCPZXGe7o0dZfRijErxqjU0Oa17tbACSW/pI2+
3d79tf6T9J/N+oll9YsyqPQdi0Vt9Rtu9oJeC0zsbY8n9HZ/hG/6T9MqVTN7iB2RRi6xzDg6PinD
GDrS05COqTGzxj1vr+zV2CxznPc4nd7wavbH83tpe9v/ABn6f/BqP7Sti6aq3G/aHSIbtbS/E2bG
bPpts9V72+m/1UM0+2BoXE6/PVCcIcWxoOT2SMAOihMnq23dU3fZi7HaDiWMsq2uIkMbXW+p7o9T
ZZ6LHt9/6FSv61bfiWYrselosY1hsAO4bTW7c381rnej/mfo/wDAqgQmQ4R2TxFSScBOGPdO1pdH
MCUipZSaE/o2AjdDZMe5wEEfSkTu9qJWykH9JcI0+g0uJkee1DiHn5er/op4T10/ven/AKTOpsq2
yoOEEAg6EHggodDa9Ia908ToFpMqe1s+kGc6kknjzUsZAV49zEMUok3XTsJF/9ChhOvZ65obRZXD
fXbk7PT2+/Zv9d9bNm79/wBnq+j/AIf7Ok5+aHvhnTC3YzfAxPRjc/0vo2+h6u71P+E/62vOUlqZ
Nzs5+PYbvoPqZ+9pqr6f6nuIGOMf1NpY7e39Xt+0eg2rd/6MUm2Zsn06+jySOBgcz7dv6VeeJKP/
ABWT/Ge46m7Jc5n2huI1+50/ZfR3T7d32j7K+yz+p6//AFtUlyiSkjt0+iyW/wDF6tTbC5FJOCwv
dYgpLiXHbAl4HJ8G6fnLTJJZoAGxptjjX6ULzJJNy7fy4f8A0dkwb/w+f/C/1b6Pf6W6LfPUfSj8
7Ys25tRaSXAMBho11H7ztoXFJIQ+U7/9ynNXHHb8eP8Awv8AuXsSygM1s3O0gMHtj4vhyiXURDKz
P7z3E/8ARra1cgkl/e4v5f7NH93g/l/tXuMcXOJNJqYDEgQY8P5zd/0vz019dgf+ntsLoMw0/R/B
cQkoteLStunDx/4Vsorh1vfrx+39OH0vYh2Gw6MdZ29xAH9bRHose5x9Cqtj9JMg6eW8/wCcuHSR
NUd7/r8XD/hfoLRd9K/1fDxf4P6b6C05UjeCNfzfn+6rdUxrPzXmaStYNv0f8Fq8xv8Apf4b/9k4
QklNBCEAAAAAAFUAAAABAQAAAA8AQQBkAG8AYgBlACAAUABoAG8AdABvAHMAaABvAHAAAAATAEEA
ZABvAGIAZQAgAFAAaABvAHQAbwBzAGgAbwBwACAAQwBTADMAAAABADhCSU0EBgAAAAAABwAEAAAA
AQEA/+EOmWh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8APD94cGFja2V0IGJlZ2luPSLvu78i
IGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9i
ZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNC4xLWMwMzYgNDYuMjc2NzIwLCBN
b24gRmViIDE5IDIwMDcgMjI6MTM6NDMgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0
cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRp
b24gcmRmOmFib3V0PSIiIHhtbG5zOnhhcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIg
eG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiB4bWxuczpwaG90b3No
b3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOnhhcE1NPSJodHRw
Oi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUu
Y29tL3RpZmYvMS4wLyIgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8i
IHhhcDpDcmVhdGVEYXRlPSIyMDA4LTAyLTE1VDA5OjU3OjIxLTA4OjAwIiB4YXA6TW9kaWZ5RGF0
ZT0iMjAwOC0wMi0xNVQxMDowNzoxOS0wODowMCIgeGFwOk1ldGFkYXRhRGF0ZT0iMjAwOC0wMi0x
NVQxMDowNzoxOS0wODowMCIgeGFwOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1MzIE1h
Y2ludG9zaCIgZGM6Zm9ybWF0PSJpbWFnZS9qcGVnIiBwaG90b3Nob3A6Q29sb3JNb2RlPSIzIiBw
aG90b3Nob3A6SGlzdG9yeT0iIiB4YXBNTTpJbnN0YW5jZUlEPSJ1dWlkOkNGQUNCMEQxM0VERERD
MTFCM0MzOTlBMUY1QTMxQzQ0IiB0aWZmOk9yaWVudGF0aW9uPSIxIiB0aWZmOlhSZXNvbHV0aW9u
PSI3MjAwMDAvMTAwMDAiIHRpZmY6WVJlc29sdXRpb249IjcyMDAwMC8xMDAwMCIgdGlmZjpSZXNv
bHV0aW9uVW5pdD0iMiIgdGlmZjpOYXRpdmVEaWdlc3Q9IjI1NiwyNTcsMjU4LDI1OSwyNjIsMjc0
LDI3NywyODQsNTMwLDUzMSwyODIsMjgzLDI5NiwzMDEsMzE4LDMxOSw1MjksNTMyLDMwNiwyNzAs
MjcxLDI3MiwzMDUsMzE1LDMzNDMyOzBGQkJDNDNGM0ZBMzY2RUJFRUVGQzMzNTc3N0YyMzI2IiBl
eGlmOlBpeGVsWERpbWVuc2lvbj0iOTEwIiBleGlmOlBpeGVsWURpbWVuc2lvbj0iMTI1IiBleGlm
OkNvbG9yU3BhY2U9Ii0xIiBleGlmOk5hdGl2ZURpZ2VzdD0iMzY4NjQsNDA5NjAsNDA5NjEsMzcx
MjEsMzcxMjIsNDA5NjIsNDA5NjMsMzc1MTAsNDA5NjQsMzY4NjcsMzY4NjgsMzM0MzQsMzM0Mzcs
MzQ4NTAsMzQ4NTIsMzQ4NTUsMzQ4NTYsMzczNzcsMzczNzgsMzczNzksMzczODAsMzczODEsMzcz
ODIsMzczODMsMzczODQsMzczODUsMzczODYsMzczOTYsNDE0ODMsNDE0ODQsNDE0ODYsNDE0ODcs
NDE0ODgsNDE0OTIsNDE0OTMsNDE0OTUsNDE3MjgsNDE3MjksNDE3MzAsNDE5ODUsNDE5ODYsNDE5
ODcsNDE5ODgsNDE5ODksNDE5OTAsNDE5OTEsNDE5OTIsNDE5OTMsNDE5OTQsNDE5OTUsNDE5OTYs
NDIwMTYsMCwyLDQsNSw2LDcsOCw5LDEwLDExLDEyLDEzLDE0LDE1LDE2LDE3LDE4LDIwLDIyLDIz
LDI0LDI1LDI2LDI3LDI4LDMwOzAyMDcyMkVENjQ2ODk4NENEQ0ExODE1MENGQ0RGOUZGIi8+IDwv
cmRmOlJERj4gPC94OnhtcG1ldGE+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPD94cGFja2V0IGVuZD0idyI/Pv/uAA5BZG9iZQBkAAAAAAH/2wCE
AAYEBAQFBAYFBQYJBgUGCQsIBgYICwwKCgsKCgwQDAwMDAwMEAwMDAwMDAwMDAwMDAwMDAwMDAwM
DAwMDAwMDAwBBwcHDQwNGBAQGBQODg4UFA4ODg4UEQwMDAwMEREMDAwMDAwRDAwMDAwMDAwMDAwM
DAwMDAwMDAwMDAwMDAwMDP/AABEIAH0DjgMBEQACEQEDEQH/3QAEAHL/xAGiAAAABwEBAQEBAAAA
AAAAAAAEBQMCBgEABwgJCgsBAAICAwEBAQEBAAAAAAAAAAEAAgMEBQYHCAkKCxAAAgEDAwIEAgYH
AwQCBgJzAQIDEQQABSESMUFRBhNhInGBFDKRoQcVsUIjwVLR4TMWYvAkcoLxJUM0U5KismNzwjVE
J5OjszYXVGR0w9LiCCaDCQoYGYSURUaktFbTVSga8uPzxNTk9GV1hZWltcXV5fVmdoaWprbG1ub2
N0dXZ3eHl6e3x9fn9zhIWGh4iJiouMjY6PgpOUlZaXmJmam5ydnp+So6SlpqeoqaqrrK2ur6EQAC
AgECAwUFBAUGBAgDA20BAAIRAwQhEjFBBVETYSIGcYGRMqGx8BTB0eEjQhVSYnLxMyQ0Q4IWklMl
omOywgdz0jXiRIMXVJMICQoYGSY2RRonZHRVN/Kjs8MoKdPj84SUpLTE1OT0ZXWFlaW1xdXl9UZW
ZnaGlqa2xtbm9kdXZ3eHl6e3x9fn9zhIWGh4iJiouMjY6Pg5SVlpeYmZqbnJ2en5KjpKWmp6ipqq
usra6vr/2gAMAwEAAhEDEQA/AOOaVpEMMKzSqHnYct+i1HQZ0IDpZSv3JnQfIeGSYOwK1TFXHFk7
FXYgqtyYmWBi7JUCjcebsgYJErdkWbsCuxVrFXYq7JCVckEW7J8QPNjRHJ2RMFEr5uyPJm7JCV82
PC7ExvluolTsANJIdlglfkWBj8nYmN81Brk7KzFmJOyKXZbHJXm1yh3bF2EwveKBOti7KiG0F2Sj
KvcxMbdlm0mvk7K5RpsErdjGVe5TF2WEcTXdMt/KzyppvmnzrZ6NqTSJZzJM8noEK/7uMsAGIbuM
w9TI442OblYIicq6MiXyl+WfmjSdWfybLqlprGkWj37WupCFkngiI9QKYi3FlqAPi/b/AOAEdRkg
QJ8JhIplhhIExvipFHQPyx8rWmgad5l0y61bV9etIb65vIp2hW1juSVQRIpCyMlG5ep/xvwyBOSZ
kYUIxPCyAhERErMpKy/lf5L0KfznN5mlv7qw8tT2aQCyaITNFe0Kcg4Csy+rGG+JP28iNTM8PBVy
tkcERfF/Cl955S/LFdLsvONnLqs3lNrl7DUrA+iL6G59IvGVY0idG+Hl8X7X2/2EtGTJImB4ROuL
+i1mEIjiHFwWivOnlX8ptH07TFtItY/SGu2dvfaYzvAYkSdhxE/flx+1w5/6+V4cuUk3w8MWWXHj
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
2KH/2Q==
__theme/oscon2008/images/rss.png__
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAsTAAALEwEAmpwYAAAD
BklEQVQ4jV2TTWhcVRTHf+fc++bjJdMEUvsRTSa2Gr/QqhWaStGCgl20gkUUBReCLkKh4sqNi2wq
iAXdVFCoiwqKMdCFIGIFv6iLapoaSIRIg23TJNM2k2Qmmcyb9+69LiYiejaHA+f/O4c/5whA+PPr
/Fo1fV2FwwE0eADP/0MUBPWZ99/UfPpR3+MvbNiRkRGtza+8Gxfzb2RpSggeRBAxoNJWhk2Ca6fY
mGdIsrvD6Ohxe7jcORiSxiuZAe1/kOAcYb2KW1kgbKyB2vbosEkJgaCG4PxLE63qKVuprQ3cudUW
fd5Q6L0HTNTuS9bJFmdoXbmIb64iav/R4xFcyxUWVtf6bSNN4uBTQnOVxvhZTKkH21PG9AwQlR/B
bC2TTH1LdnMW0ai9DUrwjsZGEtu0cllaMi3Rtl5UA37pMq0/zmG6tpO7/xB2530UHj1Kc3yUbG6S
4D1uo0ZavYW7YbC4DfzSLI46nUdPILmYbG6C5MIZ1r4YozD0GoWhVynseZba1Fdk16chKD4VnCuj
AJrLoepw85OQNogGhuh47iT5Bw7R/P4ErckxpLCF+MljaKRoZNC8xQAWAxoZSOusnz2OxlvIP/w8
+f3HKD79NrSWSX5+D1veR7TrANGufbjZX1BTBAOKATGCqN80sJ/Wbx+T/PQOiJA/8CaqjmxqDETJ
DT6FaECsbAIAkYAWihSPnCR+8VPy+4dx05/j586jXX3Y3QfxV38E77B9e9G4hEj7LtSKimgQiSK0
tANE0dI21GT46+cBsHfshWaFkK4jXbejcRfgRUIQu+qjVKxmmtbzre/ewvQ+RLhyDhOX4Oav+N8/
JFRnUA1k46dAikhIEKu+JVFquu99ItrTXXtsZ8n3S3MRU72ENRmmEKF+BVm6gK7PYVSRyiVYnCDC
81e98+KX87vP2Kbx1z5buOuDg2mlflux2S9WaRsLxgggBBfwLhBcN8F5bjVy1364sf2TZTquCiAv
Dw93J83cYEdOd3jv7X9+2AHm31JVs8RJpTOEmdOn31/+G9aSTGVJu1MUAAAAAElFTkSuQmCC
