/**
 * sns_main.jsp 에서 쓰는 javascript
 */
var Sns_main = (function(){
	
	var bindEvent = function(){
		// 프로필 버튼  클릭 시 
		$("#profile_btn").on('click', function(){
			window.open('sns_control.jsp?action=profile_list', '_blank', 'location=yes,height=570,width=520,scrollbars=yes,status=yes');
		});
		
		// 이미지  클릭 시
		$(".list .imglist li").on('click', function(){
			console.log($(this).attr('data-idx'));
			var mid = $(this).attr('data-idx');
			window.open("sns_control.jsp?action=message_view&mid="+ mid , '_blank', 'height=824,width=956,location=yes,scrollbars=yes,status=yes');
			
		})
		
		 
	}; 
	
	var init = (function(){
		bindEvent();
	})();
	
})();


