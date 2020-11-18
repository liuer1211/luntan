$(function(){
	var obj=[{'id':1,'name':'轴承'},{'id':2,'name':'裂纹'},{'id':3,'name':'动力学'},{'id':4,'name':'工务图'}];
	$("#Types_combox").combobox({
			data:obj,
			valueField:'id',
			textField:'name',
			editable:false,
			onLoadSuccess:function(){
				 $("#Types_combox").combobox('select',obj[0].id);
				 },
			onSelect:function(record){
				
			}
	});
	$('#realTime').css('cursor','default');
	$("#history").click(function(){
		$("#history").attr("class","btn btn_small btn_white");
		$("#realTime").attr("class","btn btn_small btn_green");
		$("#history").attr("disabled",true);
		$("#realTime").attr("disabled",false);
		$('#history').css('cursor','default');
		$('#realTime').css('cursor','pointer');
	});
	$("#realTime").click(function(){
		$("#realTime").attr("class","btn btn_small btn_white");
		$("#history").attr("class","btn btn_small btn_green");
		$("#realTime").attr("disabled",true);
		$("#history").attr("disabled",false);
		$('#realTime').css('cursor','default');
		$('#history').css('cursor','pointer');
	});
	
});

function getBogieData(ids){
	$.ajax({
		url:"../subWayInfo/getBogieSubSystem?subWayId="+ids,
		type:'post',
		success:function(data){
			$("#table1").append('<tr><td>车号</td></tr><tr><td></td></tr><tr><td>1号(暂定)</td></tr>');
			$.each(data.rows,function(i,e){
				$("#table1").find("tr").eq(0).append('<td colspan="2" >'+e.groupName+'</td>');
				$.each(e.showArr,function(m,n){
					$("#table1").find("tr").eq(1).append('<td class="'+n.dataType+'">'+n.codeName+'</td>');
					$("#table1").find("tr").eq(2).append('<td></td>');
				});
				
			});
			$("#table1").append('<tr><td></td></tr>');
			B_setInterval=setInterval('updateBogie('+ids+')',1000);
		}
	});
}
function updateBogie(ids){
	$.ajax({
		url:"../subWayInfo/getBogieSubSystemData?subWayId="+ids,
		type:'post',
		success:function(data){
			for(var i=0;i<(data.rows.length)*2;i++){
				$("#table1").find("tr").eq(2).find("td").eq(i+1).html('');
			}
			//提取
			var dataArr=[];
			$.each(data.rows,function(i,e){
				$.each(e.showValueArr,function(m,n){
					dataArr.push(n);
				});
			});
			for(var i=0;i<dataArr.length;i++){
				$("#table1").find("tr").eq(2).find("td").eq(i+1).html(dataArr[i].value);
			}
			
		}
	});
}