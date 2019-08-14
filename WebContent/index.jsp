<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
//로컬에 저장하는것은 자유지만 보안 상 읽어들일 수는 없음
// 하단 참조 후, 127.0.0.1:8887/이미지명 를 통해 읽어온다 
//  chrome-> Web Server for Chrome 확장프로그램 설치 후 폴더를  realpath로 지정 ex)C:/Users/user/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/mysns2/upload 
session.setAttribute("fileUploadPath", "http://127.0.0.1:8887/");
response.sendRedirect("sns_control.jsp?action=getall"); 
%>

<!-- C:\Users\user\Desktop\project\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\mysns2\upload -->