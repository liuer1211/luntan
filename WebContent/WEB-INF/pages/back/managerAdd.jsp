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
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	
	<script type="text/javascript" src="${prc}/html/js/html5shiv.js"></script>
	<script type="text/javascript" src="${prc}/html/js/respond.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="${prc}/html/h-ui/css/H-ui.min.css" />
	<link rel="stylesheet" type="text/css" href="${prc}/html/h-ui.admin/css/H-ui.admin.css" />
	<link rel="stylesheet" type="text/css" href="${prc}/html/Hui-iconfont/1.0.8/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="${prc}/html/h-ui.admin/skin/default/skin.css" id="skin" />
	<link rel="stylesheet" type="text/css" href="${prc}/html/h-ui.admin/css/style.css" />

	<title>添加管理员</title>
	<style>
    .hide
    {
      display:none;
    }
  </style>
</head>
<body>
<article class="page-container">
	<form id="J_basic" action="${prc}/manager/add" method="post" enctype="multipart/form-data" class="form form-horizontal" >
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>管理员名字：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="" placeholder="" id="name" name="name">
			</div>
		</div>
		 <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>管理员头像：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="file" name="picture" id="file" multiple="multiple" />
  				<br>
  				<br>
  				<img src="" id="img" width="120" class="hide">
			</div>
		</div>
		
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" id="J_submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</article>

<!--_footer 作为公共模版分离出去-->
<!--<script type="text/javascript" src="${ctx}/static/lib/yhby/lib/jquery/1.9.1/jquery.min.js"></script>-->
<script type="text/javascript" src="${prc}/html/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${prc}/html/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${prc}/html/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${prc}/html/js4/jquery-1.11.1.js"></script>

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${prc}/html/My97DatePicker/4.8/WdatePicker.js"></script>
<!-- 新的jquery库插件 -->
<script type="text/javascript" src="${prc}/html/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="${prc}/html/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="${prc}/html/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript">
    
    //图片预览效果绑定事件
    $("#file").change(function(){
        var objUrl = getObjectURL(this.files[0]) ;
        console.log("objUrl = "+objUrl) ;
        if (objUrl) 
        {
          $("#img").attr("src", objUrl);
          $("#img").removeClass("hide");
        }
      }) ;
      //建立一個可存取到該file的url
      function getObjectURL(file) 
      {
        var url = null ;
        if (window.createObjectURL!=undefined) 
        { // basic
          url = window.createObjectURL(file) ;
        }
        else if (window.URL!=undefined) 
        {
          // mozilla(firefox)
          url = window.URL.createObjectURL(file) ;
        } 
        else if (window.webkitURL!=undefined) {
          // webkit or chrome
          url = window.webkitURL.createObjectURL(file) ;
        }
        return url ;
      }
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>