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
<script type="text/javascript">
	function mobileViladate() {
		var mobile = $("#mobile").val();
		var mob = /^(((13[0-9]{1})|(15[0-35-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		if (mobile == "") {
			$("#mobileLab").html("电话号不能为空");
			$("#mobileDiv").show();
			return false;
		} else if (!mob.test(mobile)) {
			$("#mobileLab").html("请输入正确的电话号");
			$("#mobileDiv").show();
			return false;
		} else {
			$("#mobileLab").html("");
			$("#mobileDiv").hide();
			return true;
		}
	}
</script>
<!-- 日期 -->
<link rel="stylesheet"
	href="${prc}/html/layui-v2.2.5/layui/css/layui.css" media="all">
</head>
<body style="background: #ededed;">

	<jsp:include page="/head.jsp" />
	<jsp:include page="/menu.jsp" />

	<div style="height: 5px;"></div>
	<div class="container">
		<div class="row" style="background:;">
			<div class="col-xs-12" style="background: #c1e0ef;">
				<div style="height: 10px;"></div>
				<%-- ${listOne.id }
			${listOne.name }
			${listOne.email }
			${listOne.address }
			${listOne.mobile } --%>
				<div class="panel panel-primary">
					<div class="panel-body">
						<div class="row">
							<!-- 中间的表数据 -->
							<div class="col-md-12">
								<div class="thumbnail">
									<!-- form表单 -->
									<form class="form-horizontal" method="post"
										action="${prc}/user/userEdit" enctype="multipart/form-data"
										id="myForm">
										<!-- 每个栅栏 -->
										<div class="form-group">
											<label for="" class="col-sm-4 control-label"></label>
											<div class="col-sm-5">
												<img src="${prc}/tmp/${listOne.picture }" class="img-rounds"
													width="100/9" id="img1"> <img src="" id="img"
													height="100" class="hide" width="100"> <br>
												<br> <input type="file" name="picture" id="file"
													multiple="multiple">
											</div>
										</div>

										<div class="form-group">
											<label for="" class="col-sm-6 control-label"> <span
												style="color: #c0c0c0;"> 图片像素400X400为最佳哦</span>
											</label>
											<div class="col-sm-5"></div>
										</div>

										<div class="form-group">
											<input type="hidden" name="id" value="${listOne.id }">
											<label for="" class="col-sm-4 control-label">姓名</label>
											<div class="col-sm-5">
												<p class="form-control-static">${listOne.name }</p>
											</div>
										</div>
										
										<div class="form-group">
											<label for="" class="col-sm-4 control-label">性别</label>
											<div class="col-sm-5">
												<label class="radio-inline"> <input type="radio"
													name="gender" value="1"
													<c:if test='${listOne.gender==1 }'>checked="checked"</c:if>>
													男
												</label> <label class="radio-inline"> <input type="radio"
													name="gender" value="2"
													<c:if test='${listOne.gender==2 }'>checked="checked"</c:if>>
													女
												</label>
											</div>
										</div>
										<dir style="height: 3px;"></dir>
										
										<div class="form-group">
											<label for="" class="col-sm-4 control-label">
												邮箱
											</label>
											<div class="col-sm-5">
												<input type="text" class="form-control" name="email" id=""
													placeholder="邮箱" value="${listOne.email }">
											</div>
										</div>
										
										<div class="form-group">
											<label for="" class="col-sm-4 control-label">
												电话
											</label>
											<div class="col-sm-5">
												<input type="text" class="form-control" name="mobile" id="mobile"
													placeholder="电话" value="${listOne.mobile }"
													onblur="mobileViladate();">
											</div>
										</div>

										<div class="form-group">
											<label for="" class="col-sm-4 control-label">地址</label>
											<div class="col-sm-5">
												<input type="text" class="form-control" name="address" id=""
													placeholder="地址" value="${listOne.address }">
											</div>
										</div>
										<dir style="height: 3px;"></dir>
										
										<div class="form-group">
											<label for="" class="col-sm-4 control-label">日期</label>
											<div class="col-sm-5">
												<input type="text" value="${listOne.birthday }"
													name="birthday" class="layui-input" id="test1"
													placeholder="yyyy-MM-dd">
											</div>
										</div>
										<dir style="height: 3px;"></dir>
										
										<div class="form-group">
											<label for="" class="col-sm-4 control-label">标签</label>
											<div class="col-sm-5">
												<textarea class="form-control" rows="3"
													placeholder="说点什么吧。。。" name="describes">${listOne.describes }</textarea>
											</div>
										</div>
										<dir style="height: 3px;"></dir>
										
										<div class="form-group">
											<div class="col-sm-offset-4 col-sm-5">
												<button type="submit" class="btn btn-primary btn-block">提交</button>
											</div>
										</div>

									</form>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<div style="height: 5px;"></div>
	<jsp:include page="/foot.jsp"></jsp:include>

	<!-- 日期 -->
	<script src="${prc}/html/layui-v2.2.5/layui/layui.js" charset="utf-8"></script>
	<!-- from表单的验证，jquery技术 -->
	<!-- jquery表单验证，jar包不能放到最上面 -->
	<script type="text/javascript" src="${prc}/html/js5/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="${prc}/html/js5/jquery.validate.js"></script>
	
	<script>
		//图片预览效果绑定事件
		$("#file").change(function() {
			var objUrl = getObjectURL(this.files[0]);
			console.log("objUrl = " + objUrl);
			if (objUrl) {
				$("#img").attr("src", objUrl);
				$("#img").removeClass("hide");
				$("#img1").css('display', 'none');
			}
		});
		//建立一個可存取到該file的url
		function getObjectURL(file) {
			var url = null;
			if (window.createObjectURL != undefined) { // basic
				url = window.createObjectURL(file);
			} else if (window.URL != undefined) {
				// mozilla(firefox)
				url = window.URL.createObjectURL(file);
			} else if (window.webkitURL != undefined) {
				// webkit or chrome
				url = window.webkitURL.createObjectURL(file);
			}
			return url;
		}

		//layui日期格式
		//常规用法
		layui.use('laydate', function() {
			var laydate = layui.laydate;
			laydate.render({
				elem : '#test1'
			});
		});
	</script>

</body>
</html>