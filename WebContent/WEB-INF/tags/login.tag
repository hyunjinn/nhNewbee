<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	int randomNum = (int)(Math.random()*4) + 1 ;
	String profile_img = "img/default_profile" + randomNum + ".jpg";
%>

<form name="loginform" method="post" action="user_control.jsp"> 
<c:choose>
	<c:when test="${uid != null}">
		<!-- 	<li><a href="#"> :: </a></li> -->
		<c:if test="${profilePhotoPath != null}">
			<li>
				<img src="<c:url value='${fileUploadPath}${profilePhotoPath}' />" width="100px" height="100px" />
			</li> 
		</c:if>
		<c:if test="${profilePhotoPath == null}">
			<li>
				<img src="<%=profile_img %>" width="100px" height="100px" />
			</li> 
		</c:if>
		
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