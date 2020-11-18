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
<title>register</title>
<!-- Bootstrap -->
<link href="${prc}/html/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="${prc}/html/js5/jquery-1.12.4.min.js"></script>
<script src="${prc}/html/bootstrap/js/bootstrap.min.js"></script>
<!-- 弹出框 -->
<script type="text/javascript" src="${prc}/html/layer/2.4/layer.js"></script>
<style>
    .error {
      color: #F00;
    }
    /* 或弹出错误提示，jquery错误提示中 class="error" */
</style>
<script type="text/javascript">
	
	//验证电话号
	//mobileViladate  失去焦点方法
	//#mobile input中id里的
	//#mobileLab  控制显示时lable的内容
	//mobileDiv   控制显示时div的
    function mobileViladate () {
        var mobile = $("#mobile").val();
        var mob = /^(((13[0-9]{1})|(15[0-35-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
        if(mobile == ""){
        	$("#mobileLab").html("电话号不能为空");
            $("#mobileDiv").show();
            return false;
        }else if(!mob.test(mobile)){
            $("#mobileLab").html("请输入正确的电话号");
            $("#mobileDiv").show();
            return false;
        } else{ 
        	$("#mobileLab").html("");
            $("#mobileDiv").hide();
            return true;
        }
    }
	//验证码
	//onclick="change()"--时间跳转--点击事件
	function change(){
		var img1=document.getElementById("checkImg");
		img1.src="${prc}/getCode?time="+new Date().getTime();
	} 
	//服务条款 onblur 事件会在对象失去焦点时发生
	//这个jquery也可以写
	function agreeValidate() {
		var agree = document.getElementById("agree");
		if (!agree.checked) {
			$("#agreeLab").html("请先同意服务条款");
            $("#agreeDiv").show();
			return false;
		}else{ 
	        $("#agreeLab").html("");
	        $("#agreeDiv").hide();
	        return true;
	    }
	} 
	//查看条款,弹出框显示的
	function lookAgree(){
		layer.alert(
			'我们郑重提示您在开始加入本论坛前充分阅读相关法律文献：本条款的签订、效力、履行、终止及其解释适用中华人民共和国法律（为本条款的目的，不包括香港特别行政区、澳门特别行政区及台湾地区的法律）。如有恶意传播不良信息我们有权利将您和谐。', 
			function(index){
			  layer.close(index);
		});     
	}
</script>

</head>
<body style="background: #ededed;">
	<!-- 包含其他页面 -->
	<!-- 加载到页面 -->
	<%-- <%@include file="../../../head.jsp"%>
	<%@include file="../../../menu.jsp"%> --%>
	<%-- <jsp:include  page="${prc}/head.jsp"/> 
	<jsp:include  page="${prc}/menu.jsp"/>  --%>
	<!--index中  page里的路径  里面直接加“/” 前面直接是项目名 -->
	<jsp:include  page="/head.jsp"/> 
	<jsp:include  page="/menu.jsp"/> 
	
	<!-- 空一行间隙 -->
	<div style="height: 5px;"></div>
	<!-- 主题内容 -->
	<div class="container">
		<div class="row">
			<!-- 左侧内容 -->
			<div class="col-xs-7" style="background: #c1e0ef;">
				<!-- <h2 class="page-header">区域一</h2> -->
				<img src="${prc}/images/register/r1.png" class="img-rounded" width="100%/9"
					style="padding: 15px 0px 15px 0px;">
				<!-- width="100%/9" -->
			</div>
			<!-- 右侧注册内容 -->
			<div class="col-xs-5" style="background: #c1e0ef;">
				<h3 class="page-header" style="color: #0097df;">轻松注册，快人一步</h3>
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">注册</h3>
					</div>
					<!-- form表单 -->
					<div class="panel-body">
						<form class="form-horizontal" action="${prc}/user/register" method="post" id="myForm">
							<!-- 用户名 -->
							<div class="form-group">
								<label for="" class="col-sm-4 control-label">
									<span style="color: red;">*</span>用&nbsp;&nbsp;户&nbsp;名
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="name" placeholder="输入用户名" name="name" >
								</div>
							</div>
							<div id="" class="form-group">
								<!-- 为唯一性验证做修改，加到后台 -->
								<input type="hidden" name="nameCheck" id="nameCheck">
                                <label id="nameLable" class="col-sm-8 control-label" ></label>
                            </div>
							<!-- 密码 -->
							<div class="form-group">
								<label for="" class="col-sm-4 control-label">
									<span style="color: red;">*</span>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码
								</label>
								<div class="col-sm-8">
									<input type="password" class="form-control" id="password" placeholder="输入密码" name="password" >
								</div>
							</div>
							<div id="" class="form-group">
                                <label id="" class="col-sm-8 control-label" ></label>
                            </div>
							<!-- 邮箱 -->
							<div class="form-group">
								<label for="" class="col-sm-4 control-label">
									<span style="color: red;">*</span>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="email" placeholder="输入邮箱" name="email" >
								</div>
							</div>
							<div id="" class="form-group">
                                <label id="" class="col-sm-8 control-label" ></label>
                            </div>
							<!-- 电话-->
							<div class="form-group">
								<label for="" class="col-sm-4 control-label">
									<span style="color: red;">*</span>电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="mobile" placeholder="输入电话号" name="mobile" onblur="mobileViladate();">
									<label id="mobileLab"  style="color: red;"></label>
								</div>
							</div>
							<div id="mobileDiv" class="form-group">
                                <label id="mobileLab" class="col-sm-8 control-label" style="color: red;"></label>
                            </div>
							<!-- 验证码 -->
							<div class="form-group">
								<label for="" class="col-sm-8 control-label"  > 
									<span style="color: red;">*</span>验&nbsp;&nbsp;证&nbsp;&nbsp;码
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<img id="checkImg"  onclick="change();" src="${prc}/getCode" class="img-rounded" >
								 </label>
								<div class="col-sm-4">
									<div class="input-group">
										<input type="text" class="form-control" placeholder="输入验证码" name="code" id="code">
    								</div>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-8 control-label" style="color: red;">${codeError }</label>
							</div>
							<!-- 同意协议-->
							<div class="form-group">
								<label for="" class="col-sm-4 control-label"> </label>
								<div class="col-sm-8">
									<label class="checkbox">
      									<input type="checkbox" checked="checked" 
											id="agree" value="true" onblur="agreeValidate();"> 
											<a href="javascript:;" onclick="lookAgree()">同意本站服务条款</a>
    								</label>
    							</div>
							</div>
							<div id="agreeDiv" class="form-group">
                                <label id="agreeLab" class="col-sm-8 control-label" style="color: red;"></label>
                            </div>
							<!-- 提交 -->
							<div class="form-group">
								<div class="col-sm-12 col-sm-offset-3">
									<input type="submit" class="btn btn-primary" value="注册"/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="${prc}/front/loginStart" >立即登录</a>
								</div>
							</div>

						</form>
					</div>
				</div>
				<!-- <h2 class="page-header">区域-1</h2> -->
			</div>
		</div>
	</div>
	<!-- 空一行间隙 -->
	<!-- <div style="height: 10px;"></div> -->
	<!-- 包含 底部页面 -->
	<%-- <jsp:include page="${prc}/foot.jsp"></jsp:include> --%>
	<%@include file="/foot.jsp" %>
	
	<!-- from表单的验证，jquery技术 -->
	<!-- jquery表单验证，jar包不能放到最上面 -->
	<script type="text/javascript" src="${prc}/html/js5/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="${prc}/html/js5/jquery.validate.js"></script>
	<script type="text/javascript">
	//校验用户唯一性
	/* 	HTML：获得文本的值（内容），如果包含标签，则也显示标签内容
		Text：获得文本的值（内容），如果包含标签，不显示标签，只显示值（内容） */
	$("#name").change(function(){
		var name=this.value;
		//alert(name);
		$.ajax({
			url:"${prc}/user/checkUser",
			data:"name="+name,
			type:"post",
			success:function(result){
				if(result.success==false){
					//alert("用户名存在");
					$("#nameLable").html("用户名已存在");
					$("#nameLable").css('color','red');
					$("#nameCheck").val('');
				}else if(result.success==true){
					//只有输入对的用户名才判断，提示;
					//否则，这里不用判断，交给jquery约束判断
					//alert(name.length);
					//alert("用户名bu存在");
					$("#nameLable").html("用户名可用");
					$("#nameLable").css('color','green');	
					//为唯一性加影藏名字，进入后台校验
					$("#nameCheck").val('nameCheck');
					
				}else if(result.success=="error"){
					//如果大于17，错误时  没返回任何东西，刚才的显示没有清空，会出问题
					$("#nameLable").html("");
					$("#nameCheck").val('');
					//$("#nameLable").css('display','none');
				}
			},
			error:function(result){
				//内存溢出
				alert("操作有误");
			}
		});
	});

	//表单验证
	$(function(){
		$('#myForm').validate({
			//rules     配置每一种规则
			//messages  配置规则的提示
			//这里的值是和name对对应的
			rules:{
				name: {
			        required: true,
			        minlength: 2,
			        maxlength: 16
			    },
			    password: {
			        required: true,
			        minlength: 6,
			        maxlength: 12
			    },
				email:{
					required:true,
					email:true
				}
			},
			messages:{
			 	name:{
				 	 required: '用户名必填',
					 minlength: '用户名必须大于或等于2位',
					 maxlength: '用户名必须小于或等于16位'
			 	},
			 	password:{
				 	required:'密码必填',
				 	minlength:'密码必须大于或等于6位',
				 	maxlength:'密码必须小于或等于12位'
			 	},
			 	email:{
			 		required:'邮箱必填',
			 		email: "请输入一个正确的邮箱"
			 	}
		 	}
		});
	});
	</script>
	
</body>
</html>