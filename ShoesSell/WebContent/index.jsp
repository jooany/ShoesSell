<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 된 아이디 읽어오기 
	String id=(String)session.getAttribute("id");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if (id != null){ %>
		<p>
			<a href="users/private/my_page.jsp"><%=id %></a>님 로그인 중...
			<a href="users/logout.jsp">로그아웃</a>
		</p>
	<%} %>
	<a href="users/login_form.jsp">로그인</a>
	<a href="users/signup_form.jsp">회원가입</a>
</body>
</html>