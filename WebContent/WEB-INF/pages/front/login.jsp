<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/include/taglibs.jsp" %>
	<%@page import="java.net.URLDecoder"%>
	<%
	String cookieUserName="";
	String cookieUserPassword="";
	Cookie[] cookies=request.getCookies();
	if(cookies!=null){
		for(Cookie cook:cookies){
			if("COOKIENAME".equals(cook.getName())){
				cookieUserName=URLDecoder.decode(cook.getValue(), "utf-8");
			}
			if("COOKIEPASSWORD".equals(cook.getName())){
				cookieUserPassword=URLDecoder.decode(cook.getValue(), "utf-8");
			}
		}
	}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>login</title>
<!-- Bootstrap -->
<link href="${prc}/html/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="${prc}/html/js5/jquery-1.12.4.min.js"></script>
<script src="${prc}/html/bootstrap/js/bootstrap.min.js"></script>
<style>
    .error {
      color: #F00;
    }
    /* 或弹出错误提示，jquery错误提示中 class="error" */
</style>
</head>
<body style="background: #ededed;">
	
	<jsp:include  page="/head.jsp"/> 
	<jsp:include  page="/menu.jsp"/>
	
	<div style="height: 5px;"></div>
	
	<div class="container">
		<div class="row">
			<div class="col-xs-8" style="background: #c1e0ef;">
				<!-- <h2 class="page-header">区域一</h2> -->
				<img src="${prc}/images/register/l1.png" class="img-rounded" width="100%/9"
					style="padding: 15px 0px 15px 0px;">
				<!-- width="100%/9" -->

			</div>
			<div class="col-xs-4" style="background: #c1e0ef;">
				<h3 class="page-header" style="color: #0097df;">轻松登陆，快人一步</h3>
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">登录</h3>
					</div>
					<div class="panel-body">
						<form class="form-horizontal" action="${prc}/user/login" method="post" id="myValidate">
							
							<!--用户名  -->
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">用户名</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="" value="<%=cookieUserName %>" name="name" placeholder="请输入用户名">
								</div>
							<!-- 	<div class="col-sm-offset-2"></div> -->
							</div>
							<!-- 密码 -->
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">密码</label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="" value="<%=cookieUserPassword %>" name="password" placeholder="请输入密码">
								</div>
							</div>
							<!-- 记住密码 -->
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">&nbsp;&nbsp;</label>
								<div class=" col-sm-9">
									<div class="checkbox">
										<label> 
											<input type="checkbox" checked="checked" value="true" name="remember"> 记住密码
										</label>
									</div>
								</div>
							</div>
							<!-- 提交 -->
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">&nbsp;&nbsp;</label>
								<div class=" col-sm-9">
									<input type="submit" class="btn btn-primary" value="登录"/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="${prc}/front/registerStart">还没有开通，去注册</a>
								</div>
							</div>

							<!-- 错误提示 -->
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">&nbsp;&nbsp;</label>
								<div class=" col-sm-10" style="color: red;">
									<label for="" class="col-sm-9 control-label">${error }</label>
								</div>
							</div>
							
						</form>
					</div>
				</div>
				<!-- <h2 class="page-header">区域-1</h2> -->
			</div>

		</div>
	</div>
	<!-- <div style="height: 10px;"></div> -->
	<%@include file="/foot.jsp" %>
	
	<!-- from表单的验证，jquery技术 -->
	<!-- jquery表单验证，jar包不能放到最上面 -->
	<script type="text/javascript" src="${prc}/html/js5/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="${prc}/html/js5/jquery.validate.js"></script>
	<script type="text/javascript">
		$(function(){
			$('#myValidate').validate({
				rules:{
					name: {
				        required: true,
				        minlength: 2,
				        maxlength: 16
				    },
				    password: {
				        required: true,
				        minlength: 6,
				        maxlength: 12
				    }
				},
				messages:{
				 	name:{
					 	 required: '用户名必填',
						 minlength: '用户名必须大于或等于2位',
						 maxlength: '用户名必须小于或等于16位'
				 	},
				 	password:{
					 	required:'密码必填',
					 	minlength:'密码必须大于或等于6位',
					 	maxlength:'密码必须小于或等于12位'
				 	}
			 	}
			})
		})
	</script>
</body>
</html>