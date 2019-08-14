<%@page import="mysns.sns.Like"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mysns.sns.Message"%>
<%@page import="mysns.sns.MessageSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="lib/jquery-1.9.1.js"></script>
<script src="lib/jquery-ui.js"></script>
<script src="lib/popper.min.js"></script>
<script src="lib/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/popup_message_view.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<% 
MessageSet messageSet = (MessageSet)request.getAttribute("messageSet");
Message message = messageSet.getMessage();
String m_date = message.getDate();
String ymd = m_date.substring(0, m_date.indexOf('/'));
ArrayList<Like> likeList = messageSet.getLikeList();
String likeListStr = "";
for(int i = 0 ; i < likeList.size() ; i ++){
	likeListStr += likeList.get(i).getUid() +"/";
}
if(likeListStr.length() > 1){
	likeListStr = likeListStr.substring(0, likeListStr.length()-1);
}
%>
</head>

<script>
	$(function(){
		$.getScript("js/message_view.js")
			.done(function () {
				console.log(MessageView);
				MessageView.init(<%=message.getMid()%>, "<%=session.getAttribute("uid") %>" );
			});
			$("#tooltip").tooltip().attr('data-original-title', "<%=likeListStr %>" );
			$("#tooltip").tooltip({
				content : function(){
					return $('#tooltip').attr('data-original-title').html();
				}
			});
	})
</script>

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
			
				<!-- 2-1. 상단 40% -->
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
					<!-- 작성 메시지 60% -->
					<div class="message_div"> <div class="message">${m.msg} </div> </div> 
					
					<!-- 좋아요 개수, 좋아요 누르기, 댓글 달기, 댓글 카운트-->
					<div style="margin-bottom: 3px;">
						<!-- 20% -->
						<div class="like">
							<!-- 좋아요 이미지에 마우스 hover 시 좋아요 누른 사람 출력  -->
							<span id="tooltip" title="aa2">
								<img src="img/like.jpg" width="30px" height="30px" style=" cursor: pointer;"> 
							</span>
							<span>${m.favcount}</span>
							<div class="reply_count" >
								댓글 ${m.replycount}개
							</div>
						</div>
					</div>
					<!-- 20% -->
					<div class="img_store">
						<span><img src="img/like1.png"  style=" cursor: pointer; display: none;" name="like" id="like1"> </span>
						<span><img src="img/like_clicked.png"  style=" cursor: pointer; display: none" name="like" id="like2"> </span>
						<span><img src="img/reply2.png" id="reply_img" style=" cursor: pointer;" > </span>
					</div>
					
				</div>
				
				<!-- 2-2. 하단  60% -->
				<div class="reply">
					<div class="write" style="display: none;">
						<form action="sns_control.jsp?action=newreply&cnt=${cnt}" method="post">
							<input type="hidden" name="mid" value="${m.mid}" /> 
							<input type="hidden" name="uid" value="${uid}" /> 
							<input type="text" name="rmsg"  /> 
							<input type="submit" value="등록"/>
						</form>
					</div>
					<div class="list">
						<ul class="list_ul" >
							<c:forEach var="r" items="${rlist}">
								<li>
									<div style="float: left; margin-bottom: 12px;">
										<img  class="profile" style="float: left;" src="${fileUploadPath}${r.profilePath}">
										<div style="display: inline; float: left; padding-left: 10px;">
											<a href="sns_control.jsp?action=getall&suid=${r.uid}" class="uid"> ${r.uid }</a> ${r.rmsg}
											<sns:rmenu  rid="${r.rid}" mid="${r.mid}" ruid="${r.uid}" />
											<br>
											<span class="date_ymd" style="margin-left: 43px">${r.date}</span>
										</div>
									</div>
								</li> 
							</c:forEach> 
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>