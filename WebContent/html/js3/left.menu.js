
var _menus = {
	"首 页": [
		{
			"menuid": "1", "icon": "leftico01", "menuname": "demo菜单列表",
			"menus": [
					  { "menuid": "13", "menuname": "demo列表", "icon": "icon-user", "url": "list.html" },
					  { "menuid": "14", "menuname": "图表展示", "icon": "icon-organ", "url": "chart.html" },
					  { "menuid": "15", "menuname": "视频展示", "icon": "icon-group-key", "url": "video.html" },
					  { "menuid": "16", "menuname": "远程桌面", "icon": "icon-key", "url": "desk.html" }
			]
		},
	   {
		   "menuid": "2", "icon": "leftico02", "menuname": "其他管理",
		   "menus": [{ "menuid": "21", "menuname": "视频会议", "icon": "icon-lock", "url": "meeting.html" },
					  { "menuid": "17", "menuname": "登陆日志", "icon": "icon-view", "url": "log.html" }
		   ]
	   }
	],
	"两票系统": [
		{
			"menuid": "3", "icon": "leftico03", "menuname": "事务中心",
			"menus": [
					  { "menuid": "33", "menuname": "测试菜单1", "icon": "icon-user", "url": "../Commonpage/building.htm" },
					  { "menuid": "34", "menuname": "测试菜单2", "icon": "icon-organ", "url": "../Commonpage/building.htm" },
					  { "menuid": "35", "menuname": "测试菜单3", "icon": "icon-group-key", "url": "../Commonpage/building.htm" },
					  { "menuid": "36", "menuname": "测试菜单4", "icon": "icon-key", "url": "../Commonpage/building.htm" }
			]
		},
		{
			"menuid": "4", "icon": "leftico04", "menuname": "其他菜单2",
			"menus": [{ "menuid": "41", "menuname": "测试菜单5", "icon": "icon-lock", "url": "list.html" }]
		}
	]
};

$(function(){	
LeftMenu(_menus["首 页"],"快捷菜单");
//顶部导航切换
	$(".nav li a").click(function(e){
		$(".nav li a.selected").removeClass("selected")
		$(this).addClass("selected");
		
		var title = $(this).find("h2").html();
		var data = _menus[title];
            LeftMenu(data,title);
	});
});

function Clearnav() {

	$("#leftMenu").html();
}

function LeftMenu(data,title) {
var menulist = '<div class="lefttop"><span></span>'+title+'</div>';
	$.each(data, function(i, sm) {
	menulist += '<dd>';
		
		menulist += '<div class="title">';
   		menulist += '<span><img src="images/'+sm.icon+'.png" /></span>'+sm.menuname;
    	
		if(i==0){menulist += '</div><ul class="menuson" style="display:block">';}else{
			menulist += '</div><ul class="menuson">';}
		 
		$.each(sm.menus, function(j, o) {
			menulist += ' <li><cite></cite><a href="#" onclick=\'addTab("'+o.menuname+'","'
					+ o.url + '")\'>' + o.menuname
					+ '</a><i></i></li>';
		});
		menulist += '</ul>';
	menulist += '</dd>';
		});
$("#leftMenu").html(menulist);

//左侧导航切换
	$(".menuson li").on("click",function(){
		$(".menuson li.active").removeClass("active")
		$(this).addClass("active");
	});
	
	$('.title').on("click",function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
}


function addTab(subtitle, url) {
	if (!$('#tabs').tabs('exists', subtitle)) {
		$('#tabs').tabs('add', {
			title : subtitle,
			content : createFrame(url),
			closable : true
		});
	} else {
		$('#tabs').tabs('select', subtitle);
		$('#mm-tabupdate').click();
	}
	tabClose();
}

function createFrame(url) {
	var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;margin-bottom:-3px;"></iframe>';
	return s;
}

function tabClose() {
	/* 双击关闭TAB选项卡 */
	$(".tabs-inner").dblclick(function() {
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close', subtitle);
	});
	/* 为选项卡绑定右键 */
	$(".tabs-inner").bind('contextmenu', function(e) {
		$('#mm').menu('show', {
			left : e.pageX,
			top : e.pageY
		});

		var subtitle = $(this).children(".tabs-closable").text();

		$('#mm').data("currtab", subtitle);
		$('#tabs').tabs('select', subtitle);
		return false;
	});
}

