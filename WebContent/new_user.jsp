<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
* {
    margin:0;
    padding:0;
}
ul {
    list-style-type:none;
}
#mem_title {
    width:700px;
    height:25px;
    margin:10px 0 0 20px;
    border-bottom:solid 2px #1b89d4;
}
#mem_form {
    width:700px;
    margin-left:20px;
    font-family:"돋움";
    font-size:12px;
    color:#888888;
    padding-top:5px;
}
#mem_form li.row {
    height:30px;
    margin-top:10px;
    border-bottom:solid 1px #e5e5e5;
}
.item input {
    width:80px;
    height:16px;
    border:solid 1px #cccccc;
}
.item select {
    width:80px;
    height:20px;
    border:solid 1px #cccccc;
    font-size:12px;
}
.col1 {
    width:120px;
    text-align:right;
    display:inline-block;	
}
.col2 {
    margin-left:10px;
    display:inline-block;
}
.col2 li {
    display:inline-block;
    vertical-align:top;
}
#buttons {
	margin:20px 0 0 300px;
}
</style>
<title>New User</title>
</head>

<body>
<HR>
<!--<form method="post" action="user_control.jsp?action=new">
 <table>
	<tr><td>이름</td><td><input type="text" name="name" size="10" required></td></tr>
	<tr><td>아이디</td><td><input type="text" name="uid" size="10" required></td></tr>
	<tr><td>이메일</td><td><input type="email" name="email" size="10"></td></tr>
	<tr><td>비밀번호</td><td><input type="password" name="passwd" size="10" required> 
	<input type="submit" value="회원등록"></td></tr>
</table>  -->

<div id="mem_title"><img src="img/join_title.gif"></div>
<form method="post" action="user_control.jsp?action=new">
  <ul id="mem_form">
    <li class="row">
      <ul class="item">
        <li class="col1"><img src="img/txt_id.gif"></li>
        <li class="col2">
          <ul>
            <li><input type="text" name = "uid"></li>
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
            <li><input type="password" name = "passwd"></li>
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
            <li><input type="password" name = "passwdCheck"></li>
          </ul>
        </li>
      </ul>
    </li>

    <li  class="row" id="name">
      <ul class="item">
        <li class="col1"><img src="img/txt_name2.gif"></li>
        <li class="col2">
          <ul>
            <li><input type="text" name = "name"></li>
          </ul>
        </li>
      </ul>
    </li>
    
    <li  class="row" id="birthday">
      <ul class="item">
        <li class="col1"><img src="img/txt_birthday.gif"></li>
        <li class="col2">
          <ul>
          	<li><input style = "width:80px" type = "test" name = "birth" placeholder="ex)19940813"></li>
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
            <li><input type="text" name = "email"></li>
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
              <select name = "hobby">
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
   
  </ul> <!-- mem_form -->

  <div id="buttons">
  	<input type = "submit" value ="회원가입" >
  </div>
</form>
</body>
</html> 