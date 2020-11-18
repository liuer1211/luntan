//弹窗统一提示信息
var MESSAGE = {
	TITLE:{
		NORMAL:'提示信息',
		ERROR:'错误提示'
	},
	CONTENT:{
		EXIT:'您确定要退出系统吗？',
		ERROR:'请求数据发生错误！',
		SELECTONE:'请至少选中一行再进行操作',
		SELECTONLY:'请至多选中一行再进行操作',
		DELCONFIRM:'确定要删除选中的信息吗？'
	}
};

/*
 * 作者录入快速搜索功能快速搜索
 * url请求后台地址
 */
$.fn.fastSearch = function(record,url){
	var t =this;
    //console.log(t)
	if(record.value == '所内作者' || record.value == '所内成员'){
		keyUPEven(t);
	}else{
		keyUpOff(t);
	}
	//解绑输入框事件
	function keyUpOff(t){
		var p = $(t).parents('tr');
		p.off();
	}
	//绑定输入框事件
	function keyUPEven(t){
		var p = $(t).parents('tr'),data;
		p.on('keyup','.J_name',function(e){
            e.preventDefault();
			var $this = $(this);
			$.ajax({
				type:"post",
				url:url,
				async:true,
				data:{'userName':$this.val()},
				cache:false,
				dataType:'json',
				success:function(data){
					data = data.rows;
					$this.next('#search_autor').remove();
					var html = createElement(data,$this);
					$this.after(html);	
				},
				error:function(XMLHttpRequest ){
					
				}
			});	
		}).on('blur','.J_name',function(e){
            e.preventDefault();
			var $this = $(this);
			//$this.val('');
			setTimeout(function(){
				$this.next('#search_autor').remove(); 
			},100)		
		}).on('click','#search_autor tr',function(e){
            e.preventDefault();
            debugger;
			var f = $(this).parents('#search_autor').parents('tr');
				$(this).parents('#search_autor').remove();
				f.find('.J_name').val($(this).attr('data-name'));
				f.find('.J_job').combobox('setValue',$(this).attr('data-jobTitle'));
				f.find('.J_team').combobox('setValue',$(this).attr('data-team'));
				f.find('.J_org').combobox('setValue',$(this).attr('data-org'));
				f.find('.J_work').val('黄海水产研究所');
		})
	}
	function createElement(data,t){
		var html = '<div id="search_autor" class="table_div" style="margin-left:'+(-(t.width()+10)/2)+'px'+'"><table id="" border="0" cellspacing="0" cellpadding="0" class="table_search">';
		for(var i = 0;i<data.length;i++){
			html += '<tr data-jobTitle="'+data[i].jobTitle+'" data-name="'+data[i].userName+'" data-team="'+data[i].team+'" data-org="'+data[i].orgId+'"><td>'+data[i].userId+'</td><td>'+data[i].userName+'</td></tr>';
		}
		html += '</table></div>';
		return html;
	}
}

/*
 *  用来给不支持HTML5 placeholder属性的浏览器增加此功能。
 *  @param element {String or Object} 需要添加placeholder提示的输入框选择器或者输入框jquery对象。
 *  @param defualtCss {String} 提示默认的样式class。
 */
$.fn.placeholder = function(opts){
	var set = $.extend({
			iClass:'placeholder'
		},opts||{}),

		isSupported = (function(){
			var input = document.createElement('input');
			return 'placeholder' in input;
		})(),
		forms = [],
		dv = '';

	//如果浏览器支持placeholder，直接返回
	if(isSupported) return;

	$(this).each(function(){
		var _this = $(this),
			defaltText = _this.attr('placeholder') || '',
			$form = _this.closest("form"),
			val = this.value;
        //避免给同一个form多次绑定submit事件
        if(!$form.data('placeholder')){ 
        	forms.push($form); 
        	$form.data('placeholder', true);
        };

		//如果默认值为空，则直接返回
		if(defaltText === '') return this;

		//设置默认值并加上一个自定义的Class让文字变灰
		if(val == '') _this.addClass(set.iClass).val(defaltText);

		_this.on('focus',function(){
			var v = this.value;
			if(v == defaltText){
				this.value = '';
				_this.removeClass(set.iClass);
			};
		}).on('blur',function(){
			var v = this.value;
            //当用户输入的值与placeholder相同，给该元素添加一个自定义属性进行标示，以便提交时进行区分
			if(v == defaltText) _this.data('shouldsubmit',true);
			if(v == ''){
				this.value = defaltText;
				_this.addClass(set.iClass);
			};
		});

	});

    $(forms).each(function(){
        /*
        *  父级表单提交前判断一下该元素的值是否有placeholder属性，这里需要注意一点，
        *  当用户输入值的和placeholder的值相同的时候，这个时候是需要提交的，支持placeholder的浏览器也是这个样子的
        *  所以上面的onblur的时候需要给它加一个自定义属性以便这里提交的时候进行区分
        *  当没有shouldsubmit属性，且值和placeholder相同，说明它是不需要提交的，否则就是需要提交的
        * */
        $(this).on('submit',function(){
            $(':input',this).each(function(){
                dv = this.getAttribute('placeholder');
                if(dv !== ''){
                    var v = this.value;
                    if(v === dv && !$(this).data('shouldsubmit')) this.value = '';
                }
            });
        });
    });
};

$('[placeholder]').placeholder();
//弹出框
;(function(win){
    var tips = {
        'title':'提示信息',
        'enter':'确定',
        'cancel':'取消',
        'close':'',
        'defaultValue':'',
		'maxlen': ''
    },
    isIE6 = !window.XMLHttpRequest,
    cssLoaded = false,
    isOpen = false;
 
    /*************************************对外提供的接口****************************************************/
    var dialog = function(opts){
        return new dialog.prototype.init(opts);
    };
 
    dialog.prototype = {
        constructor:dialog,
        init:function(opts){
            //loadCss();
        },
        alert:function(opts){
            var _this = this;
            var set = extend({
                width:420,
                height:140,
                alertClass:1,
                icon:'info'
            },opts||{});
            if(isOpen) this.close();
            isOpen = true;
            this.doms = createElements(set);
            this.doms.contentBox.innerHTML = opts.content;
            setTimeout(function(){
            	setCenter(_this.doms);
            	try{
            		_this.doms.btnEnter.focus();
            	}catch(e){
            	}
            }, 0);
            this.doms.btnEnter.onclick = function(){
                _this.close();
                opts.callback && opts.callback(true);
				return false;
            };
            this.doms.contentTitle.onmousedown = function(e){
                var mousePos= getMousePos(e),pos = getElementPos(_this.doms.contentOuter);
                var _move = move(mousePos,_this.doms.contentOuter,pos.y,pos.x);
                addEvent(document,'mousemove',_move);
                addEvent(document,'mouseup',function(){
                    removeEvent(document,'mousemove',_move)
                });
            };
            this.doms.contentTitle.ondragstart = function(){ return false;};
            this.doms.close.onclick = function(){
                _this.closeBtntoClose(opts);
				return false;
            };
 
            addEvent(window,'resize',function(){setCenter(_this.doms);})
        },
        confirm:function(opts){
            var _this = this;
            this.alert(opts);
            this.doms.contentBox.innerHTML = '<p class="dialog_Content_title">'+opts.content+'</p><p class="dialog_Content_tips">'+(opts.tips?opts.tips:'如果是请点击“确定”，否则点“取消”')+'</p>';
            this.doms.btnBox.appendChild(this.doms.btnCancel);
            setTimeout(function(){setCenter(_this.doms);},0);
            this.doms.btnCancel.onclick = function(){
                _this.close();
                opts.callback && opts.callback(false);
				return false;
            }
        },
        prompt:function(opts){
            var _this = this,input;
            opts.alertClass = '';
            this.alert(opts);
            input = createEl('<input maxlength="'+ (opts.maxlen||'') +'" type="text" name="" value="'+(opts.defaultValue||'')+'" id="dialog_prompt_input" />',this.doms.contentBox);
            input.select();
            this.doms.btnBox.appendChild(this.doms.btnCancel);
            setTimeout(function(){setCenter(_this.doms);},0);
            this.doms.btnEnter.onclick = function(){
                 _this.close();
                 opts.callback && opts.callback(input.value);
				 return false;
            };
            this.doms.btnCancel.onclick = function(){
                _this.close();
                opts.callback && opts.callback(null);
				return false;
            };
            this.doms.close.onclick = function(){
                _this.close();
				return false;
            };
        },
        load:function(opts){
            var _this = this;
            opts.alertClass = '';
            opts.focus = false;
            this.alert(opts);
            this.doms.contentOuter.removeChild(this.doms.btnBox);
            this.doms.btnEnter.onclick = null;
            _this.doms.contentBox.className = 'isLoading';
            ajax({
                url:opts.content,
                success:function(data){
                    if($("#j_password",data).size()>0||$("#errtpye_custom",data).size()>0)
                    {
                    	var pathName=window.location.pathname;
                    	//获取带"/"的项目名，如：/myproj
                    	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
                    	
                    	//window.close();
                    	var tmpHref = projectName+"/login/error?error=2";
                        top.location.href = tmpHref;
                    	//top.location.href = "/rpms/login/error?error=2";
                        window.opener.document.location.reload();
                    }
                    else{
                    	_this.doms.contentBox.innerHTML = data;
                    	opts.callback && opts.callback(data);
                    	_this.doms.contentBox.className = '';
                    }
                }
            })
        },
        loadIframe:function(opts){
            var _this = this,iframe = document.createElement('iframe'),doc;
            opts.alertClass = '';
            this.alert(opts);
            this.doms.contentOuter.removeChild(this.doms.btnBox);
            this.doms.btnEnter.onclick = null;
            iframe.style.width = '100%';
            iframe.style.height = '100%';
            iframe.style.backgroundColor = 'transparent';
            iframe.frameBorder = 0;
			iframe.setAttribute('allowTransparency', true);
            _this.doms.contentBoxWrap.innerHTML = '';
            _this.doms.contentBoxWrap.className = 'isLoading';
            _this.doms.contentBoxWrap.appendChild(iframe);
            iframe.attachEvent ? iframe.attachEvent('onload',_load) : (iframe.onload = _load);
            function _load(){
                doc = iframe.contentDocument || iframe.contentWindow.document;
                if(opts.height == 'auto'){
                    //setTimeout for IE9
                    setTimeout(function(){
                        _this.doms.contentBoxWrap.style.height = doc.body.offsetHeight+1 + 'px';  
                    },0);
                }
                opts.callback && opts.callback(iframe);
                //_this.doms.contentBox.className = '';
                setCenter(_this.doms);
            };
            iframe.src = opts.content;
        },
        close:function(){
			var db = document.body, contBox = this.doms.contentBox, iframe = contBox.getElementsByTagName("iframe")[0];
			iframe && contBox.removeChild(iframe);
            db.removeChild(this.doms.overlayer);
            db.removeChild(this.doms.contentOuter);
            db.removeChild(this.doms.overlayIframe);
            this.doms.btnEnter.onclick = this.doms.btnCancel.onclick = this.doms.close.onclick = this.doms.contentTitle.onmousedown = null;
            this.doms = null;
            isOpen = false;
			window.CollectGarbage && setTimeout(window.CollectGarbage, 1); //强制IE回收内存垃圾
        },
		closeBtntoClose:function(opts){
			opts.closeCall && opts.closeCall(this.doms.contentBox.getElementsByTagName("iframe")[0].contentWindow);
			this.close();
		}
    };
 
    dialog.prototype.init.prototype = dialog.prototype;
	win.dialog = dialog();
 
    /**********************************私有方法*******************************************************/
    function extend(subClass,superClass){
        for(var key in superClass) subClass[key] = superClass[key];
        return subClass;
    };
    function createElements(opts){
        var db = document.body,h = Math.max(document.documentElement.clientHeight,document.body.offsetHeight);
        var width = opts.width,height = opts.height == 'auto' ? 'auto' : opts.height + 'px';
        var overlayer = createEl('<div id="dialog_overlayer" style="position:fixed;_position:absolute;top:0;left:0;width:100%;height:'+h+'px;background:#000;opacity:.5;filter: Alpha(Opacity=50);z-index:100;"></div>',db),
            overlayIframe = createEl('<iframe marginwidth="0" marginheight="0" align="top" scrolling="no" frameborder="0" class="dialog_HideSelect" src="javascript:void(function(){document.open();document.write(\'<script>document.oncontextmenu=function(){return false}</script>\');document.close()}())" style="position:fixed;_position:absolute;top:0;left:0;width:100%;height:'+h+'px;filter:alpha(opacity=0);z-index:9999;"></iframe>',db),
            contentOuter = createEl('<div id="dialog_window" style="position:fixed;_position:absolute;top:50%;left:50%;width:'+width+'px;z-index:9999;"></div>',db),
            contentTitle = createEl('<div id="dialog_title"><span class="dialogtitle">'+ (opts.title || tips.title) +'</span></div>',contentOuter),
            close = createEl('<a href="javascript:void(0);" id="dialog_btn_close" >'+ tips.close +'</a>',contentTitle),
            con_class ='';
            if(opts.icon == 'right'){
            	con_class ='dialog_icon_right';
            }
            if(opts.icon == 'error'){
            	con_class ='dialog_icon_error';
            }
            contentBoxWrap = createEl('<div id="dialog_Content" style="height:'+height+';"'+(opts.alertClass ? 'class="dialog_icon_alert '+con_class+'"':'')+'><div class="dis_ib_vm"></div><span class="vam"></span></div>',contentOuter),
            contentBox = contentBoxWrap.firstChild,
            btnBox = createEl('<div id="dialog_btnBox"></div>',contentOuter),
            btnEnter = createEl('<a href="javascript:;" id="dialog_btn_enter" class="btn btn_teal">'+ (opts.enter||tips.enter) +'</a>',btnBox),
            btnCancel = createEl('<a href="javascript:;" id="dialog_btn_cancel" class="btn btn_cancel">'+(opts.cancel|| tips.cancel) +'</a>')
            isIE6 && (contentOuter.style.position = 'absolute');
        return {
            overlayer:overlayer,
            overlayIframe:overlayIframe,
            contentOuter:contentOuter,
            contentTitle:contentTitle,
            close:close,
            contentBoxWrap:contentBoxWrap,
            contentBox:contentBox,
            btnBox:btnBox,
            btnEnter:btnEnter,
            btnCancel:btnCancel
        };
    };
    function createEl(str,parent){
        var div = document.createElement('div'),el;
        div.innerHTML = str;
        el = div.firstChild;
        return parent ? parent.appendChild(el) : el;
    };
    function setCenter(doms){
        if(!doms) return;
        var T = doms.contentOuter,w = T.offsetWidth,h = T.offsetHeight,timer = null;
        var dd = document.documentElement,W = dd.clientWidth,H = dd.clientHeight,dbh = document.body.offsetHeight; 
        var st = Math.max(dd.scrollTop,document.body.scrollTop),sl = Math.max(dd.scrollLeft,document.body.scrollLeft);
        T.style.top = (H-h)/2 + (isIE6 ? st : 0 )+'px';
        T.style.left = (W-w)/2 +(isIE6 ? sl : 0 ) + 'px';
        doms.overlayer.style.height = Math.max(H,dbh) + 'px';
        if(isIE6){
            addEvent(window,'scroll',function(){
                if(timer) clearTimeout(timer);
                timer = setTimeout(function(){
                    var t = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
                    T.style.top = (H-h)/2+ t +'px';
                },100);
            });
        };
    };
    function getMousePos(e){
        e = e || window.event;
        if(e.pageX || e.pageY) return { left:e.pageX,top:e.pageY};
        return {
            left:e.clientX + document.documentElement.scrollLeft - document.body.clientLeft,
            top:e.clientY + document.documentElement.scrollTop - document.body.clientTop
        };
    };
    function addEvent(el,type,fn){
        if(el.addEventListener != undefined){
            el.addEventListener(type,fn,false);
        }else if(el.attachEvent != undefined){
            el.attachEvent('on'+type,fn)
        }else{
            el['on'+type] = fn;
        };
    };
    function removeEvent(el,type,fn){
        if(el.removeEventListener != undefined){
            el.removeEventListener(type,fn,false);
        }else if(el.detachEvent != undefined){
            el.detachEvent('on'+type,fn);
        }else{
            el['on'+type] = function(){};
        };
    };
    function move(oldPos,target,t,l){
        var dd = document.documentElement, st = Math.max(dd.scrollTop,document.body.scrollTop),sl = Math.max(dd.scrollLeft,document.body.scrollLeft)
        var w = target.offsetWidth,h = target.offsetHeight,cw = dd.clientWidth,ch = dd.clientHeight;
        var rw = cw-w,rh = ch-h;
        return function(e){
            var newPos = getMousePos(e);
            //clear selection
            if (document.selection && document.selection.empty) {
                document.selection.empty();  //IE
            } else if (window.getSelection) {
                window.getSelection().removeAllRanges(); //DOM
            };
            if(isIE6){
                target.style.top = Math.max(st,Math.min(st+rh,(t + (newPos.top - oldPos.top)))) + 'px';
                target.style.left = Math.max(sl,Math.min(sl+rw,(l + (newPos.left - oldPos.left)))) + 'px';
            }else{
                target.style.top = Math.max(0,Math.min(rh,(t + (newPos.top - oldPos.top) - st))) + 'px';
                target.style.left = Math.max(0,Math.min(rw,(l + (newPos.left - oldPos.left) - sl))) + 'px';
            };
        };
    };
    function getElementPos(el){
        var x = 0,y=0;
        if(el.getBoundingClientRect){
            var pos = el.getBoundingClientRect();
            var d_root = document.documentElement,db = document.body;
            x = pos.left + Math.max(d_root.scrollLeft,db.scrollLeft) - d_root.clientLeft;
            y = pos.top + Math.max(d_root.scrollTop,db.scrollTop) - d_root.clientTop;
        }else{
            while(el != db){
                x += el.offsetLeft;
                y += el.offsetTop;
                el = el.offsetParent;
            };
        };
        return {
            x:x,
            y:y
        };
    };
    function ajax(opts){
        var xhr = null;
        var set = extend({
            type:'GET',
            url:''
        },opts||{});
        if(typeof window.XMLHttpRequest != 'undefined'){
            xhr = new window.XMLHttpRequest();
        }else{
            xhr = new ActiveXObject('MSXML2.XmlHttp.6.0');
        };
        xhr.open(set.type,set.url);
        xhr.onreadystatechange = function(){
            if(xhr.readyState == 4){
                if(xhr.status >= 200 && xhr.status <= 304 ){
                    set.success && set.success(xhr.responseText);
                }else{
                    set.failure && set.failure(xhr.status);
                };
            };
        };
        xhr.send(null);
    };
})(window);

//显示遮罩层    
function showMask(){
	var mask = $('<div id="mask" class="mask"></div>');
	top.$('body').append(mask);
    top.$("#mask").css("height",window.top.document.documentElement.clientHeight);     
    top.$("#mask").css("width",window.top.document.documentElement.clientWidth);     
    top.$("#mask").show();     
}  
//隐藏遮罩层  
function hideMask(){          
    top.$("#mask").remove();    
}  
//ajax共同方法
function docommonAjax(type,url,data,success,gridid,boolean){
	$.ajax({
        type: type,
        url:url,
        data: data,
        async: false,
		//crossDomain: true,
        dataType : "json",
        traditional:true,
        beforeSend: function(XMLHttpRequest) {
			//发送前显示遮罩层，无法再次点击，只能等请求结束后才能进行页面操作
			showMask();
		},
        success: function(response){
         hideMask();
         try 
          {
        	// if(response.error=="过期了，请重新登录")
        	// {
        	//	window.location.href=contextPath+"/login/sessionInvalid?error=1";
        	 //}
        	var result = response;
        	commonCallback(response,gridid,url,data,boolean);
        		/*//消息
        		var errList = result.errList;
        		//返回的消息类型
        		var errType = result.errType;
        		//表格是否有动态title
        		var autocolumn = result.column;
        		//后台有消息返回
        		if(errList.length != 0)
        		{
        			showErrMsgFromBack(errType,errList);
        			if(success!=null && success !="commonCallback" && success !="commonTreeGridCallback"){
        				eval(success)(response);
        			}else if(success == "commonCallback"){
        				commonCallback(response,gridid,url,data,boolean);
        			}else if(success == "commonTreeGridCallback")
        			{
        				commonTreeGridCallback(response,gridid,url,boolean);
        			}
        			return;
        		}
        		else{
        			if(success!=null && success !="commonCallback" && success !="commonTreeGridCallback"){
        				eval(success)(response);
        			}else if(success == "commonCallback"){
        				commonCallback(response,gridid,url,data,boolean);
        			}
        			
        		}*/
        		} 
			catch (e) 
			{
				console.log(e);
			} 
        },
        error:function(jqXHR, exception){
        	//alert(11)
        	if (jqXHR.status === 0) {
        		showOnlyMessage("error","服务器停止运行，请与管理员联系");
            }
        	//判断ajax是否session过期
            else if((jqXHR.responseText).indexOf("/login/error?error=3")>0)
        	{
        		top.window.location.href=contextPath+"/login/error?error=3";
        	}
        	else if((jqXHR.responseText).indexOf("/login/sessionInvalid?error=2")>0)
        	{
        		top.window.location.href=contextPath+"/login/sessionInvalid?error=2";
        	}
        	else if((jqXHR.responseText).indexOf("error500")>0)
        	{
        		top.window.location.href=contextPath+"/admin/j_spring_security_logout";
        	}
            else if (exception === 'parsererror'){
            	
            	showOnlyMessage("error","json数据解析错误");
            }else if (exception === 'timeout'){
            	showOnlyMessage("error","请求超时，请重试");
            }else{
             	showOnlyMessage("error","系统异常，请与管理员联系");
            }
        	
        },
        complete: function (jsondata, stat){
        	hideMask();
        }

    });
}
//共同回掉函数
//response:后台传回的数据
//gridid：表格控件的id
//boolean 是否需要分页条件
function commonCallback(response,gridid,url,data,boolean)
{
	if(gridid!=null && gridid!="")
	{
		$("#" + gridid).datagrid('loadData',response);
		
		//db中数据被删除了，检索的后一页没有数据，页面显示前一页的数据
		if(response.rows.length == 0 && response.total > 0)
		{
			var p = $("#" + gridid).datagrid('getPager');
			$(p).pagination('refresh',{	// 改变 options和刷新分页工具栏信息
				pageNumber: data.currpage - 1
			});
			data.currpage = data.currpage - 1;
			commonGetrowdatas(gridid,data,url,"commonCallback",boolean);
		}
	}	
}

//共同取得一览数据的方法
function commonGetrowdatas(gridid,data,url,success,boolean)
{
	if(boolean){
		var grid = $('#'+gridid);
		
		var options = grid.datagrid('getPager').data("pagination").options;
		//获取当前页
		var currpage = options.pageNumber;
		if(currpage == 0)
		{
			currpage = 1;
		}
		//获取当前页显示数据条数
		var pageSize = options.pageSize;
		data.currpage = currpage;
		data.pageSize= pageSize;
	}	
 	doAjax("post",url,data,success,gridid,boolean);
}

//调用共同ajax方法，外部接口
function doAjax(type,url,data,success,gridid,boolean){
	docommonAjax(type,url,data,success,gridid,boolean);
}
//弹出后台传回的消息消息
//供内部调用
function showErrMsgFromBack(type,errList,title) {
	var str = "";
	for(var i = 0;i<errList.length;i++){
		str += ( errList[i] + "</br>");
	}
	//错误消息提示
	showOnlyMessage(type,str,title)
}
//弹出提示消息
//不使用共通的check方式时弹出错误消息
function showOnlyMessage(type,message,title)
{
	top.dialog.alert({
		'icon':type,
		'title':title,
		'content':message
	});
}
//确认消息
function showConfirm(funName,msg,gridid,data,url,success,boolean){
	top.dialog.confirm({
		title:MESSAGE.TITLE.NOMAL,
	 	icon:'right',
        content:msg,
	 	tips:'如果是请点击“确定”，否则点“取消”',
        callback:function(v){
        	if(v){
        		eval(funName)(gridid,data,url,success,boolean);
        	}
        }
	});
}
//获取选中行
function GetSelectedRowsObj(id)
{
	var rowsObj = $('#' + id).datagrid('getSelections');
	return rowsObj;
}
//获取form中的数据，并将其转换成ajax需要的数据格式
function getFormJson(formId) {
    var o = {};
    var fid = "#" + formId;    
    var a = $(fid).serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
}

//序列化data数据
function toUrl(data) {
    var o ="?";
    $.each(data, function (k,v) {
		o=o+k+"="+v+"&";
    });
    return o.substr(0, o.length-1);
}




