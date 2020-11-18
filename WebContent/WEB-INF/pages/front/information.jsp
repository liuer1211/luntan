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

	<div class="container">
		<div class="row">
			<div class="col-xs-12" style="background: #c1e0ef;">
				<div style="margin-top: 20px;"></div>

				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">新闻模块</h3>
					</div>
					
					<!-- 判断用户是否有发表言论 -->
					<c:if test="${empty list}">
						<div class="panel-body">
							<div class="row">
								<!-- 言论数据 -->
								<div class="col-md-12">
									<div class="thumbnail">
										<span style="color: #aeaeae;">
											暂时没有新的消息
										</span>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<c:if test="${!empty list}">
					<div class="panel-body">
						<div class="row">
							<!-- 新闻遍历 -->
							<c:forEach items="${list }" var="list">
								<div class="col-md-12">
									<div class="thumbnail">
										<table>
											<tr >
												<td rowspan="3" style="width: 150px; height: 150px;">
													<a href="${list.link }">
														<img src="${prc}/tmp/${list.picture }" class="img-thumbnail" width="300px;">
													</a>
												</td>
												<td style="padding-left: 10px; font-size: 18px; height: 35px; ">
													<a href="${list.link }">
														${list.title }
													</a>
												</td>
											</tr>
											<tr>
												<td style="padding-left: 10px; color: #808080; height: 35px; ">
													更新时间：${list.dateTimes }</td>
											</tr>
											<tr>
												<td
													style="padding-left: 10px; font-family: serif; font-size: 16px;">
													&nbsp;&nbsp;&nbsp;${list.content }</td>
											</tr>
										</table>
									</div>
								</div>
							</c:forEach>

							<!-- 分页 -->
							<ul class="pager">
								<li><a href="${prc }/information/informationStart"> 首页 </a></li>
								<li><c:if test="${currentPage==1 }">上一页 </c:if> <c:if
										test="${currentPage>1 }">
										<a href="${prc }/information/informationStart?page=${currentPage-1 }">上一页
										</a>
									</c:if></li>
								<li><c:if test="${currentPage==totalPage }">下一页 </c:if> <c:if
										test="${currentPage!=totalPage }">
										<a href="${prc }/information/informationStart?page=${currentPage+1 }">下一页
										</a>
									</c:if></li>
								<li><a
									href="${prc }/information/informationStart?page=${totalPage }">末页
								</a></li>
								<li><a href="#">第${currentPage }页</a></li>
								<li><a href="#">总共${count }记录</a></li>
								<li><a href="#">总共${totalPage }页</a></li>
							</ul>

						</div>
					</div>
					</c:if>
					
				</div>

			</div>
		</div>
	</div>

	<jsp:include page="/foot.jsp"></jsp:include>
</body>
</html>