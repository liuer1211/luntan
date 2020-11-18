
function addChartRoom(title,url){
	top.$('#optWin').dialog({       
		title: title,  
		width: 700,
		height: 400,    
		closed: false,    
		cache: false,    
		href: url,    
		modal: false   
		}); 
}
function addChartRoom2(title,url){
	top.$('#optWin2').dialog({    
		title: title, 
		width: 700,    
		height: 400,    
		closed: false,    
		cache: false,    
		href: url,    
		modal: false   
		}); 
}
//远程维护指导，新建讨论组弹窗
function addForm(title,url){
	top.$('#optWin').dialog({    
		title:title,    
		width: 448,    
		height: 288,    
		closed: false,    
		cache: false,    
		href: url,    
		modal: true 
		}); 
}

var dataGridSet = {
		pagination:true,
		rownumbers:true,
	    pageNumber:10,
		toolbar:"#tb"
	};