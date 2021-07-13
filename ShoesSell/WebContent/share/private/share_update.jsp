<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>

<jsp:useBean id="dto" class="test.share.dto.ShareDto"></jsp:useBean>   
<jsp:setProperty property="*" name="dto"/>

<%--
	//1. form 전송되는 수정할 정보를 읽어온다.
	request.setCharacterEncoding("utf-8");
	int num=Integer.parseInt(request.getParameter("num"));
	String writer=request.getParameter("writer");
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	String imagePath = request.getParameter("imagePath");
	String orgFileName = request.getParameter("orgFileName");
	String saveFileName = request.getParameter("saveFileName");
	// 정보를 ShareDto 객체에 담는다.
	ShareDto dto2 = new ShareDto();
	dto2.setNum(num);
	dto2.setTitle(writer);
	dto2.setTitle(title);
	dto2.setContent(content);
	dto2.setImagePath(imagePath);
	dto2.setOrgFileName(orgFileName);
	dto2.setSaveFileName(saveFileName);
--%>
<% 
	//2. DB 에 수정 반영한다.
	boolean isSuccess=ShareDao.getInstance().update(dto);
	//3. 응답한다.
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