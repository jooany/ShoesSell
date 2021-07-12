<%@page import="test.share.dao.ShareDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
    
<jsp:useBean id="dto" class="test.share.dto.ShareDto"></jsp:useBean>   
<jsp:setProperty property="*" name="dto"/> 
<%
	boolean isSuccess=ShareDao.getInstance().update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/share/private/share_update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("수정완료");
			location.href="../detail.jsp?num=<%=dto.getNum()%>";
		</script>
	<%}else{ %>
		<script>
			alert("수정실패");
			location.href="share_update_form.jsp?num=<%=dto.getNum()%>";
		</script>
	<%} %>
</body>
</html>