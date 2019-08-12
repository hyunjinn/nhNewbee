<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="lib/jquery-1.9.1.js"></script>
<script src="lib/jquery-ui.js"></script>
<script src="js/file_upload.js"></script>
<meta charset="UTF-8">
<title>New User</title>
<link rel="stylesheet" href="css/new_user.css" />
<script>
	// 파일 업로드 용
	$(function() {
		bindUploadFileEvent( $("#file_upload"), $("#image_holder"),  $("#image_holder_li"));
	});
</script>
</head>
<body>
	<HR>

	<div id="mem_title">
		<img src="img/join_title.gif">
	</div>
	<form method="post" action="user_control.jsp?action=new"
		enctype="Multipart/form-data">
		<ul id="mem_form">
			<li class="row">
				<ul class="item">
					<li class="col1"><img src="img/txt_id.gif"></li>
					<li class="col2">
						<ul>
							<li><input type="text" name="uid"></li>
							<li><img src="img/chk_id.gif"></li>
							<li>영문, 숫자 조합으로 4~12자 이내</li>
						</ul>
					</li>
				</ul>
			</li>

			<li class="row">
				<ul class="item">
					<li class="col1"><img src="img/txt_pw.gif"></li>
					<li class="col2">
						<ul>
							<li><input type="password" name="passwd"></li>
							<li>영문, 숫자 조합으로 4~12자 이내</li>
						</ul>
					</li>
				</ul>
			</li>

			<li class="row" id="pw_confirm">
				<ul class="item">
					<li class="col1"><img src="img/txt_pw2.gif"></li>
					<li class="col2">
						<ul>
							<li><input type="password" name="passwdCheck"></li>
						</ul>
					</li>
				</ul>
			</li>

			<li class="row" id="name">
				<ul class="item">
					<li class="col1"><img src="img/txt_name2.gif"></li>
					<li class="col2">
						<ul>
							<li><input type="text" name="name"></li>
						</ul>
					</li>
				</ul>
			</li>

			<li class="row" id="birthday">
				<ul class="item">
					<li class="col1"><img src="img/txt_birthday.gif"></li>
					<li class="col2">
						<ul>
							<li><input style="width: 80px" type="input" name="birth"
								placeholder="ex)19940813"></li>
							<li><input style="width: 10px" type="radio" checked></li>
							<li>음력&nbsp;</li>
							<li><input style="width: 10px" type="radio"></li>
							<li>양력</li>
						</ul>
					</li>
				</ul>
			</li>

			<li class="row" id="email">
				<ul class="item">
					<li class="col1"><img src="img/txt_email.gif"></li>
					<li class="col2">
						<ul>
							<li><input type="text" name="email"></li>
						</ul>
					</li>
				</ul>
			</li>

			<li class="row" id="job">
				<ul class="item">
					<li class="col1">
						<!-- <img src="img/txt_job.gif"> -->취미
					</li>
					<li class="col2">
						<ul>
							<li><select name="hobby">
									<option>취미</option>
									<option value="낚시">낚시</option>
									<option value="운동">운동</option>
									<option value="뮤지컬">뮤지컬</option>
									<option value="독서">독서</option>
							</select></li>
						</ul>
					</li>
				</ul>
			</li>

			<li class="row" id="image_holder_li">
				<ul class="item">
					<li class="col1">프로필 사진</li>
					<li class="col2">
						<ul>
							<li><input type="file" name="profile" id="file_upload"></li>
							<li ><div id="image_holder" ></div></li>
						</ul>
					</li>
				</ul>
			</li>
						
		</ul>
		<!-- mem_form -->

		<div id="buttons">
			<input type="submit" value="회원가입">
		</div>
	</form>
</body>
</html>
