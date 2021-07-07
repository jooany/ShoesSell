<%@page import="test.resell.dao.ResellDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="test.resell.dto.ResellDto"></jsp:useBean>   
<jsp:setProperty property="*" name="dto"/> 
<%
	boolean isSuccess=ResellDao.getInstance().update(dto);
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
			location.href="../detail.jsp?num=<%=dto.getNum()%>";
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