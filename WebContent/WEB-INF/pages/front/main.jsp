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

	<%-- <%@include file="head.jsp"%>
	<%@include file="menu.jsp"%> --%>
	<jsp:include page="/head.jsp" />
	<jsp:include page="/menu.jsp" />

	<div style="height: 5px;"></div>

	<div class="container">
		<div class="row">
			<!-- 左边个人信息 -->
			<div class="col-xs-3" style="background: #c1e0ef;">
				<div>
					<div style="margin-top: 10px;"></div>
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">基本资料</h3>
						</div>
						<div class="panel-body">
							<!--img-circle  -->
							<a href="${prc}/user/userUpdate/${userOne.id}"> <img
								src="${prc}/tmp/${userOne.picture }" class="img-circle"
								width="100%/9" style="padding: 10px 30px 10px 30px;">
							</a>
							<p
								style="text-align: center; font-size: 22px; font-family: sans-serif;">
								${userOne.name }</p>
							<p style="text-align: center;">
								<a class="btn btn-primary"
									href="${prc}/user/userUpdate/${userOne.id}">修改信息</a>
								<%-- <a class="btn btn-primary" href="javascript:;" onclick="user_edit('${userOne.id}')">修改密码</a> --%>
								<a class="btn btn-primary"
									href="${prc}/user/userEditPassView?id=${userOne.id}">修改密码</a>
							</p>
						</div>
					</div>
				</div>

				<div>
					<div class="list-group">
						<a class="list-group-item active"> 最近登录 </a>
						<c:forEach var="userList" items="${userList }">
							<a href="${prc }/user/lookUser?id=${userList.id}" class="list-group-item"> 
								<span style="color: #0000ff;">${userList.name}</span> 
								<span class="glyphicon glyphicon-star-empty"></span>
								<span style="color: #8080c0;">${userList.loginDate}</span> 
							</a>
						</c:forEach>
					</div>
				</div>
				
			</div>
			<!-- 右边所有人的信息 -->
			<div class="col-xs-9" style="background: #c1e0ef;">
				<div style="margin-top: 10px;"></div>
				<!--个人发帖  -->
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">个人发帖</h3>
					</div>
					<br>
					<a style="margin-left: 15px;"
						href="${prc}/argument/argumentStart?id=${sessionScope.user.id}"
						class="btn btn-default"> 
						<span class="glyphicon glyphicon-pencil"></span> 我要发表
					</a> 
					<br>
					<!--  -->
					<!-- 判断用户是否有发表言论 -->
					<c:if test="${empty listArgumentOnes}">
						<div class="panel-body">
							<div class="row">
								<!-- 言论数据 -->
								<div class="col-md-12">
									<div class="thumbnail">
										<span style="color: #aeaeae;">
											暂无发表言论
										</span>
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
								href="${prc}/user/userInfo?id=${sessionScope.user.id}"> 首页 </a></li>
							<li><c:if test="${currentPage==1 }">上一页 </c:if> <c:if
									test="${currentPage>1 }">
									<a
										href="${prc}/user/userInfo?id=${sessionScope.user.id}&page=${currentPage-1 }">上一页
									</a>
								</c:if></li>
							<li><c:if test="${currentPage==totalPage }">下一页 </c:if> <c:if
									test="${currentPage!=totalPage }">
									<a
										href="${prc}/user/userInfo?id=${sessionScope.user.id}&page=${currentPage+1 }">下一页
									</a>
								</c:if></li>
							<li><a
								href="${prc}/user/userInfo?id=${sessionScope.user.id}&page=${totalPage }">末页
							</a></li>
							<li><a href="#">第${currentPage }页</a></li>
							<li><a href="#">总共${count }记录</a></li>
							<li><a href="#">总共${totalPage }页</a></li>
						</ul>
					</div>
					</c:if>
				</div>

				<!-- 名著推荐 -->
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">我的相册</h3>
					</div>
					<h4 style="padding-left: 15px;">
						<a href="${prc }/album/albumAddView?id=${sessionScope.user.id}" class="btn btn-default">
							<span class="glyphicon glyphicon-plus"></span>新建相册
						</a>
					</h4>
					<div class="panel-body">
						<div class="row">
							
							 <!-- 判断用户是否有相册 -->
							<c:if test="${empty listOneAlbum}">
								<div class="col-md-12">
									<div class="thumbnail" style="text-align: center;">
										<span style="font-size: 22px;color: gray;">没有创建任何相册</span>
										<img src="${prc}/image/mingsheng/0.jpg" class="img-thumbnail" width="100/9">
									</div>
								</div>
							</c:if>
							<c:if test="${!empty listOneAlbum }">
								<!-- 遍历相册，单人 -->
								<c:forEach items="${listOneAlbum }" var="listOneAlbum">
									<div class="col-md-3">
										<div class="thumbnail" style="text-align: center;height: 175px;">
											<a href="${prc }/photo/photoStart?albumId=${listOneAlbum.id }">
												<img src="${prc}/tmp/${listOneAlbum.picture }" class="img-thumbnail" width="120px;" height="120px;">
											</a>
											<div class="caption">
												<p>
													<input type="hidden" value="${listOneAlbum.id }"> 
													<input type="hidden" value="${listOneAlbum.userId }"> 
													<a href="${prc }/photo/photoStart?albumId=${listOneAlbum.id }">${listOneAlbum.title }</a>
													<%-- &nbsp;&nbsp;&nbsp;&nbsp; 
													<a href="${prc }/album/albumDelete?id=${listOneAlbum.id }" class="btn btn-default">
														<span class="glyphicon glyphicon-trash"></span>
													</a> --%>
												</p>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:if>

						</div>
					</div>
				</div>

				<!--  -->
			</div>
		</div>
	</div>

	<!-- <div style="height: 10px;"></div> -->
	<%-- <%@include file="foot.jsp"%> --%>
	<jsp:include page="/foot.jsp"></jsp:include>

	<!--_footer 作为公共模版分离出去-->
	<script type="text/javascript"
		src="${prc}/html/jquery/1.9.1/jquery.min.js"></script>
	<!-- 单独使用layer弹出-->
	<script type="text/javascript" src="${prc}/html/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="${prc}/html/h-ui/js/H-ui.min.js"></script>
	<script type="text/javascript"
		src="${prc}/html/h-ui.admin/js/H-ui.admin.js"></script>
	<!--/_footer 作为公共模版分离出去-->

	<!--请在下方写此页面业务相关的脚本-->
	<!-- 日期 -->
	<script type="text/javascript"
		src="${prc}/html/My97DatePicker/4.8/WdatePicker.js"></script>
	<script type="text/javascript"
		src="${prc}/html/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<!-- layui 多功能js分页 -->
	<script type="text/javascript" src="${prc}/html/laypage/1.2/laypage.js"></script>
	<script type="text/javascript">
		//编辑
		/* //id是参数
		function user_edit(id){
		   layer_show("修改密码","${prc}/user/userEditPassView?id="+id,'','510');
		} */
	</script>
</body>
</html>