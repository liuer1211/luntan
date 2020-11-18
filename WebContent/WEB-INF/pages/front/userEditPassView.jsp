<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<!-- Bootstrap -->
<link href="${prc}/html/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script src="${prc}/html/js5/jquery-1.12.4.min.js"></script>
<script src="${prc}/html/bootstrap/js/bootstrap.min.js"></script>
<style>
.error {
	color: #F00;
}
/* 或弹出错误提示，jquery错误提示中 class="error" */
</style>
</head>
<body>

	<!-- 主题内容 -->
	<div class="container">
		<div class="row">
			<!-- 左侧内容 -->
			<div class="col-xs-12">
				<h3 class="page-header" style="color: #0097df;">${user.name }</h3>
				<div class="panel panel-primary">
					<!-- form表单 -->
					<div class="panel-body">
						<form class="form-horizontal" action="${prc }/user/userEditPass" id="myForm">
							<input type="hidden" name="id" value="${user.id }">
							<!--  -->
							<div class="form-group">
								<label for="" class="col-sm-4 control-label"> <span
									style="color: red;">*</span>新&nbsp;&nbsp;密&nbsp;码
								</label>
								<div class="col-sm-8">
									<input type="password" name="password" id="password"
										class="form-control" placeholder="输入新密码" required
										minlength="6" maxlength="12">
								</div>
							</div>

							<!--  -->
							<div class="form-group">
								<label for="" class="col-sm-4 control-label"> <span
									style="color: red;">*</span>确&nbsp;&nbsp;认&nbsp;密&nbsp;码
								</label>
								<div class="col-sm-8">
									<input type="password" name="twoPassword" class="form-control"
										placeholder="再次输入密码" equalTo="#password">
								</div>
							</div>
							<!-- 提交 -->
							<div class="form-group">
								<div class="col-sm-12 col-sm-offset-3">
									<input type="submit" class="btn btn-primary" value="提交" />
								</div>
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- from表单的验证，jquery技术 -->
	<!--_footer 作为公共模版分离出去-->
	<script type="text/javascript" src="${prc}/html/layer/2.4/layer.js"></script>
	
	<!-- jquery表单验证，jar包不能放到最上面 -->
	<script type="text/javascript" src="${prc}/html/js5/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="${prc}/html/js5/jquery.validate.js"></script>
	<script type="text/javascript">
		
	$(function () {
	    $('#myForm').validate({
	    	messages : {
				password : {
					required : '密码必填',
					minlength : '密码必须大于或等于6位',
					maxlength : '密码必须小于或等于12位'
				},
				twoPassword : {
					equalTo : '确认密码必须与密码相同'
				}
			},
	    });
	  });
	
	</script>
</body>
</html>