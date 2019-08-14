<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일업로드</title>
<link rel="stylesheet" type="text/css" href="css/upload.css">
<script src="lib/jquery-1.9.1.js"></script>
<script src="lib/jquery-ui.js"></script>
<script src="js/file_upload.js"></script>
<script>
	// 파일 업로드 용
	$(function() {
		bindUploadFileEvent($("#file_upload"), $("#image_holder"),
				$("#image_holder_li"), "500px", "600px");
	});
	
	$('.fun-btn').on('click', function(event) {
		  $(this).toggleClass('start-fun');
		  var $popupbtn = $('.popupbtn');
		  $popupbtn.toggleClass('color-bg-start')
		    .toggleClass('bg-animate-color');

		  //change text when when button is clicked

		  $(this).hasClass('start-fun') ?
		    $(this).text('stop the fun') :
		    $(this).text('start the fun');

		});
</script>

<style>
</style>
</head>
<body>
	<div id="popup">
		<div id="popmenu">
			<!-- 	<p>업로드할 사진을 골라주세요</p> -->
			<!-- 파일 업로드 -->
			<form method="post" action="sns_control.jsp?action=upload"
				enctype="Multipart/form-data">
				<table>
					<tr>
						<td rowspan='2' id="pictureArea">
							<div id="image_holder"></div>
							<li class="row" id="image_holder_li">
								<ul class="item">
									<!-- 	<li class="col1"></li> -->
									<li class="col2">
										<ul>
											<li><input type="file" name="profile" id="file_upload"></li>
										</ul>
									</li>
								</ul>
						</li>
						</td>
						<th>새 게시물</th>
					</tr>
					<tr>
						<td><textarea name="textArea" cols="60" rows="40"
								style="background-color: #f6d16833; font-size:1em;"
								placeholder="오늘의 기분을 표현해 주세요"></textarea></td>
						</td>
					</tr>
				</table>

				<div class="popupbtn">
					<input type="submit" class="fun-btn" value="저장"> &nbsp;&nbsp;&nbsp; 
					<input type="button" class="fun-btn" value="취소">
				</div>
			</form>
		</div>
	</div>
</body>
</html>