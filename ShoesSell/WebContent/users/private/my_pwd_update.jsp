<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   // session 영역에서 로그인된 아이디 얻어내기
   String id=(String)session.getAttribute("id");
   // 폼전송되는 구 비밀번호, 새 비밀번호 읽어오기
   String pwd=request.getParameter("pwd");
   String newPwd=request.getParameter("newPwd");
   // 구 비밀번호가 유효한 정보인지 알아낸다. 
   UsersDto dto=UsersDao.getInstance().getData(id);
   boolean isValid = pwd.equals(dto.getPwd());
   // 구 비밀번호가 맞다면 비밀번호를 수정한다.
   if(isValid){
      //dto 에 새 비밀번호를 담아서 
      dto.setPwd(newPwd);
      //dao 에 넘겨줘서 수정 반영한다. 
      UsersDao.getInstance().updatePwd(dto);
      //비밀번호를 수정했으면 로그 아웃처리를 하고 새로 로그인 하도록 한다.
      session.removeAttribute("id");
   }
   // 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_update.jsp</title>
</head>
<body>
	<script>
	   <%if(isValid){%>
		   alert("<%=id %>님 비밀번호를 수정하였습니다.");
		   location.href="<%=request.getContextPath()%>/index.jsp";
	   <%}else{%>
		   alert("비밀번호 수정에 실패했습니다.");
		   location.href="my_pwd_update.jsp";
	   <%} %>
	</script>
</body>
</html>