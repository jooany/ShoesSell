<%@page import="java.net.URLEncoder"%>
<%@page import="test.resell.dao.ResellDao"%>
<%@page import="test.resell.dto.ResellDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   	//자세히 보여줄 겔러리 item 번호를 읽어온다.
   	int num=Integer.parseInt(request.getParameter("num"));
	//조회수 올리기
	ResellDao.getInstance().addViewCount(num);
   	
   	/*
	[ 검색 키워드에 관련된 처리 ]
	-검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.		
	*/
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	//만일 키워드가 넘어오지 않는다면 
	if(keyword==null){
		//키워드와 검색 조건에 빈 문자열을 넣어준다. 
		//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
		keyword="";
		condition=""; 
	}
	//ResellDto 객체를 생성해서 
	ResellDto dto=new ResellDto();
	//자세히 보여줄 글번호를 넣어준다. 
	dto.setNum(num);
	//만일 검색 키워드가 넘어온다면 
	if(!keyword.equals("")){
		//검색 조건이 무엇이냐에 따라 분기 하기
		if(condition.equals("title_content")){//제목 + 내용 검색인 경우
			//검색 키워드를 ResellDto 에 담아서 전달한다.
			dto.setTitle(keyword);
			dto.setContent(keyword);
			dto=ResellDao.getInstance().getDataTC(dto);
		}else if(condition.equals("title")){ //제목 검색인 경우
			dto.setTitle(keyword);
			dto=ResellDao.getInstance().getDataT(dto);
		}else if(condition.equals("writer")){ //작성자 검색인 경우
			dto.setWriter(keyword);
			dto=ResellDao.getInstance().getDataW(dto);
		} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	}else{//검색 키워드가 넘어오지 않는다면
		dto=ResellDao.getInstance().getData(dto);
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
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
   	<jsp:param value="resell" name="thisPage"/>
</jsp:include>
<div class="container">
	<nav>
      	<ul class="breadcrumb">
         	<li class="breadcrumb-item">
            	<a href="${pageContext.request.contextPath }/">Home</a>
         	</li>
         	<li class="breadcrumb-item">
            	<a href="${pageContext.request.contextPath }/resell/list.jsp">Resell갤</a>
         	</li>
         	<li class="breadcrumb-item active">상세보기</li>
      	</ul>
   	</nav>
	<div class="card mb-3">
      	<img class="card-img-top" src="${pageContext.request.contextPath }<%=dto.getImagePath()%>"/>
      	<div class="card-body">
         	<p class="card-text"><%=dto.getTitle() %></p>
         	<p class="card-text">by <strong><%=dto.getWriter() %></strong></p>
         	<p><small><%=dto.getRegdate() %></small></p>
         	<p class="card-text"><%=dto.getContent() %></p>
      	</div>
   	</div>
   	<%if(dto.getPrevNum()!=0){ %>
		<a href="detail.jsp?num=<%=dto.getPrevNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">이전글</a>
	<%} %>
	<%if(dto.getNextNum()!=0){ %>
		<a href="detail.jsp?num=<%=dto.getNextNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">다음글</a>
	<%} %>
	<% if(!keyword.equals("")){ %>
		<p>	
			<strong><%=condition %></strong> 조건, 
			<strong><%=keyword %></strong> 검색어로 검색된 내용 자세히 보기 
		</p>
	<%} %>
</div>
</body>
</html>

