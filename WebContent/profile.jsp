<%@page import="mysns.member.Member"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script src="lib/jquery-1.9.1.js" ></script>
<script src="lib/jquery-ui.js"></script>
<script src="lib/jquery-form.js"></script>
<script src="js/profile.js"></script>
<script>
<% 
Member member = (Member)request.getAttribute("member");
%>
var hobby = "<%=member.getHobby()%>"; 
var file_upload_path = "<%=session.getAttribute("fileUploadPath") + member.getProfilePhotoPath() %>";

$(function() {
	new Profile(hobby, file_upload_path);
});

</script>
<head>
<meta charset="UTF-8">
<title>New User</title>
<link rel="stylesheet" href="css/new_user.css" />
</head>

<body>
<HR>

<div id="mem_title"></div>
<form method="post" action="user_control.jsp?action=profile_modify" enctype = "multipart/form-data">
  <ul id="mem_form">
    <li class="row">
      <ul class="item">
        <li class="col1"><img src="img/txt_id.gif"></li>
        <li class="col2">
          <ul>
            <li><input type="text" name="uid" readonly="readonly" style=" background-color:#cccccc" value="${member.uid}" }></li>
          </ul>
        </li>
      </ul>
    </li>
    
    <li class="row">
      <ul class="item">
        <li class="col1"><img src="img/txt_pw.gif"></li>
        <li class="col2">
          <ul>
            <li><input type="password" name = "passwd" value="${member.passwd}"></li>
            <li>영문, 숫자 조합으로 4~12자 이내</li>
          </ul>
        </li>
      </ul>
    </li>
    			
    <li  class="row" id="pw_confirm">
      <ul class="item">
        <li class="col1"><img src="img/txt_pw2.gif"></li>
        <li class="col2">
          <ul>
            <li><input type="password" name = "passwdCheck" value="${member.passwd}"></li>
          </ul>
        </li>
      </ul>
    </li>

    <li class="row" id="name">
      <ul class="item">
        <li class="col1"><img src="img/txt_name2.gif"></li>
        <li class="col2">
          <ul>
            <li><input type="text" name = "name" value="${member.name}"></li>
          </ul>
        </li>
      </ul>
    </li>
    
    <li class="row" id="birthday">
      <ul class="item">
        <li class="col1"><img src="img/txt_birthday.gif"></li>
        <li class="col2">
          <ul>
          	<li><input style = "width:80px" type = "input" name = "birth" placeholder="ex)19940813" value="${member.birth}"></li>
            <li><input style="width:10px" type="radio" checked></li>
            <li>음력&nbsp;</li>
            <li><input style="width:10px" type="radio" ></li>
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
            <li><input type="text" name = "email" value="${member.email}"></li>
          </ul>
        </li>
      </ul>
    </li>
    
    <li class="row" id="job">
      <ul class="item">
        <li class="col1"><!-- <img src="img/txt_job.gif"> -->취미</li>
        <li class="col2">
          <ul>
            <li>
              <select name = "hobby" id="hobby">
                <option>취미</option>
                <option value = "낚시">낚시</option>
                <option value = "운동">운동</option>
                <option value = "뮤지컬">뮤지컬</option>
                <option value = "독서">독서</option>
              </select>
            </li>
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
					<li><div id="image_holder"></div></li>
				</ul>
			</li>
		</ul>
	</li>

</ul> <!-- mem_form -->

  <div id="buttons">
  	<input type = "submit" value ="수정" id="profile_mod_btn" >
  </div>
</form>
</body>
</html> 