<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<form name="loginform" method="post" action="user_control.jsp"> 
<c:choose>
	<c:when test="${uid != null}">
		<!-- 	<li><a href="#"> :: </a></li> -->
		<li>
			<a href="sns_control.jsp?action=getall&suid=${uid}">${uid}님  환영합니다!</a>
		</li>
		<li>
			
		</li>
	</c:when>
	<c:otherwise>
		<!-- <li><a href="#"> :: </a></li>
		<li><a href="#">Login</a></li> -->
		<input type="hidden" name="action" value="login">
		<input type="text" name="uid">
		<input type="password" name="passwd">
		<!-- <input type="submit" value="로그인" id="login_btn"> -->
		<input type="image" src="img/img/btn_login.gif" id = "login_btn" >
		
	</c:otherwise>
</c:choose>
</form>