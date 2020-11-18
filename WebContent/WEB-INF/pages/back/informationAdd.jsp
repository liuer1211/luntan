<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/include/common.libs.jsp"%>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />

<script type="text/javascript" src="${prc}/html/js/html5shiv.js"></script>
<script type="text/javascript" src="${prc}/html/js/respond.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="${prc}/html/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="${prc}/html/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"
	href="${prc}/html/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css"
	href="${prc}/html/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css"
	href="${prc}/html/h-ui.admin/css/style.css" />

<title>添加管理员</title>
<style>
    .error {
      color: #F00;
    }
    /* 或弹出错误提示，jquery错误提示中 class="error" */
</style>
<style>
.hide {
	display: none;
}
</style>
</head>
<body>
	<article class="page-container">
		<form id="J_basic" action="${prc}/manager/informationAdd"
			method="post" enctype="multipart/form-data"
			class="form form-horizontal">
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>标题：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="" placeholder="输入标题"
						id="title" name="title">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>链接地址：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="" placeholder="输入链接地址"
						id="link" name="link">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>内容：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<textarea name="content" cols="" rows="" class="textarea"
						placeholder="说点什么..." datatype="*10-100" dragonfly="true"
						nullmsg="备注不能为空！"></textarea>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>图片：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="file" name="picture" id="file" multiple="multiple" />
					<br> <br> <img src="" id="img" width="120" class="hide">
				</div>
			</div>

			<div class="row cl">
				<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
					<input class="btn btn-primary radius" type="submit" id="J_submit"
						value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
				</div>
			</div>
		</form>
	</article>
	<!-- from表单的验证，jquery技术 -->
	<!-- jquery表单验证，jar包不能放到最上面 -->
	<script type="text/javascript" src="${prc}/html/js5/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="${prc}/html/js5/jquery.validate.js"></script>
	<script type="text/javascript">
		$(function() {
			$('#J_basic').validate({
				rules : {
					title : {
						required : true
					},
					content : {
						required : true
					},
					link:{
						required : true,
					},
					picture : {
						required : true
					}
				},
				messages : {
					title : {
						required : '标题不能为空'
					},
					content : {
						required : '内容不能为空'
					},
					link:{
						required : '链接地址不能为空'
					},
					picture : {
						required : '图片不能为空'
					}
				}
			});
		})
	</script>
	<script type="text/javascript">
		//图片预览效果绑定事件
		$("#file").change(function() {
			var objUrl = getObjectURL(this.files[0]);
			console.log("objUrl = " + objUrl);
			if (objUrl) {
				$("#img").attr("src", objUrl);
				$("#img").removeClass("hide");
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
	</script>
	<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>