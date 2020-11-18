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
<link href="${prc}/html/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="${prc}/html/js5/jquery-1.12.4.min.js"></script>
<script src="${prc}/html/bootstrap/js/bootstrap.min.js"></script>
<!-- 轮播图片 滚动框架 -->
<link type="text/css" rel="Stylesheet" href="${prc}/html/jquery_image/css/imageflow.css" />
<script type="text/javascript" src="${prc}/html/jquery_image/js/jquery.js"></script>
<script type="text/javascript" src="${prc}/html/jquery_image/js/imageflow.js"></script>
</head>
<body style="background: #ededed;">

	<%-- <%@include file="head.jsp"%>
	<%@include file="menu.jsp"%>  --%>

	<jsp:include page="/head.jsp" />
	<jsp:include page="/menu.jsp" />

	<div style="height: 5px;"></div>

	<div class="container">
		<div class="row">
			<!-- 滚动框架 -->
			<div id="LoopDiv" style="background: #c1e0ef;">
				<input id="S_Num" type="hidden" value="8" />
				<div id="starsIF" class="imageflow"> 
					<img src="${prc}/html/jquery_image/images/lunbo1.png" longdesc="#" width="280" height="300"  /> 
					<img src="${prc}/html/jquery_image/images/lunbo2.png" longdesc="#" width="280" height="300"  /> 
					<img src="${prc}/html/jquery_image/images/lunbo3.png" longdesc="#" width="280" height="300"  /> 
					<img src="${prc}/html/jquery_image/images/lunbo4.png" longdesc="#" width="280" height="300"  /> 
					<img src="${prc}/html/jquery_image/images/lunbo5.png" longdesc="#" width="280" height="300"  />
					<img src="${prc}/html/jquery_image/images/lunbo6.png" longdesc="#" width="280" height="300"  /> 
					<img src="${prc}/html/jquery_image/images/lunbo7.png" longdesc="#" width="280" height="300"  /> 
					<img src="${prc}/html/jquery_image/images/lunbo8.png" longdesc="#" width="280" height="300"  /> 
				</div>
			</div>
			<!-- 滚动图片下的内容 -->
			<div style="background: fuchsia; text-align: center;">
				<!-- 所有新闻信息 -->
				<div class="col-xs-12" style="background: #c1e0ef;">
					<div style="margin-top: 20px;"></div>
					<div class="panel panel-primary">

						<!-- <div class="panel-heading">
						<h3 class="panel-title">信息展示</h3>
						</div> -->

						<div class="panel-body">
							<div class="row">
								<!-- 动态数据 -->
								<%-- <c:forEach items="${list}" var="list">
								<div class="col-md-4">
									<div class="thumbnail" style="text-align: center;">
										<img src="${prc}/tmp/${list.picture}" class="img-round" >
										<br>	
										<label>
											<a href="#">${list.title}</a>
										</label>
									</div>
								</div>
								</c:forEach> --%>
								<!-- 静态数据 -->
								<div class="col-md-4">
									<div class="thumbnail" style="text-align: center;">
										<img src="${prc}/images/indexNew1.jpg" class="img-round" >
										<br>	
										<label>
											<a href="http://you.ctrip.com/place/309.html?allianceid=4897&sid=1281318&ouid=London">伦敦美景</a>
										</label>
									</div>
								</div>
								<div class="col-md-4">
									<div class="thumbnail" style="text-align: center;">
										<img src="${prc}/images/indexNew2.jpg" class="img-round" >
										<br>	
										<label>
											<a href="https://www.gushiwen.org/shiju/qiutian.aspx">空山新雨后</a>
										</label>
									</div>
								</div>
								<div class="col-md-4">
									<div class="thumbnail" style="text-align: center;">
										<img src="${prc}/images/indexNew7.jpg" class="img-round" >
										<br>	
										<label>
											<a href="https://www.imooc.com/">慕课网</a>
										</label>
									</div>
								</div>
								
							</div>
						</div>
						
					</div>
				</div>
				
			</div>
			<!-- -->
		</div>
	</div>

	<!-- <div style="height: 10px;"></div> -->
	<%@include file="/foot.jsp"%>
	<%-- <jsp:include page="${prc}/foot.jsp"></jsp:include> --%>
</body>
</html>