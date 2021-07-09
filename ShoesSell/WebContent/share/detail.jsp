<%--@page import="test.share.dao.ShareCommentDao"--%>
<%--@page import="test.share.dto.ShareCommentDto"--%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//자세히 보여줄 글번호를 읽어온다. 
	int num=Integer.parseInt(request.getParameter("num"));
	
	// 검색키워드
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	// 키워드 == null
	if(keyword==null){
		keyword="";
		condition=""; 
	}
	
	// ShareDto 객체를 생성해서 
	ShareDto dto=new ShareDto();
	// 자세히 보여줄 글번호를 넣어준다.
	dto.setNum(num);
	//만일 검색 키워드가 넘어온다면 
	if(!keyword.equals("")){
		//검색 조건따라 분기
		if(condition.equals("title_filename")){//제목 + 파일명 검색인 경우
			dto.setTitle(keyword);
			dto.setOrgFileName(keyword);
			dto=ShareDao.getInstance().getDataTF(dto);
		}else if(condition.equals("title")){ //제목 검색인 경우
			dto.setTitle(keyword);
			dto=ShareDao.getInstance().getDataT(dto);
		}else if(condition.equals("writer")){ //작성자 검색인 경우
			dto.setWriter(keyword);
			dto=ShareDao.getInstance().getDataW(dto);
		}
	}else{
		dto=ShareDao.getInstance().getData(dto);
	}
	//특수기호를 인코딩한 키워드를 미리 준비한다. 
	String encodedK=URLEncoder.encode(keyword);
	
	//로그인된 아이디 (로그인을 하지 않았으면 null 이다)
	String id=(String)session.getAttribute("id");
	//로그인 여부
	boolean isLogin=false;
	if(id != null){
		isLogin=true;
	}
	//글정보를 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/Share/share_detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>  -->
</head>
<body>
<jsp:include page="../include/navbar.jsp">
   	<jsp:param value="share" name="thisPage"/>
</jsp:include>
<div class="container">
	<nav>
      	<ul class="breadcrumb">
         	<li class="breadcrumb-share">
            	<a href="${pageContext.request.contextPath }/">Home</a>
         	</li>
         	<li class="breadcrumb-share">
            	<a href="${pageContext.request.contextPath }/share/list.jsp">news</a>
         	</li>
         	<li class="breadcrumb-share active">detail</li>
      	</ul>
   	</nav>
	<%if(dto.getPrevNum()!=0){ %>
		<a href="detail.jsp?num=<%=dto.getPrevNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">이전글</a>
	<%} %>
	<%if(dto.getNextNum()!=0){ %>
		<a href="detail.jsp?num=<%=dto.getNextNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">다음글</a>
	<%} %>
	<table>
		<tr>
			<th>글번호</th>
			<td><%=dto.getNum() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=dto.getWriter() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=dto.getTitle() %></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%=dto.getRegdate() %></td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="content"><%=dto.getContent() %></div>
			</td>
		</tr>
		<tr>
			<td>
				<img src="${pageContext.request.contextPath }<%=dto.getImagePath()%>"/>
			</td>
		</tr>
		<tr>
			<td>
				<a href="share_download.jsp?num=<%=dto.getNum()%>"><%=dto.getOrgFileName() %></a>
			</td>			
		</tr>
	</table>
	<ul>
		<li><a href="list.jsp">목록보기</a></li>
		<%if(dto.getWriter().equals(id)){ %>
			<li><a href="private/share_updateform.jsp?num=<%=dto.getNum()%>">수정</a></li>
			<li><a href="private/share_delete.jsp?num=<%=dto.getNum()%>">삭제</a></li>
		<%} %>
		
	</ul>
	
</div>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<!--
<script>
	//클라이언트가 로그인 했는지 여부
	let isLogin=<%--=isLogin--%>;
	
	document.querySelector(".insert-form").addEventListener("submit", function(e){
		//만일 로그인 하지 않았으면 
		if(!isLogin){
			//폼 전송을 막고 
			e.preventDefault();
			//로그인 폼으로 이동 시킨다.
			location.href="${pageContext.request.contextPath}/users/loginform.jsp?url=${pageContext.request.contextPath}/share/detail.jsp?num=<%=num%>";
		}
	};

</script>
-->
</body>
</html>

