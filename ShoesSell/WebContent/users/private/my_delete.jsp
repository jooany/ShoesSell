<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	//1. ssesion 영역에서 로그인 된 아이디를 읽어온다.
    	String id=(String)session.getAttribute("id");
    	//2. 해당 아이디를 DB 에서 삭제한다.
    	UsersDao.getInstance().delete(id);
    	//3. 로그 아웃 처리를 한다. (Seesion에서 지우기)
    	session.removeAttribute("id");
    	//4. 응답한다. (아래의 페이지에서)
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
</head>
<body>
	<script>
		alert("<%= id%>님 회원탈퇴 처리 되었습니다..");
		location.href="<%=request.getContextPath()%>/index.jsp";
	</script>	
</body>
</html>