/* lanrenzhijia.com */

$(document).ready(function() {
	
	var videoclip='';
	var player='';
	
	$(".video_link").hover(function(){
		videoclip=$(this).attr('href');
		$(this).attr({"href":"#video_box"});
	},
	
	function(){
		$(this).attr({"href":""+videoclip+""});
	});
	
	$(".video_link").fancybox({
		'hideOnContentClick':false,
		'overlayOpacity' :.6,
		'callbackOnShow' :function(){
				player = $f("fancy_div",swfplayer,{
				play:{opacity:0},
				clip:{
					autoPlay:true,
					autoBuffering:true,
					url:videopath+videoclip+'',
					onStart:function(clip){
						var wrap=jQuery(this.getParent());
						/*var clipwidth = clip.metaData.width;
						var clipheight= clip.metaData.height;此处改动过hcn*/
						var clipwidth = '600px';
						var clipheight= '360px';
						var pos = $.fn.fancybox.getViewport();
						$("#fancy_outer").css({width:clipwidth,height:clipheight});
						$("#fancy_outer").css('left', ((clipwidth + 36) > pos[0] ? pos[2] : pos[2] + Math.round((pos[0] - clipwidth	- 36)	/ 2)));
						$("#fancy_outer").css('top',  ((clipheight + 50) > pos[1] ? pos[3] : pos[3] + Math.round((pos[1] - clipheight - 50)	/ 2)));
					},
					onFinish:function(){
						$('#fancy_close').trigger('click');
					}
				}
			});
			player.load();
			$('#fancy_close').click(function(){
				$("#fancy_div_api").remove();
			});
		},
		'callbackOnClose':function(){
			$("#fancy_div_api").remove();
		}
	});
	
}); 

/* lanrenzhijia.com */