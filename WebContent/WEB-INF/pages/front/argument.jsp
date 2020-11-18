<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>index</title>
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
<body style="background: #ededed;">
	<jsp:include page="/head.jsp" />
	<jsp:include page="/menu.jsp" />
	<div style="height: 5px;"></div>
	<div class="container">
		<div class="row">
			<!-- 所有信息 -->
			<div class="col-xs-12" style="background: #c1e0ef;">
				<div style="margin-top: 20px;"></div>
				<div class="panel panel-primary">
					<div class="panel-body">
						<div class="row">
							<div class="col-md-12">
								<form action="${prc }/argument/argumentSave" id="myForm" method="post">
								<div class="thumbnail">
									<!-- 隐藏id，argument中是userID，user中是id -->
									<input type="hidden" name="userId" value="${list.id}">
								性质：<label class="radio-inline"> 
										<input type="radio" name="property" value="1" checked="checked"> 提问
									</label> 
									<label class="radio-inline"> 
										<input type="radio" name="property" value="2"> 分享
									</label> 
									<br>
									<br> <span style="color: red;">*</span>
								题目：<input type="text" name="title" class="form-control" placeholder="输入题目">
									<br> <span style="color: red;">*</span>
								内容： <textarea class="form-control" name="content" rows="8" placeholder="说点什么吧。。。"></textarea>
									<br> 
									<input class="btn btn-primary" type="submit" value="提交">
								</div>
								</form>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="/foot.jsp"></jsp:include>
	
	<!-- from表单的验证，jquery技术 -->
	<!-- jquery表单验证，jar包不能放到最上面 -->
	<script type="text/javascript" src="${prc}/html/js5/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="${prc}/html/js5/jquery.validate.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#myForm").validate({
			rules:{
				title:{
					 required: true,
				     maxlength: 20
				},
				content:{
			 		required: true,
		     		minlength: 10
				}
			},
			messages:{
				title:{
					required:'题目不能为空',
					maxlength: '字数不能超过20个'
				},
				content:{
			 		required: '内容不能为空',
		     		minlength: '字数不能低于10个'
				}
			}
		});
	});
	
	</script>
	
</body>
</html>