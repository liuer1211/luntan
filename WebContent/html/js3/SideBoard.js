$(document).ready(function(){
	
	$('#righteject .bar').toggle(
	  function () {
		 $(this).next("div").animate({width: '+450px'}, "100");
		 //$(this).addClass("rightejectthis").next("div").animate({width: '+450px'}, "100");
		 //$('.bar').css('background-position','-50px -5px');
	  },
	  function () {
		//$(this).removeClass("rightejectthis").next("div").animate({width: '-450px'}, "100");
		$(this).next("div").animate({width: '-450px'}, "100");
		//$('.bar').css('background-position','-50px -5px');
	  }
	);
	/*下面这一句只是为了让标题中的文本垂直居中，如果你使用图片做tit或者你知道span的高度，你可以删除它，在.rightejecttit span写上margin-top:span高度的一半*/
	/*$('#righteject strong span').css("margin-top",-$('#righteject strong span').height()*0.5);*/

});