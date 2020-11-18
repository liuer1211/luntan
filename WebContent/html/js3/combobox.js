/////////用于combobox模糊查询
(function($){
var _8d8=0;
function _8d9(_8da,_8db){
var _8dc=$.data(_8da,"combobox");
var opts=_8dc.options;
var data=_8dc.data;
for(var i=0;i<data.length;i++){
if(data[i][opts.valueField]==_8db){
return i;
}
}
return -1;
};
function _8dd(_8de,_8df){
var opts=$.data(_8de,"combobox").options;
var _8e0=$(_8de).combo("panel");
var item=opts.finder.getEl(_8de,_8df);
if(item.length){
if(item.position().top<=0){
var h=_8e0.scrollTop()+item.position().top;
_8e0.scrollTop(h);
}else{
if(item.position().top+item.outerHeight()>_8e0.height()){
var h=_8e0.scrollTop()+item.position().top+item.outerHeight()-_8e0.height();
_8e0.scrollTop(h);
}
}
}
};
function nav(_8e1,dir){
var opts=$.data(_8e1,"combobox").options;
var _8e2=$(_8e1).combobox("panel");
var item=_8e2.children("div.combobox-item-hover");
if(!item.length){
item=_8e2.children("div.combobox-item-selected");
}
item.removeClass("combobox-item-hover");
var _8e3="div.combobox-item:visible:not(.combobox-item-disabled):first";
var _8e4="div.combobox-item:visible:not(.combobox-item-disabled):last";
if(!item.length){
item=_8e2.children(dir=="next"?_8e3:_8e4);
}else{
if(dir=="next"){
item=item.nextAll(_8e3);
if(!item.length){
item=_8e2.children(_8e3);
}
}else{
item=item.prevAll(_8e3);
if(!item.length){
item=_8e2.children(_8e4);
}
}
}
if(item.length){
item.addClass("combobox-item-hover");
var row=opts.finder.getRow(_8e1,item);
if(row){
_8dd(_8e1,row[opts.valueField]);
if(opts.selectOnNavigation){
_8e5(_8e1,row[opts.valueField]);
}
}
}
};
function _8e5(_8e6,_8e7){
var opts=$.data(_8e6,"combobox").options;
var _8e8=$(_8e6).combo("getValues");
if($.inArray(_8e7+"",_8e8)==-1){
if(opts.multiple){
_8e8.push(_8e7);
}else{
_8e8=[_8e7];
}
_8e9(_8e6,_8e8);
opts.onSelect.call(_8e6,opts.finder.getRow(_8e6,_8e7));
}
};
function _8ea(_8eb,_8ec){
var opts=$.data(_8eb,"combobox").options;
var _8ed=$(_8eb).combo("getValues");
var _8ee=$.inArray(_8ec+"",_8ed);
if(_8ee>=0){
_8ed.splice(_8ee,1);
_8e9(_8eb,_8ed);
opts.onUnselect.call(_8eb,opts.finder.getRow(_8eb,_8ec));
}
};
function _8e9(_8ef,_8f0,_8f1){
var opts=$.data(_8ef,"combobox").options;
var _8f2=$(_8ef).combo("panel");
_8f2.find("div.combobox-item-selected").removeClass("combobox-item-selected");
var vv=[],ss=[];
for(var i=0;i<_8f0.length;i++){
var v=_8f0[i];
var s=v;
opts.finder.getEl(_8ef,v).addClass("combobox-item-selected");
var row=opts.finder.getRow(_8ef,v);
if(row){
s=row[opts.textField];
}
vv.push(v);
ss.push(s);
}
$(_8ef).combo("setValues",vv);
if(!_8f1){
$(_8ef).combo("setText",ss.join(opts.separator));
}
};
function _8f3(_8f4,data,_8f5){
var _8f6=$.data(_8f4,"combobox");
var opts=_8f6.options;
_8f6.data=opts.loadFilter.call(_8f4,data);
_8f6.groups=[];
data=_8f6.data;
var _8f7=$(_8f4).combobox("getValues");
var dd=[];
var _8f8=undefined;
for(var i=0;i<data.length;i++){
var row=data[i];
var v=row[opts.valueField]+"";
var s=row[opts.textField];
var g=row[opts.groupField];
if(g){
if(_8f8!=g){
_8f8=g;
_8f6.groups.push(g);
dd.push("<div id=\""+(_8f6.groupIdPrefix+"_"+(_8f6.groups.length-1))+"\" class=\"combobox-group\">");
dd.push(opts.groupFormatter?opts.groupFormatter.call(_8f4,g):g);
dd.push("</div>");
}
}else{
_8f8=undefined;
}
var cls="combobox-item"+(row.disabled?" combobox-item-disabled":"")+(g?" combobox-gitem":"");
dd.push("<div id=\""+(_8f6.itemIdPrefix+"_"+i)+"\" class=\""+cls+"\">");
dd.push(opts.formatter?opts.formatter.call(_8f4,row):s);
dd.push("</div>");
if(row["selected"]&&$.inArray(v,_8f7)==-1){
_8f7.push(v);
}
}
$(_8f4).combo("panel").html(dd.join(""));
if(opts.multiple){
_8e9(_8f4,_8f7,_8f5);
}else{
_8e9(_8f4,_8f7.length?[_8f7[_8f7.length-1]]:[],_8f5);
}
opts.onLoadSuccess.call(_8f4,data);
};
function _8f9(_8fa,url,_8fb,_8fc){
var opts=$.data(_8fa,"combobox").options;
if(url){
opts.url=url;
}
_8fb=_8fb||{};
if(opts.onBeforeLoad.call(_8fa,_8fb)==false){
return;
}
opts.loader.call(_8fa,_8fb,function(data){
_8f3(_8fa,data,_8fc);
},function(){
opts.onLoadError.apply(this,arguments);
});
};
function _8fd(_8fe,q){
var _8ff=$.data(_8fe,"combobox");
var opts=_8ff.options;
if(opts.multiple&&!q){
_8e9(_8fe,[],true);
}else{
_8e9(_8fe,[q],true);
}
if(opts.mode=="remote"){
_8f9(_8fe,null,{q:q},true);
}else{
var _900=$(_8fe).combo("panel");
_900.find("div.combobox-item-selected,div.combobox-item-hover").removeClass("combobox-item-selected combobox-item-hover");
_900.find("div.combobox-item,div.combobox-group").hide();
var data=_8ff.data;
var vv=[];
var qq=opts.multiple?q.split(opts.separator):[q];
$.map(qq,function(q){
q=$.trim(q);
var _901=undefined;
for(var i=0;i<data.length;i++){
var row=data[i];
if(opts.filter.call(_8fe,q,row)){
var v=row[opts.valueField];
var s=row[opts.textField];
var g=row[opts.groupField];
var item=opts.finder.getEl(_8fe,v).show();
if(s.toLowerCase()==q.toLowerCase()){
vv.push(v);
item.addClass("combobox-item-selected");
}
if(opts.groupField&&_901!=g){
$("#"+_8ff.groupIdPrefix+"_"+$.inArray(g,_8ff.groups)).show();
_901=g;
}
}
}
});
_8e9(_8fe,vv,true);
}
};
function _902(_903){
var t=$(_903);
var opts=t.combobox("options");
var _904=t.combobox("panel");
var item=_904.children("div.combobox-item-hover");
if(item.length){
var row=opts.finder.getRow(_903,item);
var _905=row[opts.valueField];
if(opts.multiple){
if(item.hasClass("combobox-item-selected")){
t.combobox("unselect",_905);
}else{
t.combobox("select",_905);
}
}else{
t.combobox("select",_905);
}
}
var vv=[];
$.map(t.combobox("getValues"),function(v){
if(_8d9(_903,v)>=0){
vv.push(v);
}
});
t.combobox("setValues",vv);
if(!opts.multiple){
t.combobox("hidePanel");
}
};
function _906(_907){
var _908=$.data(_907,"combobox");
var opts=_908.options;
_8d8++;
_908.itemIdPrefix="_easyui_combobox_i"+_8d8;
_908.groupIdPrefix="_easyui_combobox_g"+_8d8;
$(_907).addClass("combobox-f");
$(_907).combo($.extend({},opts,{onShowPanel:function(){
$(_907).combo("panel").find("div.combobox-item,div.combobox-group").show();
_8dd(_907,$(_907).combobox("getValue"));
opts.onShowPanel.call(_907);
}}));
$(_907).combo("panel").unbind().bind("mouseover",function(e){
$(this).children("div.combobox-item-hover").removeClass("combobox-item-hover");
var item=$(e.target).closest("div.combobox-item");
if(!item.hasClass("combobox-item-disabled")){
item.addClass("combobox-item-hover");
}
e.stopPropagation();
}).bind("mouseout",function(e){
$(e.target).closest("div.combobox-item").removeClass("combobox-item-hover");
e.stopPropagation();
}).bind("click",function(e){
var item=$(e.target).closest("div.combobox-item");
if(!item.length||item.hasClass("combobox-item-disabled")){
return;
}
var row=opts.finder.getRow(_907,item);
if(!row){
return;
}
var _909=row[opts.valueField];
if(opts.multiple){
if(item.hasClass("combobox-item-selected")){
_8ea(_907,_909);
}else{
_8e5(_907,_909);
}
}else{
_8e5(_907,_909);
$(_907).combo("hidePanel");
}
e.stopPropagation();
});
};
$.fn.combobox=function(_90a,_90b){
if(typeof _90a=="string"){
var _90c=$.fn.combobox.methods[_90a];
if(_90c){
return _90c(this,_90b);
}else{
return this.combo(_90a,_90b);
}
}
_90a=_90a||{};
return this.each(function(){
var _90d=$.data(this,"combobox");
if(_90d){
$.extend(_90d.options,_90a);
_906(this);
}else{
_90d=$.data(this,"combobox",{options:$.extend({},$.fn.combobox.defaults,$.fn.combobox.parseOptions(this),_90a),data:[]});
_906(this);
var data=$.fn.combobox.parseData(this);
if(data.length){
_8f3(this,data);
}
}
if(_90d.options.data){
_8f3(this,_90d.options.data);
}
_8f9(this);
});
};
$.fn.combobox.methods={options:function(jq){
var _90e=jq.combo("options");
return $.extend($.data(jq[0],"combobox").options,{width:_90e.width,height:_90e.height,originalValue:_90e.originalValue,disabled:_90e.disabled,readonly:_90e.readonly});
},getData:function(jq){
return $.data(jq[0],"combobox").data;
},setValues:function(jq,_90f){
return jq.each(function(){
_8e9(this,_90f);
});
},setValue:function(jq,_910){
return jq.each(function(){
_8e9(this,[_910]);
});
},clear:function(jq){
return jq.each(function(){
$(this).combo("clear");
var _911=$(this).combo("panel");
_911.find("div.combobox-item-selected").removeClass("combobox-item-selected");
});
},reset:function(jq){
return jq.each(function(){
var opts=$(this).combobox("options");
if(opts.multiple){
$(this).combobox("setValues",opts.originalValue);
}else{
$(this).combobox("setValue",opts.originalValue);
}
});
},loadData:function(jq,data){
return jq.each(function(){
_8f3(this,data);
});
},reload:function(jq,url){
return jq.each(function(){
_8f9(this,url);
});
},select:function(jq,_912){
return jq.each(function(){
_8e5(this,_912);
});
},unselect:function(jq,_913){
return jq.each(function(){
_8ea(this,_913);
});
}};
$.fn.combobox.parseOptions=function(_914){
var t=$(_914);
return $.extend({},$.fn.combo.parseOptions(_914),$.parser.parseOptions(_914,["valueField","textField","groupField","mode","method","url"]));
};
$.fn.combobox.parseData=function(_915){
var data=[];
var opts=$(_915).combobox("options");
$(_915).children().each(function(){
if(this.tagName.toLowerCase()=="optgroup"){
var _916=$(this).attr("label");
$(this).children().each(function(){
_917(this,_916);
});
}else{
_917(this);
}
});
return data;
function _917(el,_918){
var t=$(el);
var row={};
row[opts.valueField]=t.attr("value")!=undefined?t.attr("value"):t.text();
row[opts.textField]=t.text();
row["selected"]=t.is(":selected");
row["disabled"]=t.is(":disabled");
if(_918){
opts.groupField=opts.groupField||"group";
row[opts.groupField]=_918;
}
data.push(row);
};
};
$.fn.combobox.defaults=$.extend({},$.fn.combo.defaults,{valueField:"value",textField:"text",groupField:null,groupFormatter:function(_919){
return _919;
},mode:"local",method:"post",url:null,data:null,keyHandler:{up:function(e){
nav(this,"prev");
e.preventDefault();
},down:function(e){
nav(this,"next");
e.preventDefault();
},left:function(e){
},right:function(e){
},enter:function(e){
_902(this);
},query:function(q,e){
_8fd(this,q);
}},filter:function(q,row){
var opts=$(this).combobox("options");
return row[opts.textField].toLowerCase().indexOf(q.toLowerCase())>-1;
},formatter:function(row){
var opts=$(this).combobox("options");
return row[opts.textField];
},loader:function(_91a,_91b,_91c){
var opts=$(this).combobox("options");
if(!opts.url){
return false;
}
$.ajax({type:opts.method,url:opts.url,data:_91a,dataType:"json",success:function(data){
_91b(data);
},error:function(){
_91c.apply(this,arguments);
}});
},loadFilter:function(data){
return data;
},finder:{getEl:function(_91d,_91e){
var _91f=_8d9(_91d,_91e);
var id=$.data(_91d,"combobox").itemIdPrefix+"_"+_91f;
return $("#"+id);
},getRow:function(_920,p){
var _921=$.data(_920,"combobox");
var _922=(p instanceof jQuery)?p.attr("id").substr(_921.itemIdPrefix.length+1):_8d9(_920,p);
return _921.data[parseInt(_922)];
}},onBeforeLoad:function(_923){
},onLoadSuccess:function(){
},onLoadError:function(){
},onSelect:function(_924){
},onUnselect:function(_925){
}});
})(jQuery);