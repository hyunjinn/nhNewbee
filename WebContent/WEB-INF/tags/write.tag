<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@ attribute name="type" %>

<c:if test="${uid != null}">
<c:choose> 
	<c:when test="${type == 'msg'}"><!-- <input  type="text" name="msg" maxlength="200" placeholder="친구들에게 새로운 소식을 알리세요!"> -->
	<textarea cols = "100" rows = "5" name = "msg"  placeholder="친구들에게 새로운 소식을 알리세요!"></textarea>
	</c:when>
	<c:when test="${type == 'rmsg'}">댓글달기 <input  type="text" name="rmsg" maxlength="50" size="100"></c:when>
</c:choose>
</c:if>

<c:if test="${uid == null}">
<c:choose> 
	<c:when test="${type == 'msg'}"><input size = "100" name="msg" maxlength="100" disabled="disabled"  value="작성하려면 로그인 하세요!!"></c:when>
	<c:when test="${type == 'rmsg'}">댓글달기 <input type="text" name="rmsg" maxlength="50" style="width: 430px" size="100" disabled="disabled" value="작성하려면 로그인 하세요!!"></c:when>
</c:choose>
</c:if>