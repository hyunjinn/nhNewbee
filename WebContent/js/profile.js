var Profile = function(hobby, file_upload_path){
	
	// 초기화 할 것 
	var setDefault = function(){
		// 프사 띄우기
		if( file_upload_path ){
			var img_tag = "<img src='" + file_upload_path + "' width= '100px' height= '100px'/>";
			console.log(img_tag);
			$("#image_holder_li").height(100);
			$("#image_holder").append(img_tag);
		}
	}
	
	// 이벤트 바인딩
	var bindEvent = function(){
		// hobby 선택
		$("#hobby").find("option").each(function(){
			if( $(this).val() == hobby ){
				$(this).prop("selected", "selected");
			}
		})
	}
	
	var init = (function(){
		setDefault();
		bindEvent();
	})();
	
	
};