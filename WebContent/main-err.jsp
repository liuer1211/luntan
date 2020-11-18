<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>首页</title>
<link rel="stylesheet"
	href="${prc}/html/layui-v2.2.5/layui/css/layui.css" media="all">
</head>
<body>
	<a href="${prc}/back/view">查询管理员</a>

	<div class="layui-carousel" id="test1">
		<div carousel-item>
			<div>
				<img src="${prc}/html/login/images/1.jpg">
			</div>
			<div>
				<img src="${prc}/html/login/images/2.jpg">
			</div>
			<div>
				<img src="${prc}/html/login/images/3.jpg">
			</div>
			<div>
				<img src="${prc}/html/login/images/4.jpg">
			</div>
			<div>
				<img src="${prc}/html/login/images/5.jpg">
			</div>
		</div>
	</div>
	<!-- 条目中可以是任意内容，如：<img src=""> -->

	<script src="${prc}/html/layui-v2.2.5/layui/layui.js"></script>
	<script>
		layui.use('carousel', function() {
			var carousel = layui.carousel;
			//建造实例
			carousel.render({
				elem : '#test1',
				width : '100%',//设置容器宽度
				arrow : 'always' //始终显示箭头
			//,anim: 'updown' //切换动画方式
			});
		});

		//弹出框
		/* layui.use('layer', function(){
		  var layer = layui.layer;
		  layer.msg('hello');
		});  */
	</script>
</body>
</html>