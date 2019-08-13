var MessageView = (function(){
	
	var cache = {};
	
	var defaultSetting = function(){
		
		// 회원일때만 초기 좋아요 여부 체크
		if( cache.uid ){
			MessageView.likeCheck(cache.mid, cache.uid);
		}
	}
	
	var bindEvent = function(){
		// 댓글 이미지 클릭 시
		$("#reply_img").on('click', function(){
			$(".write").toggle();
		})
		
		$("img[name='like']").on('click', MessageView.likeClick);
	}
	
	
	
	return {
		// 초기화
		init : function(mid, uid){
			cache.mid = mid;
			cache.uid = uid;
			defaultSetting();
			bindEvent();
		},

		// 해당 회원이 해당 게시글을 좋아요를 눌렀는지 체크
		likeCheck : function(mid, uid){
			var url = "/mysns/like?mid="+mid+"&uid="+uid;
			
			 $.ajax({
				 url: url,
                 type:"GET",
                 success: function (data) {
                	 if(data.check == true){
                		 cache.like_already_check = true;
                		 $("#like2").show();
                	 }else{
                		 cache.like_already_check = false;
                		 $("#like1").show();
                	 }
                 },
                 error: function (request, status, error) {
                     console.log(status, error);
                 }
             });
		},
		
		// 좋아요 클릭
		likeClick : function(){
			if( ! cache.uid || cache.uid == "null"){
				alert('로그인 하세요!');
				return;
			}
			
			var url;
			
			// 이미 눌려있는 상태에서 또 누름 -> 좋아요 해제 
			if(cache.like_already_check == true){
				url = "/mysns/sns_control.jsp?action=removeFav&mid="+cache.mid;
			}else{
				url = "/mysns/sns_control.jsp?action=addFav&mid="+cache.mid;
			}
			
			 $.ajax({
                 type: "GET",
                 url: url,
                 success : function(){
                	 cache.like_already_check = !cache.like_already_check;
                	 window.location.reload();
                	 
                 },
                 error : function(){
                	 alert("실패!");
                 }
                 
             });
			
			
		}
		
		
		
	}
})();