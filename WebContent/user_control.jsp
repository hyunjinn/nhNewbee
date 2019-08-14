<%@page import="mysns.member.Member, java.io.File, java.util.UUID, java.util.Enumeration
 ,com.oreilly.servlet.multipart.DefaultFileRenamePolicy, com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="member" class="mysns.member.Member" />
<jsp:setProperty name="member" property="*" />
<jsp:useBean id="mdao" class="mysns.member.MemberDAO" />

<!-- 생년월일 유효성 검사 -->
<%!boolean checkBirth(String birth) {
		if (birth.length() == 8) {
			int year = Integer.parseInt(birth.substring(0, 4));
			int month = Integer.parseInt(birth.substring(4, 6));
			int day = Integer.parseInt(birth.substring(6, 8));

			if (1900 > year || year > 2019) {
				return false;
			} else if (month < 1 || month > 12) {
				return false;
			} else if (day < 1 || day > 31) {
				return false;
			} else {
				return true;
			}
		} else {
			return false;
		}
	}

	// 파일 업로드 	
	void uplaodFile(MultipartRequest multipartRequest, Member member, String uploadPath){
		try{
			 // request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
		    Enumeration files = multipartRequest.getFileNames();
		    String fileName =  multipartRequest.getFilesystemName ( (String)files.nextElement() );
		    // 파일 업로드를 위한 디렉토리 생성
		    boolean isDirectoryExist = new File(uploadPath).exists();
		    if( ! isDirectoryExist ){
		    	new File(uploadPath).mkdir();
		    }
		    member.setProfilePhotoPath( fileName );
		}catch(Exception e){ 
		    e.printStackTrace();
		}
	}
	
	
	// MultipartRequest를 이용한 member 객체 binding (일반 request 처럼 자동 bound가 안돼서 따로 해줘야함)
	Member memberSetByyMultipareRequest(MultipartRequest multipartRequest){
		Member member = new Member();
		member.setName( multipartRequest.getParameter("name") );
		member.setUid( multipartRequest.getParameter("uid") );
		member.setPasswd( multipartRequest.getParameter("passwd") );
		member.setEmail( multipartRequest.getParameter("email") );
		member.setHobby( multipartRequest.getParameter("hobby") );
		member.setBirth( multipartRequest.getParameter("birth") );
		return member;
	}
	%>

<%
	// 컨트롤러 요청 action 코드값
	String action = request.getParameter("action");
	//  로컬에 저장하는것은 자유지만 보안 상 읽어들일 수는 없음
	// 하단 참조 후, http://127.0.0.1:8887/이미지명 를 통해 읽어온다 
	//  chrome-> Web Server for Chrome 확장프로그램 설치 후 폴더를  realpath로 지정 ex)C:/Users/user/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/mysns2/upload 
	String uploadPath= request.getRealPath("/upload");
	// 한번에 올릴 수 있는 파일 용량 : 10M로 제한
	int size = 10*1024*1024;
	System.out.println("uploadPath" + uploadPath);
	// 신규 회원등록
	if (action.equals("new")) {
		// 파일 업로드를 위한 request, 일반적인 application/x-www-form-urlencoded 방식이 아니기 때문에 multi.getParameter() 형식으로 파라미터를 받아와야한다
		 MultipartRequest multipartRequest = new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
		 String birth = multipartRequest.getParameter("birth");
		//1.비밀번호 체크	
		boolean isSamePasswd = multipartRequest.getParameter("passwd").equals(multipartRequest.getParameter("passwdCheck"));
		if ( ! isSamePasswd) {
			out.println("<script>alert('비밀 번호가 일치하지 않습니다. 다시입력하세요!!');history.go(-1);</script>");
		} else if (!checkBirth(birth)) {
			out.println("<script>alert('생년 월일을 다시 입력하세요. ex)19940813');history.go(-1);</script>");
		} else {
			System.out.println(uploadPath);
			member = memberSetByyMultipareRequest(multipartRequest);
			uplaodFile(multipartRequest, member, uploadPath);
			if (mdao.addMember(member) ) {
				out.println( 
						"<script>alert('정상적으로 등록 되었습니다. 로그인 하세요!!');opener.window.location.reload();window.close();</script>");
			} else
				out.println("<script>alert('같은 아이디가 존재 합니다!!');history.go(-1);</script>");
		}
	}

	// 로그인
	else if (action.equals("login")) {
		if (mdao.login(member)) { 
			// 로그인 성공시 세션에 "uid" 저장
			session.setAttribute("uid", member.getUid());
			session.setAttribute("hobby",member.getHobby());
			session.setAttribute("profilePhotoPath",member.getProfilePhotoPath() );
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
	} else if (action.equals("profile_modify")) {
		
		// 파일 업로드를 위한 request, 일반적인 application/x-www-form-urlencoded 방식이 아니기 때문에 multi.getParameter() 형식으로 파라미터를 받아와야한다
		 MultipartRequest multipartRequest = new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
		 String birth = multipartRequest.getParameter("birth");
		//1.비밀번호 체크	
		boolean isSamePasswd = multipartRequest.getParameter("passwd").equals(multipartRequest.getParameter("passwdCheck"));
		if ( ! isSamePasswd) {
			out.println("<script>alert('비밀 번호가 일치하지 않습니다. 다시입력하세요!!');history.go(-1);</script>");
		} else if (!checkBirth(birth)) {
			out.println("<script>alert('생년 월일을 다시 입력하세요. ex)19940813');history.go(-1);</script>");
		} else {
			member = memberSetByyMultipareRequest(multipartRequest);
			uplaodFile(multipartRequest, member, uploadPath);
			if (mdao.updateMemberInfo(member) ) {
				out.println( 
						"<script>alert('수정 완료됐습니다.');opener.window.location.reload();window.close();</script>");
			} else
				out.println("<script>alert('수정 실패');history.go(-1);</script>");
		}
	}
	
	
%>

