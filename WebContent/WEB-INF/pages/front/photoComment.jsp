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
<title>index</title>
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
			<div class="col-xs-12" style="background: #c1e0ef;">
				<div style="margin-top: 20px;"></div>
				
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">相片评论</h3>
					</div>
					<div class="panel-body">
						<div class="row">
						
							<div class="col-md-12">
								<div class="thumbnail" >
									<div style="text-align: center;">
										<img src="${prc}/tmp/${listPhotoOne.picture}" class="img-thumbnail" width="200px;">
									</div>
								</div>
							</div>
							
							<div class="col-md-12">
								<div class="thumbnail" >
									<span style="font-size: 18px;">---评论区---</span>
									<hr>
									<!-- 判断用户是否有发表言论 -->
									<c:if test="${empty list}">
										<!-- 言论数据 -->
										<span style="color: #aeaeae;">暂无评论信息</span>
									</c:if>
									<c:if test="${!empty list}">
									<c:forEach items="${list }" var="list">
										<table >
											<tr style="padding-bottom: 10px;">
												<td style="padding-left: 20px;">
													${list.name }&nbsp;:
												</td>
												<td style="padding-left: 20px;">
													${list.content }
												</td >
											</tr>
										</table>
									</c:forEach>
									</c:if>
								</div>
							</div>
							
							<form action="${prc }/photoComment/photoCommentSave" method="post" id="myForm">
								<div class="col-md-12">
									<div class="thumbnail" >
									<!--两个隐藏id:
										photoId:是传过来的
										userId：是session域里的
									  -->
									<input type="hidden" name="photoId" value="${listPhotoOne.id }">
									<input type="hidden" name="userId" value="${sessionScope.user.id }">
									<span style="color: red;">*</span>
									我要评论：<textarea class="form-control" rows="3" name="content" placeholder="说点什么吧。。。"></textarea><br>
						   				<input class="btn btn-primary" type="submit" value="提交">
									</div>
								</div>
							</form>

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
				content:{
			 		required: true,
		     		minlength: 2
				}
			},
			messages:{
				content:{
			 		required: '内容不能为空',
		     		minlength: '字数不能低于2个'
				}
			}
		});
	});
	
	</script>
</body>
</html>