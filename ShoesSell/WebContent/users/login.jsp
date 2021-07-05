<%@page import="java.net.URLEncoder"%>
<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //로그인 후에 이동해야 되는 목적지 
   String url=request.getParameter("url");
   //인코딩된 목적지 (로그인 실패 시에 필요 하다)
   String encodedUrl=URLEncoder.encode(url);

   //1. 폼 전송되는 아이디와 비밀번호를 읽어온다.
   String id=request.getParameter("id");
   String pwd=request.getParameter("pwd");
   UsersDto dto=new UsersDto();
   dto.setId(id);
   dto.setPwd(pwd);
   //2. DB 에 실제로 존재하는 정보인지 확인한다.
   boolean isValid=UsersDao.getInstance().isValid(dto);
   //3. 유효한 정보이면 로그인 처리를 하고 응답, 그렇지 않다면 아이디 혹은 비밀 번호가 틀렸다고 응답
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/login.jsp</title>
</head>
<body>
	<script>   
   <%if(isValid){ 
      //로그인 했다는 의미에서 session 영역에 "id" 라는 키값으로 로그인된 아이디를 담는다.
      session.setAttribute("id", id); 
      //아무런 동작을 하지 않았을때 초 단위로 세션 유지시간을 설정할수 있다. (초단위)
      session.setMaxInactiveInterval(60*60*6);%>
      
      alert("<%=id %>님 로그인 하였습니다..");
      location.href="<%=url%>";
      
   <%}else{ %>
  	  alert("<%=id %>님 로그인 실패했습니다..");
  	  location.href="login_form.jsp?url=<%=encodedUrl%>";
   <%} %>
	</script>   
</body>
</html>
