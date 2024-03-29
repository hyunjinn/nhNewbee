<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="mysns.sns.*,mysns.member.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 메시지 처리 빈즈 -->
<jsp:useBean id="msg" class="mysns.sns.Message" />
<jsp:useBean id="msgdao" class="mysns.sns.MessageDAO" />
<jsp:useBean id="reply" class="mysns.sns.Reply" />
<jsp:useBean id="memberDao" class="mysns.member.MemberDAO" />

<!-- 프로퍼티 set -->
<jsp:setProperty name="msg" property="*" />
<jsp:setProperty name="reply" property="*" />

<%
	// 기본 파라미터 정리
	// 컨트롤러 요청 action 코드 값
	String action = request.getParameter("action");

	String cnt = request.getParameter("cnt");

	// 특정 회원 게시물 only
	String suid = request.getParameter("suid");

	// 홈 URL
	String home;

	// 메시지 페이지 카운트
	int mcnt;

	if ((cnt != null) && (suid != null)) {
		// 각 action 처리후 메인으로 되돌아가기 위한 기본 url
		home = "sns_control.jsp?action=getall&cnt=" + cnt + "&suid=" + suid;
		mcnt = Integer.parseInt(request.getParameter("cnt"));
	} else {
		// 게시글 작성시에는 현재 상태와 상관 없이 전체 게시물의 첫페이지로 이동 하기 위한 url
		home = "sns_control.jsp?action=getall";
		// 첫페이지 요청인 경우, 기본 게시물 5개씩
		mcnt = 10;
	}

	// 댓글이 달린 게시물 위치 정보 -> accordion 상태 유지 목적
	request.setAttribute("curmsg", request.getParameter("curmsg"));

	// 새로운 메시지 등록
	if (action.equals("newmsg")) {
		if (msgdao.newMsg(msg))
			response.sendRedirect(home);
		else
			throw new Exception("메시지 등록 오류!!");
		// 댓글 등록
	} else if (action.equals("newreply")) {
		if (msgdao.newReply(reply)){
			String mid = request.getParameter("mid");
			home = "sns_control.jsp?action=message_view&mid="+mid;
			pageContext.forward(home);
		}
		else
			throw new Exception("댓글 등록 오류!!");
	}
	// 메시지 삭제
	else if (action.equals("delmsg")) {
		String mid = request.getParameter("mid");
		if (msgdao.delMsg(msg.getMid()))
			response.sendRedirect(home);
		else
			throw new Exception("메시지 등록 오류!!");
		;
	}
	// 댓글 삭제
	else if (action.equals("delreply")) {
		int rid = Integer.parseInt(request.getParameter("rid"));
		if (msgdao.delReply(rid)) {
			String mid = request.getParameter("mid");
			home = "sns_control.jsp?action=message_view&mid="+mid;
			pageContext.forward(home);
		} else
			throw new Exception("메시지 등록 오류!!");
		;
	}
	// 전체 게시글 가져오기
	else if (action.equals("getall")) {
		ArrayList<MessageSet> datas = msgdao.getMsgList(mcnt, suid);
		ArrayList<String> nusers = memberDao.getNewMembers();

		String hobby = (String) (session.getAttribute("hobby"));
		//취미 리스트
		ArrayList<Member> sameHobbyUserList = memberDao.getSameHobbyUsers(hobby);

		//생일 관련 
		ArrayList<Member> beforMember = memberDao.getBeforeBirthMembers();
		ArrayList<Member> birthMember = memberDao.getBirthMembers();
		ArrayList<Member> afterMember = memberDao.getAfterBirthMembers();
		request.setAttribute("birthMember", birthMember);
		request.setAttribute("beforMember", beforMember);
		request.setAttribute("afterMember", afterMember);

	
			
		//취미 리스트
		request.setAttribute("sameHobbyUserList", sameHobbyUserList);
		// 게시글 목록
		request.setAttribute("datas", datas);

		// 신규 회원 목록
		request.setAttribute("nusers", nusers);

		// 특정 회원 only 인 경우 회원 uid 를 request  scope 에 저장 
		request.setAttribute("suid", suid);

		// 현재 페이지 카운트 정보 저장
		request.setAttribute("cnt", mcnt);

		pageContext.forward("sns_main.jsp");
	}
	// 좋아요 추가
	else if (action.equals("addFav")) {
		String uid = (String)session.getAttribute("uid");
		int mid = Integer.parseInt(request.getParameter("mid"));
		msgdao.addFavorite(mid, uid );
	}
	// 좋아요 삭제
	else if (action.equals("removeFav")) {
		String uid = (String)session.getAttribute("uid");
		int mid = Integer.parseInt(request.getParameter("mid"));
		msgdao.deleteFavorite(mid, uid );
	}
	// 프로필 리스트 
	else if (action.equals("profile_list")) {
		// 유저 정보 get
		String uid = (String) session.getAttribute("uid");
		Member member = memberDao.getMemberByUid(uid);
		request.setAttribute("member", member);
		pageContext.forward("profile.jsp");
	}
	// 메세지 뷰
	else if (action.equals("message_view")) {
		String mid = request.getParameter("mid");
		MessageSet messageSet = msgdao.getMessageSet(mid);

		// 게시글 목록
		request.setAttribute("messageSet", messageSet);
		pageContext.forward("message_view.jsp");
		//새 게시글(사진+문구) 업로드	
	} else if (action.equals("upload")) {
		//1. Multipart 
		String uploadPath = request.getRealPath("/upload");
		// 한번에 올릴 수 있는 파일 용량 : 10M로 제한
		int size = 10 * 1024 * 1024;
		MultipartRequest multipartRequest = new MultipartRequest(request, uploadPath, size, "utf-8",
				new DefaultFileRenamePolicy());
		String textArea = multipartRequest.getParameter("textArea");
		//파일이름
		Enumeration files = multipartRequest.getFileNames();
		String fileName = multipartRequest.getFilesystemName((String) files.nextElement());
		
		String uid = (String) session.getAttribute("uid");
		
		Message board = new Message();
		board.setUid(uid);
		board.setMsg(textArea);
		board.setPhotoPath(fileName);
		request.setAttribute("board",board);
		
		if(msgdao.uploadBoard(board)){ //성공하면
			pageContext.forward("sns_control.jsp?action=getall");
		}else{
			System.out.println("업로드 실패 : msgdao.uploadBoard(board):"+msgdao.uploadBoard(board));
		}
		
	}
%>
