<%@page import="test.free.dao.FreeDao"%>
<%@page import="test.free.dto.FreeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인된 아이디를 session 영역에서 얻어내기
	String writer=(String)session.getAttribute("id");
	//1. 폼 전송되는 글제목과 내용을 읽어와서
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	//2. DB 에 저장하고
	FreeDto dto=new FreeDto();
	dto.setWriter(writer);
	dto.setTitle(title);
	dto.setContent(content);
	boolean isSuccess=FreeDao.getInstance().insert(dto);
	//3. 응답하기 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/free/private/free_insert.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
	<script>
		alert("새글이 추가 되었습니다.");
		location.href="${pageContext.request.contextPath}/free/list.jsp";
	</script>
	<%}else{ %>
	<script>
		alert("글 저장 실패!");
		location.href="${pageContext.request.contextPath}/free/private/free_insertform.jsp";
	</script>
	<%} %>
</body>
</html>