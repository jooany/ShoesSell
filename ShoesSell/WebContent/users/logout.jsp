<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	//로그 아웃은 session 영역에 저장된 id 값을 삭제하면 된다.
	session.removeAttribute("id");
	String cPath = request.getContextPath();
	response.sendRedirect(cPath+"/index.jsp"); 
    %>
