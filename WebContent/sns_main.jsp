<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My SNS</title>
<!-- <link rel="stylesheet" href="css/styles.css" type="text/css" media="screen" />-->
<link rel="stylesheet" href="lib/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/main.css">

<script src="lib/jquery-1.9.1.js"></script>
<script src="lib/jquery-ui.js"></script>

<script>
	$(function() {
		$("#accordion").accordion({
			heightStyle : "content",
			active : parseInt("${curmsg == null ? 0:curmsg}")
		});
		$.getScript("js/sns_main.js");
	});

	function newuser() {
		window
				.open(
						"new_user.jsp",
						"newuser",
						"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=800,height=800");
	}
</script>

<style>
</style>

<!--[if IE]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>

<body>
	<!--  -->
	<div id="wrap">
		<header>
			<!--  <a href="sns_main.jsp"> <img id="logo" src="img/img/logo.png"> </a> -->

			<nav id="top_menu">
				<div>
					<ul>
						<c:choose>
							<c:when test="${uid == null}">
								<li><a style="margin-left: 100px;"
									href="sns_control.jsp?action=getall">HOME</a></li>
							</c:when>
							<c:otherwise>
								<li style="display: inline;"><a
									href="sns_control.jsp?action=getall">HOME</a></li>
								<li style="display: inline;">|</li>
								<li style="display: inline;"><a
									href="javascript:window.open('sns_control.jsp?action=profile_list', '_blank', 'location=yes,height=570,width=520,scrollbars=yes,status=yes')">Profile</a>
								</li>
								<li style="display: inline;">|</li>
								<li style="display: inline;"><a
									href="user_control.jsp?action=logout">LogOut</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</nav>

			<div class="section">
				<div class="section__item">
					<a href="sns_control.jsp?action=getall"
						class="sm-link sm-link_padding-all sm-link1" style="top: 35px;">
						<span class="sm-link__label"
						style="font-size: 30px; color: #494902;">&nbsp;FACEBOOK&nbsp;</span>
					</a>
				</div>
			</div>
			
			<nav id="main_menu" sytle="color: #444444;">
				<div>
					<ul>
						<li><a href="#">Home</a></li>
						<li><a href="javascript:newuser()">New User</a></li>
						<li><a href="sns_control.jsp?action=getall">전체글보기</a>
					</ul>
				</div>
			</nav>
			<!-- <div class="container1">
			<h1 class="fontface" id="title">My Simple SNS</h1>
			</div> -->
		</header>

		<aside>
			<article id="login_box" style="height: 170px;">
				<img id="login_title" src="img/img/ttl_login.png">
				<div id="input_button">
					<ul id="login_input">
						<li><sns:login /></li>
					</ul>
				</div>
				<div class="clear"></div>

			</article>
			<!-- 생일인 친구 -->
			<article id="guestbook">

				<div id="guestbook_title">
					<h3>오늘 생일인 친구</h3>
				</div>
				<c:forEach items="${birthMember}" var="n">
					<ul>
						<li><a href="sns_control.jsp?action=getall&suid=${n}">${n}</a></li>
					</ul>
				</c:forEach>

				<div id="guestbook_title">
					<h3>남은 친구 생일</h3>
				</div>

				<c:forEach items="${beforMember}" var="n">
					<ul>
						<li><a href="sns_control.jsp?action=getall&suid=${n}">${n}</a></li>
					</ul>
				</c:forEach>

				<div id="guestbook_title">
					<h3>지나간 친구 생일</h3>
				</div>
				<c:forEach items="${afterMember}" var="n">
					<ul>
						<li><a href="sns_control.jsp?action=getall&suid=${n}">${n}</a></li>
					</ul>
				</c:forEach>


				<c:if test="${ hobby != null}">
					<div id="guestbook_title">
						<h3>같은 취미를 가진 친구들</h3>
					</div>
					<c:forEach items="${sameHobbyUserList}" var="member">
						<ul>
							<li><a
								href="sns_control.jsp?action=getall&suid=${member.uid}">${member.uid}</a></li>
						</ul>
					</c:forEach>
				</c:if>

			</article>
			<!--End birth-->
			<article id="guestbook">
				<div id="guestbook_title">
					<!-- <img src="img/img/ttl_memo.gif"> -->
					<h3>새로 가입한 친구들</h3>
				</div>

				<c:forEach items="${nusers}" var="n">
					<ul>
						<li><a href="sns_control.jsp?action=getall&suid=${n}">${n}</a></li>
					</ul>
				</c:forEach>
			</article>
		</aside>
		<!-- 왼쪽 Aside 끝 -->


		<div>
			<section id="main">
				<section id="content">
					<!-- 1. 등록하기
					<img src="img/img/main_img.png"> 
					<b style="color: red; margin-left: 40%; font-size: 20px;">내소식
						업데이트</b>
					<form class="m_form" method="post"
						action="sns_control.jsp?action=newmsg">
						<input type="hidden" name="uid" value="${uid}">
						<sns:write type="msg" />
						<button class="submit" type="submit">등록</button>
					</form>
					 -->

					  
					 <div class="list">
						 <ul class="imglist">
						 	<c:forEach  var="msgs" items="${datas}">
						 		<c:set var="m" value="${msgs.message}" />
							 	<li data-idx="${m.mid}" >
							 		<a>
							 			<p class="thumb">
							 				<img src= "${fileUploadPath}${m.photoPath}" />
							 			</p>
							 			<p class="game_tit"> ${m.uid} / ${m.date} </p>
							 		</a>
							 	</li>
						 	</c:forEach>
						 </ul>
					 </div>
					<p class="img_more">
						<button type="button" id="more" onclick="window.location.href='sns_control.jsp?action=getall&cnt=${cnt+10}&suid=${suid}'">더보기</button>
					</p>

				</section>
			</section>
		</div>


		<footer>
			<div class="container1">
				<section id="footer-area">

					<section id="footer-outer-block">
						<aside class="footer-segment">
							<h4>About</h4>
							<ul>
								<li><a href="#">About My Simple SNS</a></li>
								<li><a href="#">Copyright</a></li>
								<li><a href="#">Author</a></li>
							</ul>
						</aside>
						<!-- end of #first footer segment -->

						<aside class="footer-segment">
							<h4>Java Web Programming</h4>
							<ul>
								<li><a href="#">Book Information</a></li>
								<li><a href="#">Table of contents</a></li>
								<li><a href="#">Book History</a></li>
							</ul>
						</aside>
						<!-- end of #second footer segment -->

						<aside class="footer-segment">
							<h4>Contact Us</h4>
							<ul>
								<li><a href="#">Book Support</a></li>
								<li><a href="#">Publication</a></li>
								<li><a href="#">Investor Relations</a></li>
							</ul>
						</aside>
						<!-- end of #third footer segment -->

						<aside class="footer-segment">
							<h4>Hee Joung Hwang</h4>
							<p>
								&copy; 2014 <a href="#">dinfree.com</a>
							</p>
						</aside>
						<!-- end of #fourth footer segment -->

					</section>
					<!-- end of footer-outer-block -->

				</section>
				<!-- end of footer-area -->
		</footer>
	</div>
</body>
</html>