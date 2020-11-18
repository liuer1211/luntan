<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/include/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>menu</title>
<!-- Bootstrap -->
<link href="${prc}/html/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="${prc}/html/js5/jquery-1.12.4.min.js"></script>
<script src="${prc}/html/bootstrap/js/bootstrap.min.js"></script>
<style>
</style>

</head>
<body>
	<div style="height: 5px;"></div>
	<div class="container">
	<div class="row">
		<div class="col-xs-12"
			style="background:#0097df;text-align: center;" id="col">
			<ul class="nav nav-pills">
				<li role="presentation"><a style="color: #ffffff;" href="${prc}/front/indexStart" >网站首页</a></li>
				<li role="presentation"><a style="color: #ffffff;" href="${prc}/user/userInfo?id=${sessionScope.user.id}" >个人中心</a></li>
				<li role="presentation"><a style="color: #ffffff;" href="${prc}/argument/tribuneStart" >论坛社区</a></li>
				<li role="presentation"><a style="color: #ffffff;" href="${prc}/album/albumStart" >群相册</a></li>
				<li role="presentation"><a style="color: #ffffff;" href="${prc}/information/informationStart" >新闻资讯</a></li>
				<!-- <li role="presentation"><a style="color: #ffffff;" href="#" >我的好友</a></li> -->
				<li role="presentation"><a style="color: #ffffff;" href="https://y.qq.com/" >主题音乐</a></li>
				<li role="presentation"><a style="color: #ffffff;" href="https://user.qzone.qq.com/296151852/infocenter" >更多...</a></li>
				
				<!-- 登录-注册跳转 -->
				<c:choose>
					<c:when test="${empty sessionScope.user.name }">
                   		<li role="presentation" style="float: right;">
							<a href="${prc}/front/loginStart" style="color: #ffffff;">登录 </a>
						</li>
						<li role="presentation" style="float: right;">
							<a href="${prc}/front/registerStart" style="color: #ffffff;">注册 </a>
						</li>
                   	</c:when>
                    <c:otherwise>
		           		<li role="presentation" style="float: right;">
							<a href="${prc}/user/loginOut" style="color: #ffffff;">退出 </a>
						</li>
						<%-- <li role="presentation" style="float: right;">
							<img src="${prc}/image/init/head3.png" class="img-circle" height="35px" style="padding-top: 4px;"/>
						</li> --%>
						<li role="presentation" style="float: right;">
							<a href="" style="color: #ffffff;">${sessionScope.user.name }</a>
							<!-- id隐藏起来，做每一个超链接，有用 -->
							<input type="hidden" value="${sessionScope.user.id}" name="id">
						</li>
                     </c:otherwise>
				    </c:choose>
			</ul>
		</div>
	</div>
	</div>
</body>
</html>