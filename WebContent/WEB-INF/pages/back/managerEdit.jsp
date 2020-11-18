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

	<title>编辑</title>
</head>
<body>
<article class="page-container">
	<form id="J_basic" action="#" method="post" class="form form-horizontal" >
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>管理员名字：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" style="display: none" value="${info.id}" placeholder="" id="id" name="id">
				<input type="text" class="input-text" placeholder="" value="${info.name}" name="name" id="name">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="password" class="input-text" placeholder="" value="${info.password}" name="password" id="password">
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
    $(function(){
    	//复选框样式
        /* $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        }); */
      	//rules     配置每一种规则
		//messages  配置规则的提示
        $("#J_basic").validate({
        	//默认娇艳规则，英文提示会变声汉语提示，因为加了一个jar包
            rules:{
                name:{
                	//不能为空
                    required:true
                },
                password:{
                	//不能为空
                    required:true
                }
            },
            /* onkeyup：Boolean  Default: true 
          	 在keyup时验证. */
            onkeyup:false,
            /*focusCleanup：Boolean  Default: false   
       		  如果是true那么当未通过验证的元素获得焦点时，移除错误提示。避免和 focusInvalid 一起用 */
            focusCleanup:true,
            //要验证的元素通过验证后的动作,如果跟一个字符串,会当做一个css类,也可跟一个函数
            success:"valid",//css样式
            //通过验证后运行的函数，里面要加上表单提交的函数，否则表单不会提交 
            submitHandler:function(form){
                var data = getFormData();
                submit(data);

            }
        });
    });

    function getFormData(){
        var data = {};
        data ['basic'] = getFormJson("J_basic");
        return data;
    }
    //提交转转后台
    function submit(data){
        $.ajax({
            url: '${prc}/manager/update',
            type: 'post',
            dataType: 'json',
            data:data.basic/* {infor: JSON.stringify(data)} */,
            //发送请求前可修改 XMLHttpRequest 对象的函数，如添加自定义 HTTP 头。XMLHttpRequest 对象是唯一的参数。这是一个 Ajax 事件。如果返回false可以取消本次ajax请求。 
            beforeSend: function(XMLHttpRequest) {
                //发送前显示遮罩层，无法再次点击，只能等请求结束后才能进行页面操作
               // showMask();
            },
            /* error: function(jqXHR, exception){
                if(jqXHR.status === 518)
                {
                    top.dialog.alert({
                        content : '登录已失效！请重新登录！',
                        callback:function(v){
                            if(v){
                                window.open("${ctx}/userLogin/dologout",'_top');
                            }
                        }
                    });
                }else{
                    layer.alert('请求失败', {icon: 2});
                }
            }, */
            success: function(datas){
            	/* 
        		datas参数（无实际意义）
        		datas.success获得后台传递的参数值
        		后台数据：success：true
        	    */
                if(datas.success == true){
                	//提示成功
                    parent.layer.msg('操作成功！');
                    //回滚表单数据
                    parent.table.ajax.reload();
                   var index = parent.layer.getFrameIndex(window.name);
                   //关闭弹窗
                   parent.layer.close(index);

                }else{
                    layer.alert('添加数据失败', {icon: 2});
                }
            },
            // 请求完成后回调函数 (请求成功或失败之后均调用)。参数： XMLHttpRequest 对象和一个描述成功请求类型的字符串。 Ajax 事件。 
            complete: function (jsondata, stat){
                //hideMask();
            }
        });
    }
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>