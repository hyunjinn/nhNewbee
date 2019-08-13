<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 
<h3>친구들의 최신 소식</h3>
	<div id="accordion">
		<c:forEach varStatus="mcnt" var="msgs" items="${datas}">
			<c:set var="m" value="${msgs.message}" />
			<h3>[${m.uid}]${m.msg} :: [좋아요 ${m.favcount} | 댓글
				${m.replycount}]</h3>
			<div>
				<p></p>
				<p>
					<sns:smenu mid="${m.mid}" auid="${m.uid}"
						curmsg="${mcnt.index}" />
					/ ${m.date}에 작성된 글입니다.
				</p>

				<ul class="reply">
					<c:forEach var="r" items="${msgs.rlist}">
						<li>${r.uid }::${r.rmsg}-${r.date}<sns:rmenu
								curmsg="${mcnt.index}" rid="${r.rid}" ruid="${r.uid}" /></li>
					</c:forEach>
				</ul>

				<form action="sns_control.jsp?action=newreply&cnt=${cnt}"
					method="post">
					<input type="hidden" name="mid" value="${m.mid}"> <input
						type="hidden" name="uid" value="${uid}"> <input
						type="hidden" name="suid" value="${suid}"> <input
						type="hidden" name="curmsg" value="${mcnt.index}">
					<sns:write type="rmsg" />
				</form>
			</div>
		</c:forEach>
	</div>
	
	<div align="center">
		<a href="sns_control.jsp?action=getall&cnt=${cnt+5}&suid=${suid}">더보기&gt;&gt;</a>
	</div>
	 -->
	 
	 <div>
	 	<c:set var="m" value="${messageSet.message}" />
	 	<div>
	 		<img src="${fileUploadPath}${m.photoPath}">
	 		
	 	</div>
	 	<div>
	 	</div>
	 </div>
</body>
</html>