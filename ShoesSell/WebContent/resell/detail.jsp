<%@page import="test.resell.dto.ResellDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.resell.dao.ResellDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//자세히 보여줄 글번호를 읽어온다. 
	int num=Integer.parseInt(request.getParameter("num"));
	//조회수 올리기
	ResellDao.getInstance().addViewCount(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/resell/detail.jsp</title>
</head>
<body>

</body>
</html>