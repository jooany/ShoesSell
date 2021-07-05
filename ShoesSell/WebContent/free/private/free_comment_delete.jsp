<%@page import="test.free.dao.FreeCommentDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//삭제할 댓글 번호를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	//DB 에서 삭제한다.
	boolean isSuccess=FreeCommentDao.getInstance().delete(num);
	//json 으로 응답한다.
%>    
{"isSuccess":<%=isSuccess %>}