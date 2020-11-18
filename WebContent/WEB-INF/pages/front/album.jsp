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
</head>
<body style="background: #ededed;">
	<jsp:include page="/head.jsp" />
	<jsp:include page="/menu.jsp" />
	<div style="height: 5px;"></div>
	<!-- 正文 -->
	<div class="container">
		<div class="row">
			<div class="col-xs-12" style="background: #c1e0ef;">
				<div style="margin-top: 20px;"></div>
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">群相册展示</h3>
					</div>
					<%-- <h4 style="padding-left: 15px;">
						<a href="${prc }/album/albumAddView?id=${sessionScope.user.id}" class="btn btn-default">
							<span class="glyphicon glyphicon-plus"></span>我要新建相册
						</a>
					</h4> --%>
					<div class="panel-body">
						<div class="row">
						    <!-- 判断用户是否有相册 -->
							<c:if test="${empty listOne}">
								<div class="col-md-12">
									<div class="thumbnail" style="text-align: center;">
										<span style="font-size: 22px;color: gray;">没有创建任何相册</span>
										<img src="${prc}/image/mingsheng/0.jpg" class="img-thumbnail" width="100/9">
									</div>
								</div>
							</c:if>
							<c:if test="${!empty listOne }">
								<!-- 遍历相册，单人 -->
								<c:forEach items="${listOne }" var="listOne">
									<div class="col-md-3">
										<div class="thumbnail" style="text-align: center;height: 175px;">
											<a href="${prc }/photo/photoListStart?albumId=${listOne.id }">
												<img src="${prc}/tmp/${listOne.picture }" class="img-thumbnail" width="120px;" height="120px;">
											</a>
											<div class="caption">
												<p>
													<input type="hidden" value="${listOne.id }"> 
													<input type="hidden" value="${listOne.userId }"> 
													<a href="${prc }/photo/photoListStart?albumId=${listOne.id }">${listOne.title }</a>
													<%-- &nbsp;&nbsp;&nbsp;&nbsp; 
													<a href="${prc }/album/albumDelete?id=${listOne.id }" class="btn btn-default">
														<span class="glyphicon glyphicon-trash"></span>
													</a> --%>
													<br>
													<span style="color: #ababab;">
														${listOne.name }&nbsp;&nbsp;&nbsp;&nbsp;
														${listOne.createDate }
													</span>
												</p>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/foot.jsp"></jsp:include>
</body>
</html>