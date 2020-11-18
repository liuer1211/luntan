<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--html5shiv：解决ie9以下浏览器对html5新增标签的不识别，并导致CSS不起作用的问题。
    respond.min:让不支持css3 Media Query的浏览器包括IE6-IE8等其他浏览器支持查询。-->
<script type="text/javascript" src="${prc}/html/js/html5shiv.js"></script>
<script type="text/javascript" src="${prc}/html/js/respond.min.js"></script>

<link rel="stylesheet" type="text/css" href="${prc}/html/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${prc}/html/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${prc}/html/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${prc}/html/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${prc}/html/h-ui.admin/css/style.css" />
 <!-- 解决IE6 一下不能解决的插件图 -->
<script type="text/javascript" src="${prc}/html/js1/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>

<title>言论管理</title>
	<style type="text/css">
		#datatable td{text-align:center}
	</style>
</head>
<body>
<div class="page-container">
	<div class="text-c">
		日期范围：
		<input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'endtime\')||\'yyyy-MM-dd HH:mm:ss\'}' })" id="starttime" class="input-text Wdate" style="width:120px;">
		-
		<input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'starttime\')}' })" id="endtime" class="input-text Wdate" style="width:120px;">
		<input type="text" class="input-text" style="width:150px" placeholder="输入相册主题" id="title" name="title">
		<button type="submit" onclick="getlist()" class="btn btn-success radius" id="" name="">
			<i class="Hui-iconfont">&#xe665;</i> 查询
		</button>
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20">
		<span class="l">
			<a href="javascript:;" onclick="datadel()" class="btn btn-danger radius">
				<i class="Hui-iconfont">&#xe6e2;</i> 批量删除
			</a>
			<%-- <a href="${prc}/manager/addView"  class="btn btn-primary radius">
				<i class="Hui-iconfont">&#xe600;</i> 添加
			</a> --%>
		</span>
		<span class="r">共有数据：<strong id="total"></strong> 条</span> </div>
	<!-- 检索 栏-->	
	<div id="datadiv" class="mt-20">
	
	<table id="datatable" class="table table-border table-bordered table-hover table-bg table-sort">
		<thead>
			<tr class="text-c">
				<th width="25"><input type="checkbox" name="" value=""></th>
				<th width="100">相册主题</th>
				<th width="100">图片</th>
				<th width="100">时间</th>
				<th width="50">操作</th>
			</tr>
		</thead>
	</table>
	</div>
</div>
<iframe id="mainFrame1" name="mainFrame1" scrolling="auto" 
frameborder="0" src=""  style="width:100%;height:95%;display:none">
</iframe>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${prc}/html/jquery/1.9.1/jquery.min.js"></script>
<!-- 单独使用layer弹出-->
<script type="text/javascript" src="${prc}/html/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${prc}/html/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${prc}/html/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<!-- 日期 -->
<script type="text/javascript" src="${prc}/html/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${prc}/html/datatables/1.10.0/jquery.dataTables.min.js"></script>
<!-- layui 多功能js分页 -->
<script type="text/javascript" src="${prc}/html/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
    var table;
    $(function(){
    	 
    	
        //初始化表格
        table = $("#datatable").dataTable({
            autoWidth: false,  //禁用自动调整列宽
            stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
            processing: true,  //隐藏加载提示,自行处理
            serverSide: true,  //启用服务器端分页
            searching: true,  //禁用原生搜索
            orderMulti: true,  //启用多列排序
            ordering:false,//关闭表格的排序功能
            order: [],  //取消默认排序查询,否则复选框一列会出现小箭头
            renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
            pagingType: "simple_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
            columnDefs: [{
                "targets": 'nosort',  //列的样式名
                "orderable": false    //包含上样式名‘nosort’的禁止排序
            }],
            ajax: function (data, callback, settings) {
            	 //封装请求参数,查询
            	var starttime=$("#starttime").val();
                var endtime=$("#endtime").val();
                var title=$("#title").val();
                var  param = {
                	startdate : starttime,
                    enddate : endtime,
                    title:title
                }
                //组装分页参数
                param.pageSize = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
                //param.currpage = data.start;//开始的记录序号
                param.currpage = (data.start / data.length)+1;//当前页码
                //param.orderby=data.orderBys;
                //console.log(param);
                //ajax请求数据
                $.ajax({
                    type: "post",
                    url: "${prc}/manager/getPhotoList",
                    cache: false,  //禁用缓存
                    data: param,  //传入组装的参数
                    dataType: "json",
                    success: function (result) {
                    	//console.log(result);
                    	$("#total").text(result.page.total);//显示总条数
                    	var returnData = {};
                    	returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
                    	returnData.recordsTotal = result.page.total;//返回数据全部记录,不写会有（从1到10显示24，已从NAN条数据中过滤）
                    	returnData.recordsFiltered = result.page.total;//后台不实现过滤功能，每次查询均视作全部结果
                   		returnData.data = result.page.list;//返回的数据列表
                   	 	callback(returnData);//数据回滚
                    }
                });
            },
            //列表表头字段
            columns: [
                { "data": "id",
                    render : function(data, type, row) {
                        return '<input type="checkbox" value="'+data+'" name="id">';
                    }
                },
                { "data": "title"},
                { "data": "picture" ,
                	//这里的data就是picture数据库的值
                    render : function(data, type, row) {
                        var s="";
                        if (data!=null && data!="")
                        {
                        	var datas="${prc}/tmp/"+data;
                            s='<img style="height: 20px" src="'+datas+'"/>';
                        }
                        else
                        {
                            s='<img style="height: 20px" src="'+'${prc}/image/init/head.jpg'+'"/>';
                        }
                        return s;
                    }
                },
                { "data": "createDate"},
                { "data": "id",
                    render : function(data, type, row) {
                        return '<a title="删除" href="javascript:;" onclick="photo_del('+"'"+data+"'"+')" class="ml-5" style="text-decoration:none">'+
                        '<i class="Hui-iconfont"> &#xe6e2; </i>'+
                        '</a>';
                    }
                }
            ]
        }).api();
    });
   	//查询
   function getlist() {
   		//动态加载table数据
       table.ajax.reload();
   }
   //批量删除
   //定义和用法 onclick 事件会在对象被点击时发生
   function datadel(){
	 	//定义一个数组
		var rows=[];
	    //将选中的添加到数组中
	    //注意：不能有空格
	    $('input[name="id"]:checked').each(function(){
	    	//取值 被选中 id
	    	//定义和用法 push（) 方法可向数组的末尾添加一个或多个元素，并返回新的长度
	    	rows.push($(this).val());//这里取到的是  id  的值
	    	//alert($(this).val());   //得到id值
	    });
	    //判断是否选择复选框
	    if(rows.length==0){
	    	//没有选  不做任何提示
	    	showOnlyMessage('error',MESSAGE.CONTENT.SELECTONE);
	    }else{
	    	//获取选中行
	    	var ids="";
	    	for(var i=0;i<rows.length;i++){
	    		//数组下标    ：  id值     一一对应
	    		//这里把每一个的值得到，并用逗号隔开，在后台处理时要按照逗号一次取出
	    		ids=ids+rows[i]+","
	    	}
	    	var data={};
	    	data.id=ids;
	    	//上面参数带进去，也可以直接在URL后面写 : +ids
	    	//layer.confirm(content, options, yes, cancel) - 询问框
	    	layer.confirm('确认要删除吗？',function(index){
	    		$.ajax({
	    			type:'post',
	    			url:'${prc}/manager/photoDelete',
	    			dataType:'json',
	    			data:data,
	    			success:function(data){
	    				//动态加载table数据
	    				table.ajax.reload();
	    				//1，图标；1000代表1秒，不设置默认3秒
	    				layer.msg('已删除！',{icon:1,time:1000});
	    			},
	    			error:function(data){
	    				console.log(data.msg);
	    			},
	    		});
	    	});
	    }  
   }
   
   /* //添加
   //注意：函数加参数
   function member_add(title,url,w,h){
	   //弹出框显示
	  // layer_show(title,url,w,h);
   } */
   
   /* //编辑
   //id是参数
   function manager_edit(id){
	   layer_show("编辑","${prc}/manager/editView?id="+id,'','510');
   } */
   
   //单个删除
   function photo_del(id){
	   //data用来存储id，使用ajax是一定要带进去
	   var data={};
	   data.id=id;
	   layer.confirm('确认要删除吗?',function(index){
		  $.ajax({
			 type:'post',
			 url:'${prc}/manager/photoDelete',
			 dataType:'json',
			 data:data,
			 success:function(data){
				 table.ajax.reload();
				 layer.msg('已删除!',{icon:1,time:1000});
			 },
			 error:function(data){
				console.log(data.msg) 
			 },
		  }); 
	   });
   }
   
</script> 
</body>
</html>