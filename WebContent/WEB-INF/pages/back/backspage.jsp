<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/include/taglibs.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <!--html5shiv：解决ie9以下浏览器对html5新增标签的不识别，并导致CSS不起作用的问题。
    respond.min:让不支持css3 Media Query的浏览器包括IE6-IE8等其他浏览器支持查询。-->
    <script type="text/javascript" src="${prc}/html/js/html5shiv.js"></script>
    <script type="text/javascript" src="${prc}/html/js/respond.min.js"></script>
   
    <link rel="stylesheet" type="text/css" href="${prc}/html/h-ui/css/H-ui.min.css" />
    <!--相当与ztree-->
    <link rel="stylesheet" type="text/css" href="${prc}/html/h-ui.admin/css/H-ui.admin.css" />
    <!-- 图标 -->
    <link rel="stylesheet" type="text/css" href="${prc}/html/Hui-iconfont/1.0.8/iconfont.css" />
    <!-- 皮肤样式 -->
    <link rel="stylesheet" type="text/css" href="${prc}/html/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${prc}/html/h-ui.admin/css/style.css" />
    <!-- 解决IE6 一下不能解决的插件图 -->
    <script type="text/javascript" src="${prc}/html/js1/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
   
    <title>学生论坛管理系统后台</title>
</head>
<body>
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl"> 
        	<img alt="logo" src="${prc}/images/logo123.png" height="" class="logo navbar-logo f-l mr-10 hidden-xs">
        	
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">
                   <!-- 登录 保存用户名 -->
                   <!--  session判断 -->
                   <c:choose>
					<c:when test="${empty sessionScope.manager.name }">
                   		<li > 
                    		<a href="${prc}/back/loginStart" >登录 </a> 
                    	</li> 
                    </c:when>
				    <c:otherwise>
		           		<li class="dropDown dropDown_hover">
                        <a href="#" class="dropDown_A">
                        	${sessionScope.manager.name}  
                        	<i class="Hui-iconfont">&#xe6d5;</i>
                        </a>
                        <ul class="dropDown-menu menu radius box-shadow">
                             <!-- <li><a href="javascript:;" onClick="myselfinfo()">个人信息</a></li> -->
                            <!--<li><a href="#">切换账户</a></li> -->
                            <li><a href="${prc}/back/loginOut">退出</a></li>
                        </ul>
                    	</li>
                     </c:otherwise>
				    </c:choose>
                  
                    <li id="Hui-skin" class="dropDown right dropDown_hover"> 
                    	<a href="javascript:;" class="dropDown_A" title="换肤">
                    		<i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i>
                   		</a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                            <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                            <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                            <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                            <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                            <li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<aside class="Hui-aside">
    <div class="menu_dropdown bk_2">
        <dl id="menu-article">
            <dt><i class="Hui-iconfont">&#xe62d;</i> 管理员管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li>
                    	<a data-href="${prc}/manager/getManagers" data-title="管理员列表" href="javascript:void(0)">管理员列表</a>
                    </li>
                </ul>
            </dd>
        </dl> 
        <dl id="menu-picture">
            <dt><i class="Hui-iconfont">&#xe60d;</i> 用户管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li>
                    	<a data-href="${prc}/manager/getUsers" data-title="用户列表" href="javascript:void(0)">用户列表</a>
                    </li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-picture">
            <dt><i class="Hui-iconfont">&#xe622;</i> 言论管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li>
                    	<a data-href="${prc}/manager/getArguments" data-title="言论列表" href="javascript:void(0)">言论列表</a>
                    </li>
                    <li>
                    	<a data-href="${prc}/manager/getComments" data-title="评论列表" href="javascript:void(0)">评论列表</a>
                    </li>
                </ul>
            </dd>
        </dl>
       <dl id="menu-picture">
            <dt><i class="Hui-iconfont">&#xe612;</i> 照片管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li>
                    	<a data-href="${prc}/manager/getAlbums" data-title="相册列表" href="javascript:void(0)">相册列表</a>
                    </li>
                    <li>
                    	<a data-href="${prc}/manager/getPhotos" data-title="照片列表" href="javascript:void(0)">照片列表</a>
                    </li>
                    <li>
                    	<a data-href="${prc}/manager/getPhotoComments" data-title="照片评论列表" href="javascript:void(0)">照片评论列表</a>
                    </li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-picture">
            <dt><i class="Hui-iconfont">&#xe63b;</i> 新闻管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li>
                    	<a data-href="${prc}/manager/getInformations" data-title="新闻列表" href="javascript:void(0)">新闻列表</a>
                    </li>
                </ul>
            </dd>
        </dl>
      
    </div>
</aside>
<!-- 控制左侧显示 -->
<div class="dislpayArrow hidden-xs">
	<a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)">
	</a>
</div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active">
                    <span title="我的桌面" data-href="">我的桌面</span>
                    <!-- <i></i> --><!-- 错号图标 -->
                    <em></em><!-- 间隔 -->
                </li>
            </ul>
        </div>
        <!-- 没有用到 -->
        <div class="Hui-tabNav-more btn-group">
        	<a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;">
       		    <i class="Hui-iconfont">&#xe6d4;</i>
        	</a>
        	<a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;">
        		<i class="Hui-iconfont">&#xe6d7;</i>
        	</a>
        </div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="${prc}/back/welcome"></iframe>
        </div>
    </div>
</section>

<div class="contextMenu" id="Huiadminmenu">
    <ul>
        <li id="closethis">关闭当前 </li>
        <li id="closeall">关闭全部 </li>
    </ul>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${prc}/html/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${prc}/html/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${prc}/html/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${prc}/html/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<!-- 点击右键，触发事件 -->
<script type="text/javascript" src="${prc}/html/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
<script type="text/javascript">
    $(function(){
        /*$("#min_title_list li").contextMenu('Huiadminmenu', {
         bindings: {
         'closethis': function(t) {
         console.log(t);
         if(t.find("i")){
         t.find("i").trigger("click");
         }
         },
         'closeall': function(t) {
         alert('Trigger was '+t.id+'\nAction was Email');
         },
         }
         });*/
    });
    /*个人信息*/
    function myselfinfo(){
       /*  layer.open({
            type: 1,
            area: ['300px','200px'],
            fix: false, //不固定
            maxmin: true,
            shade:0.4,
            title: '查看信息',
            content: '<div>管理员信息</div>'
        }); */
    }



</script>

</body>
</html>