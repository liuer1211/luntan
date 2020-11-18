<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/include/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>学生论坛后台登录</title>

<link rel="stylesheet" href="${prc}/html/login/css/style.css">

<body>

<div class="login-container">
	<h1>学生论坛后台登录</h1>
	
	<form action="${prc}/back/login" method="post" id="loginForm">
		<div>
			<input type="text" name="name" class="username" placeholder="用户名" autocomplete="off"/>
		</div>
		<div>
			<input type="password" name="password" class="password" placeholder="密码" oncontextmenu="return false" onpaste="return false" />
		</div>
		<button id="submit" type="submit">登 陆</button> 
		<!-- <input type="submit" value="登录"> -->
		<div style="display:none;color: red;" id="errors">
			<br><br>
			${error }
		</div>
	</form>
</div>
<!-- 弹出框 -->
<script type="text/javascript" src="${prc}/html/layer/2.4/layer.js"></script>
<!-- 以下是登录的jquery -->
<script src="${prc}/html/login/js/jquery.min.js"></script>
<script src="${prc}/html/login/js/common.js"></script>
<!--背景图片自动更换-->
<script src="${prc}/html/login/js/supersized.3.2.7.min.js"></script>
<%-- <script src="${prc}/html/login/js/supersized-init.js"></script> --%>
<!-- js里  关于图片的地址不能  显示  所以写到这里 -->
<script type="text/javascript">
//背景图片
jQuery(function($){
    $.supersized({
        // 功能
        slide_interval     : 4000,    // 转换之间的长度
        transition         : 1,    // 0 - 无，1 - 淡入淡出，2 - 滑动顶，3 - 滑动向右，4 - 滑底，5 - 滑块向左，6 - 旋转木马右键，7 - 左旋转木马
        transition_speed   : 1000,    // 转型速度
        performance        : 1,    // 0 - 正常，1 - 混合速度/质量，2 - 更优的图像质量，三优的转换速度//（仅适用于火狐/ IE浏览器，而不是Webkit的）

        // 大小和位置
        min_width          : 0,    // 最小允许宽度（以像素为单位）
        min_height         : 0,    // 最小允许高度（以像素为单位）
        vertical_center    : 1,    // 垂直居中背景
        horizontal_center  : 1,    // 水平中心的背景
        fit_always         : 0,    // 图像绝不会超过浏览器的宽度或高度（忽略分钟。尺寸）
        fit_portrait       : 1,    // 纵向图像将不超过浏览器高度
        fit_landscape      : 0,    // 景观的图像将不超过宽度的浏览器

        // 组件
        slide_links        : 'blank',    // 个别环节为每张幻灯片（选项：假的，'民'，'名'，'空'）
        slides             : [    // 幻灯片影像
                                 {image : '${prc}/html/login/images/4.jpg'},
                                 {image : '${prc}/html/login/images/5.jpg'},
                                 {image : '${prc}/html/login/images/6.jpg'},
                                 {image : '${prc}/html/login/images/1.jpg'},
                                 {image : '${prc}/html/login/images/2.jpg'},
                                 {image : '${prc}/html/login/images/3.jpg'}
                       ]

    });
});

//登录的  错误提示
$(function(){
	 /* type="hidden" */
/* 	HTML：获得文本的值（内容），如果包含标签，则也显示标签内容
	Text：获得文本的值（内容），如果包含标签，不显示标签，只显示值（内容） */
	var e=$('#errors').text();
	//不显示内容
	//alert(e)
	//显示  11   ，为啥
	//alert(e.length);
	//这样做其实没有起到想要的效果
	if(e!=null){
		//alert(e);
		$("#errors").css('display','block');
		//layer.msg('error',{icon:1,time:2000});
	}else{
		$("#errors").css('display','none');
	}
});
</script>
<!--表单验证-->
<script src="${prc}/html/login/js/jquery.validate.min.js?var1.14.0"></script>

</body>
</html>