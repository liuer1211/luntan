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
			<!-- 左边个人信息 -->
			<div class="col-xs-3" style="background: #c1e0ef;">
				<!-- 左侧：新论点 -->
				<div>
					<div style="margin-top: 20px;"></div>
					<div class="list-group">
						<a class="list-group-item active"> 最新论点 </a> <a
							href="http://fly.layui.com/jie/26443/" class="list-group-item">点击select下拉框，为什么出发不了点击事件 </a> 
							<a href="http://fly.layui.com/jie/5366/" class="list-group-item">layui
							常见问题的处理和实用干货集锦 </a> <a href="http://layer.layui.com/"
							class="list-group-item">layer官方演示与讲解(jQuery弹出层插件) </a> <a
							href="http://fly.layui.com/jie/19804/" class="list-group-item">《layui从鱼到渔》系列教程
						</a> <a href="http://fly.layui.com/jie/8157/" class="list-group-item">下载“Fly社区”页面模板：Fly
							Template </a> <a
							href="https://blog.csdn.net/tooky_poom/article/details/78550323"
							class="list-group-item">table 字段名称行 在没有数据的时候显示不全</a> <a
							href="http://fly.layui.com/jie/25879/" class="list-group-item">我在用vue+layui的时候发现一个很尴尬的事情</a>
					</div>
				</div>
				<!-- 左侧：其他论坛 -->
				<div>
					<div class="list-group">
						<a class="list-group-item active"> 其他论坛 </a> <a
							href="http://bbs.tianya.cn/" class="list-group-item">天涯论坛</a> <a
							href="http://www.sohu.com/a/210597631_117915"
							class="list-group-item">中华网论坛</a> <a
							href="http://news.163.com/bbsphoto/" class="list-group-item">网易社区</a>
						<a href="http://www.sina.com.cn/" class="list-group-item">新浪主题社区</a>
						<a href="http://www.verycd.com/" class="list-group-item">VeryCD论坛</a>
					</div>
				</div>
				<div style="height: 0px;"></div>
			</div>
			<!-- 右边所有人的信息 -->
			<div class="col-xs-9" style="background: #c1e0ef;">
				<div style="margin-top: 20px;"></div>
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">论点列表</h3>
					</div>

					<!-- 这个id是session的 -->
					<div class="panel-body">
						<a href="${prc}/argument/argumentStart?id=${sessionScope.user.id}"
							class="btn btn-default"> <span
							class="glyphicon glyphicon-pencil"></span> 我要发表
						</a> <br>
						<br>
						<!-- 判断用户是否有发表言论 -->
						<c:if test="${empty list}">
							<!-- 言论数据 -->
							<div class="col-md-12">
								<div class="thumbnail">
									<span style="color: #aeaeae;">
										暂无言论信息
									</span>
								</div>
							</div>
						</c:if>
						<c:if test="${!empty list}">
							<!-- 这个table完全从bootstrap中复制的 -->
							<div class="table-responsive">
								<table class="table table-bordered table-striped">
									<colgroup>
										<col class="col-xs-2">
										<col class="col-xs-7">
									</colgroup>
									<tbody>
										<!-- 循环遍历 -->
										<c:forEach items="${list }" var="list">
											<tr>
												<th scope="row"><code>
														<span style="color: blue;">性质：</span>
														<c:if test="${list.property==1 }">
															<span style="color: green;">提问</span>
														</c:if>
														<c:if test="${list.property==2 }">
															<span style="color: green;">分享</span>
														</c:if>
													</code></th>
												<td>${list.name }<a
													href="${prc }/comment/commentStart?id=${list.id }">
														&nbsp;&nbsp;&nbsp; ${list.title } </a> <span
													style="float: right;">${list.publishTime }</span>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- 分页 -->
							<ul class="pager">
								<li><a href="${prc }/argument/tribuneStart"> 首页 </a></li>
								<li><c:if test="${currentPage==1 }">上一页 </c:if> <c:if
										test="${currentPage>1 }">
										<a href="${prc }/argument/tribuneStart?page=${currentPage-1 }">上一页
										</a>
									</c:if></li>
								<li><c:if test="${currentPage==totalPage }">下一页 </c:if> <c:if
										test="${currentPage!=totalPage }">
										<a href="${prc }/argument/tribuneStart?page=${currentPage+1 }">下一页
										</a>
									</c:if></li>
								<li><a
									href="${prc }/argument/tribuneStart?page=${totalPage }">末页
								</a></li>
								<li><a href="#">第${currentPage }页</a></li>
								<li><a href="#">总共${count }记录</a></li>
								<li><a href="#">总共${totalPage }页</a></li>
							</ul>
						</c:if>
					</div>
				</div>
				<!-- 右侧：名胜 -->
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">名胜古迹</h3>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-3">
								<div class="thumbnail" style="text-align: center;">
									<img
										src="${pageContext.request.contextPath}/image/mingsheng/1.jpg"
										class="img-thumbnail" width="100/9">
									<div class="caption">
										<p>
											<a
												href="https://baike.baidu.com/item/三山五岳/1251099?fr=aladdin">黄山</a>
										</p>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="thumbnail" style="text-align: center;">
									<img
										src="${pageContext.request.contextPath}/image/mingsheng/2.jpg"
										class="img-thumbnail" width="100/9">
									<div class="caption">
										<p>
											<a
												href="https://baike.baidu.com/item/三山五岳/1251099?fr=aladdin">泰山</a>
										</p>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="thumbnail" style="text-align: center;">
									<img
										src="${pageContext.request.contextPath}/image/mingsheng/3.jpg"
										class="img-thumbnail" width="100/9">
									<div class="caption">
										<p>
											<a
												href="https://baike.baidu.com/item/三山五岳/1251099?fr=aladdin">华山</a>
										</p>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="thumbnail" style="text-align: center;">
									<img
										src="${pageContext.request.contextPath}/image/mingsheng/4.jpg"
										class="img-thumbnail" width="100/9">
									<div class="caption">
										<p>
											<a
												href="https://baike.baidu.com/item/三山五岳/1251099?fr=aladdin">嵩山</a>
										</p>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="/foot.jsp"></jsp:include>
</body>
</html>