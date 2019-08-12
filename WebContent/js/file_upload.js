
// 파일 업로드이벤트 바인드 - upload_btn : 파일 업로드 버튼, image_holder : 이미지가 올라갈 요소 , li : image_holder를 포함하는 li 요소 
var bindUploadFileEvent = function(upload_btn, image_holder, li ){
	upload_btn.on('change', function() {
		if (typeof (FileReader) != "undefined") {
			image_holder.empty();

			var reader = new FileReader();
			reader.onload = function(e) {
				$("<img />", {
					"src" : e.target.result,
					"class" : "thumb-image",
					"width" : "100px",
					"height" : "100px"
				}).appendTo(image_holder);
				li.height(100);
			}
			image_holder.show();
			reader.readAsDataURL($(this)[0].files[0]);
		} else {
			alert("This browser does not support FileReader.");
		}
	});
}