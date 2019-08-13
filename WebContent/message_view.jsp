<%@page import="mysns.sns.Message"%>
<%@page import="mysns.sns.MessageSet"%>
<%@page import="com.sun.swing.internal.plaf.metal.resources.metal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/popup_message_view.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<% 
MessageSet messageSet = (MessageSet)request.getAttribute("messageSet");
Message message = messageSet.getMessage();
String m_date = message.getDate();
String ymd = m_date.substring(0, m_date.indexOf('/'));
%>
</head>
<body>

	<div class="popup">
		<c:set var="m" value="${messageSet.message}" />
		<c:set var="rlist" value="${messageSet.rlist}" />
		<div class="popmenu">
			<!-- 1. 좌측 -->
			<div class="image_div">
				<img class="image" src="${fileUploadPath}${m.photoPath}"> 
			</div>
			
			<!-- 2. 우측 -->
			<div class="content">
			
				<!-- 2-1. 상단 30% -->
				<div class="member_div">
				
					<!-- 작성자 프로필, 아이디, 작성날짜 20%  -->
					<div class="member"> 
						 <div class="member_profile"> 
						 	<img class="profile" src="${fileUploadPath}${m.photoPath}"> 
					 	</div>
						 <div class="member_info">
							 <a href="sns_control.jsp?action=getall&suid=${m.uid}" class="uid"> ${m.uid} </a> <br> 
							<span class="date_ymd"><%=ymd %></span>
						</div>
					</div>
					<!-- 작성 메시지 30% -->
					<div class="message_div"> <div class="message">${m.msg} </div> </div> 
					<!-- 좋아요 개수, 좋아요 누르기, 댓글 달기, 댓글 카운트-->
					<div>
						<!-- 25% -->
						<div class="like">
							<img src="img/like.png" width="30px" height="30px"> 
							<span>${m.favcount}</span>
							<div class="reply_count" >
								댓글 ${m.replycount}개
							</div>
						</div>
					</div>
					<!-- 25% -->
					<div class="img_store">
						<span><img src="img/like2.png"> </span>
						<span><img src="img/reply.png"> </span>
					</div>
					
				</div>
				
				<!-- 2-2. 하단 -->
				<div class="reply">
					<div class="write">
						<form action="sns_control.jsp?action=newreply&cnt=${cnt}"
							method="post">
							<input type="hidden" name="mid" value="${m.mid}" /> 
							<input type="hidden" name="uid" value="${uid}" /> 
							<input type="hidden" name="suid" value="${suid}" />
							 <input type="hidden" name="curmsg" value="${mcnt.index}" />
						</form>
					</div>
					<div class="list">
						<ul style="list-style:none; padding: 10px">
							<c:forEach var="r" items="${rlist}">
								<li>
									<div>
										<img class="profile" src="${fileUploadPath}${r.profilePath}">
										<a href="sns_control.jsp?action=getall&suid=${r.uid}" class="uid"> ${r.uid }</a> ${r.rmsg}
										<sns:rmenu curmsg="${mcnt.index}" rid="${r.rid}" ruid="${r.uid}" />
										<br>
										<span class="date_ymd" style="margin-left: 43px">${r.date}</span>
									</div>
								</li>
							</c:forEach> 
						</ul>
					</div>
				</div>
			</div>
			<div class="exit">닫기</div>
		</div>
	</div>
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


</body>
</html>