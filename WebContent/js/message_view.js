var MessageView = (function(){
	
	var cache = {};
	
	// default setting
	var defaultSetting = function(){
		
		// 회원일때만 초기 좋아요 여부 체크
		if( cache.uid ){
			MessageView.likeCheck(cache.mid, cache.uid);
		}
	}
	
	
	
	
	return {
		// 초기화
		init : function(mid, uid){
			cache.mid = mid;
			cache.uid = uid;
			defaultSetting();
		},

		// 해당 회원이 해당 게시글을 좋아요를 눌렀는지 체크
		likeCheck : function(mid, uid){
			 $.ajax({
                 type: "GET",
                 url: "/like",
                 data: {
                	 mid : mid,
                	 uid : uid
                 },
                 contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                 success: function (data) {
                	 alert(data.result);	
                 },
                 error: function (request, status, error) {
                     console.log(status, error);
                 }
             });
		},
		
		// 좋아요 클릭
		like : function(mid){
			
			 $.ajax({
                 type: "GET",
                 url: faq_link + "/image-game-list/game-load",
                 data: {
                     page: page
                 },
                 cache: false,
                 success: function (data) {
                     cache.image_game_list_html[ key ] = data;
                     cache.game_list.append(data);
                     cache.current_page = page;
                     // 더보기 버튼 hide
                     if( cache.current_page  == pageMaker["lastPage"] ){
                         $("#more").hide();
                     }
                 },
                 error: function (request, status, error) {
                     console.log(status, error);
                 }
             });
			
			
		}
		
		
		
	}
})();