<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
  		// 폼전송되는 프로필 이미지 경로와 이메일 주소를 읽어온다. 
  		String profile=request.getParameter("profile");
    	//만일 프로필 이미지를 한번도바꾸지 않았다면 "empty"가 넘어온다.
    	if(profile.equals("empty")){
    		profile=null; //profile 칼럼을 비워놓기 위해 null을 대입한다.
    	}
    	String email=request.getParameter("email");
    	//session 영역에 저장된 아이디를 읽어온다.
    	String id = (String)session.getAttribute("id");
    	//UsersDto 객체에 담아서
    	UsersDto dto=new UsersDto();
    	dto.setProfile(profile);
    	dto.setEmail(email);
    	dto.setId(id);
    	//DB에 수정 반영하고
    	UsersDao.getInstance().update(dto);
    	//응 답한다.
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	alert("<%=id %>님 정보가 수정되었습니다.");
	location.href="my_page.jsp";
</script>
</body>
</html>