<%@tag import="mysns.sns.Message"%>
<%@tag import="mysns.sns.MessageSet"%>
<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="rid" %>
<%@ attribute name="ruid" %>
<%@ attribute name="mid" %>


<c:if test="${uid == ruid}">
<a href="sns_control.jsp?action=delreply&rid=${rid}&mid=${mid}">x</a>
</c:if>