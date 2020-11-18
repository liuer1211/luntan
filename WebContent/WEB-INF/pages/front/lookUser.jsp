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
						<h3 class="panel-title">详细信息</h3>
					</div>
					<!-- 页面身体 -->
					<div class="panel-body">
						<div class="row">
							<!-- 个人信息 -->
							<div class="col-md-12">
								<div class="thumbnail" style="text-align: center;">
									<img src="${prc}/tmp/${userOne.picture }" class="img-circle"
										width="100/9"> 
									<span style="font-size: 24px;">${userOne.name }</span>
									<br>
									<c:if test="${userOne.describes == null}">
										(这个人很懒，什么有没有说)
									</c:if>
									<c:if test="${userOne.describes != null}">
										<span style="font-size: 16px;">(${userOne.describes })</span>
									</c:if>
									<table class="table table-hover" style="text-align: center;">
										<colgroup>
											<col class="col-xs-4">
											<col class="col-xs-4">
											<col class="col-xs-4">
										</colgroup>
										<tbody>
											<tr class="active">
												<td>电话：${userOne.mobile }</td>
												<td>邮箱：${userOne.email }</td>
												<td>地址：${userOne.address }</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<!-- 判断用户是否有发表言论 -->
							<c:if test="${empty listArgumentOnes}">
								<div class="panel-body">
									<div class="row">
										<!-- 言论数据 -->
										<div class="col-md-12">
											<div class="thumbnail">
												<span style="color: #aeaeae;"> 暂无发表言论 </span>
											</div>
										</div>
									</div>
								</div>
							</c:if>
							<c:if test="${!empty listArgumentOnes}">
								<div class="panel-body">
									<div class="row">
										<!-- 言论数据 -->
										<c:forEach var="list" items="${listArgumentOnes }">
											<div class="col-md-6">
												<div class="thumbnail">
													<table>
														<tr>
															<td style="padding-left: 20px; color: green;"><c:if
																	test="${list.property == '1'}">提问</c:if> <c:if
																	test="${list.property == '2'}">分享</c:if></td>
															<td style="padding-left: 20px;"><a
																href="${prc }/comment/commentStart?id=${list.id }">${list.title }</a>
															</td>
														</tr>
														<tr>
															<td style="padding-left: 20px;"><a href="#">
																	${list.name } </a></td>
															<td style="padding-left: 20px; color: #808080;">
																${list.publishTime }</td>
														</tr>
													</table>
												</div>
											</div>
										</c:forEach>
									</div>
									<!-- 分页 -->
									<ul class="pager">
										<li><a
											href="${prc}/user/lookUser?id=${sessionScope.user.id}">
												首页 </a></li>
										<li><c:if test="${currentPage==1 }">上一页 </c:if> <c:if
												test="${currentPage>1 }">
												<a
													href="${prc}/user/lookUser?id=${sessionScope.user.id}&page=${currentPage-1 }">上一页
												</a>
											</c:if></li>
										<li><c:if test="${currentPage==totalPage }">下一页 </c:if> <c:if
												test="${currentPage!=totalPage }">
												<a
													href="${prc}/user/lookUser?id=${sessionScope.user.id}&page=${currentPage+1 }">下一页
												</a>
											</c:if></li>
										<li><a
											href="${prc}/user/lookUser?id=${sessionScope.user.id}&page=${totalPage }">末页
										</a></li>
										<li><a href="#">第${currentPage }页</a></li>
										<li><a href="#">总共${count }记录</a></li>
										<li><a href="#">总共${totalPage }页</a></li>
									</ul>
								</div>
							</c:if>

							<!-- 判断用户是否有相册 -->
							<c:if test="${empty listOneAlbum}">
								<div class="col-md-12">
									<div class="thumbnail" style="text-align: center;">
										<span style="font-size: 22px; color: gray;">没有创建任何相册</span> <img
											src="${prc}/image/mingsheng/0.jpg" class="img-thumbnail"
											width="100/9">
									</div>
								</div>
							</c:if>
							<c:if test="${!empty listOneAlbum }">
								<!-- 遍历相册，单人 -->
								<c:forEach items="${listOneAlbum }" var="listOneAlbum">
									<div class="col-md-3">
										<div class="thumbnail"
											style="text-align: center; height: 175px;">
											<a
												href="${prc }/photo/photoListStart?albumId=${listOneAlbum.id }">
												<img src="${prc}/tmp/${listOneAlbum.picture }"
												class="img-thumbnail" width="120px;" height="120px;">
											</a>
											<div class="caption">
												<p>
													<input type="hidden" value="${listOneAlbum.id }"> <input
														type="hidden" value="${listOneAlbum.userId }"> <a
														href="${prc }/photo/photoListStart?albumId=${listOneAlbum.id }">${listOneAlbum.title }</a>
													<%-- &nbsp;&nbsp;&nbsp;&nbsp; 
													<a href="${prc }/album/albumDelete?id=${listOne.id }" class="btn btn-default">
														<span class="glyphicon glyphicon-trash"></span>
													</a> --%>
													<br> <span style="color: #ababab;">
														${listOneAlbum.name }&nbsp;&nbsp;&nbsp;&nbsp;
														${listOneAlbum.createDate } </span>
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