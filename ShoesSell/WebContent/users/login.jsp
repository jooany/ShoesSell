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
   
      // isSave 라는 파라미터명으로 넘어오는 값이 있는지 확인
   String isSave=request.getParameter("isSave");
   if(isSave != null){//만일 넘어오는 값이 있다면
      //쿠키에 id 와 pwd 를 특정 키값으로 담아서 쿠키도 응답 되도록 한다.
      Cookie idCook=new Cookie("savedId", id);
      idCook.setMaxAge(60*60*6); //쿠키 유지시간 (초단위)
      response.addCookie(idCook); //기본객체 response의 addCookie 메소드를 사용
      
      Cookie pwdCook=new Cookie("savedPwd", pwd);
      pwdCook.setMaxAge(60*60*6);
      response.addCookie(pwdCook);
   }else {
	      Cookie idCook=new Cookie("savedId", id);
	      idCook.setMaxAge(0); //쿠키 유지시간 (초단위)
	      response.addCookie(idCook);
	      
	      Cookie pwdCook=new Cookie("savedPwd", pwd);
	      pwdCook.setMaxAge(0);
	      response.addCookie(pwdCook);   
   }
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 기능</title>
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
