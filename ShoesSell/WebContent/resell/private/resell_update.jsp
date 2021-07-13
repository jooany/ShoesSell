<%@page import="java.net.URLEncoder"%>
<%@page import="test.resell.dao.ResellDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="test.resell.dto.ResellDto"></jsp:useBean>   
<jsp:setProperty property="*" name="dto"/> 
<%
	boolean isSuccess=ResellDao.getInstance().update(dto);
	
	String kind=request.getParameter("kind");
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	
	String encodedK=URLEncoder.encode(keyword);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/resell/private/resell_update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("수정했습니다.");
			location.href="../detail.jsp?kind=<%=kind%>&num=<%=dto.getNum()%>&condition=<%=condition %>&keyword=<%=encodedK %>";
		</script>
	<%}else{ %>
		<h1>알림</h1>
		<p>
			글 수정 실패!
			<a href="resell_update_form.jsp?num=<%=dto.getNum()%>">다시 시도</a>
		</p>
	<%} %>
</body>
</html>