<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="member" class="mysns.member.Member" />
<jsp:setProperty name="member" property="*" />
<jsp:useBean id="mdao" class="mysns.member.MemberDAO" />

<!-- 생년월일 유효성 검사 -->
<%!
	boolean checkBirth(String birth){
		
		if(birth.length()==8){
			int year = Integer.parseInt(birth.substring(0,4));
			int month = Integer.parseInt(birth.substring(4, 6));
			int day = Integer.parseInt(birth.substring(6, 8));
			
			if(1900>year || year >2019){
				return false;
			}else if(month <1 || month >12){
				return false;
			}else if(day < 1 || day >31 ){
				return false;
			}else{
				return true;
			}
		}else{
			return false;
		}
}
%>

<%

	// 컨트롤러 요청 action 코드값
	String action = request.getParameter("action");
	String birth = request.getParameter("birth");
	
	// 신규 회원등록
	if (action.equals("new")) {
//1.비밀번호 체크		
		if (!request.getParameter("passwd").equals(request.getParameter("passwdCheck"))) {
			out.println("<script>alert('비밀 번호가 일치하지 않습니다. 다시입력하세요!!');history.go(-1);</script>");
		}else if(!checkBirth(birth)){
			out.println("<script>alert('생년 월일을 다시 입력하세요. ex)19940813');history.go(-1);</script>");
		}else {
			if (mdao.addMember(member))
				out.println(
						"<script>alert('정상적으로 등록 되었습니다. 로그인 하세요!!');opener.window.location.reload();window.close();</script>");
			else
				out.println("<script>alert('같은 아이디가 존재 합니다!!');history.go(-1);</script>");
		}
	}

	// 로그인
	else if (action.equals("login")) {
		if (mdao.login(member.getUid(), member.getPasswd())) {
			// 로그인 성공시 세션에 "uid" 저장
			session.setAttribute("uid", member.getUid());
			response.sendRedirect("sns_control.jsp?action=getall");
		} else {
			out.println("<script>alert('아이디나 비밀번호가 틀렸습니다.!!');history.go(-1);</script>");
		}
	}
	// 로그아웃
	else if (action.equals("logout")) {
		// 세션에 저장된 값 초기화
		session.removeAttribute("uid");
		//session.removeAttribute("suid");
		response.sendRedirect("sns_control.jsp?action=getall");
	}	
%>

