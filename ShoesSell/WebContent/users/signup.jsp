<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
      //폼 전송 되는 가입할 회원의 정보를 읽어온다.
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    String email = request.getParameter("email");
    
    //UserDto 객체에 회원의 점보를 담고
    UsersDto dto = new UsersDto();
    dto.setId(id);
    dto.setPwd(pwd);
    dto.setEmail(email);
    
    //UsersDao객체를 이용해서 DB에 저장하기
    UsersDao.getInstance().insert(dto);
    
    //아래에서는 응답해주기
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signup.jsp</title>
</head>
<body>
	<script>
		alert("<%=id %>님 회원가입 완료되었습니다.");
		location.href="<%=request.getContextPath()%>/users/login_form.jsp";
	</script>
</body>
</html>