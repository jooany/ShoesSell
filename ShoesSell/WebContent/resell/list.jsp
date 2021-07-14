<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="test.resell.dto.ResellDto"%>
<%@page import="test.resell.dao.ResellDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=4;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
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
	
	//특수기호를 인코딩한 키워드를 미리 준비한다. 
	String encodedK=URLEncoder.encode(keyword);
	String kind=request.getParameter("kind");	
	
	//ResellDto 객체에 startRowNum 과 endRowNum 을 담는다.
	ResellDto dto=new ResellDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	dto.setKind(kind);
	
	
	//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
	List<ResellDto> list=null;
	//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
	int totalRow=0;
	//만일 검색 키워드가 넘어온다면 
	if(!keyword.equals("")){
		//검색 조건이 무엇이냐에 따라 분기 하기
		if(condition.equals("title_content")){//제목 + 내용 검색인 경우
			//검색 키워드를 ResellDto 에 담아서 전달한다.
			dto.setTitle(keyword);
			dto.setContent(keyword);
			//제목+내용 검색일때 호출하는 메소드를 이용해서 목록 얻어오기 
			list=ResellDao.getInstance().getListTC(dto);
			//제목+내용 검색일때 호출하는 메소드를 이용해서 row  의 갯수 얻어오기
			totalRow=ResellDao.getInstance().getCountTC(dto);
		}else if(condition.equals("title")){ //제목 검색인 경우
			dto.setTitle(keyword);
			list=ResellDao.getInstance().getListT(dto);
			totalRow=ResellDao.getInstance().getCountT(dto);
		}else if(condition.equals("writer")){ //작성자 검색인 경우
			dto.setWriter(keyword);
			list=ResellDao.getInstance().getListW(dto);
			totalRow=ResellDao.getInstance().getCountW(dto);
		} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	}else{//검색 키워드가 넘어오지 않는다면
		//키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
		list=ResellDao.getInstance().getList(dto);
		//키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
		totalRow=ResellDao.getInstance().getCount(dto);
	}
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	
	//전체 페이지의 갯수 구하기
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다. 
	}
	//로그인된 아이디 (로그인 안한경우 null 인것에 주의하기!!!)
	String id=(String)session.getAttribute("id");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/resell/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	.inner{
      max-width:1100px!important;
      margin:0 auto!important;
      box-sizing:border-box!important;
      position:relative!important;
   }
   .card-img-top{
   		max-width: 260px!important;
		max-height: 250px!important;
   }
	/* card 이미지 부모요소의 높이 지정 */
	.img-wrapper{
		height: 250px;
		/* transform 을 적용할대 0.3s 동안 순차적으로 적용하기 */
		transition: transform 0.3s ease-out;
	}
	/* .img-wrapper 에 마우스가 hover 되었을때 적용할 css */
	.img-wrapper:hover{
		/* 원본 크기의 1.1 배로 확대 시키기*/
		transform: scale(1.05);
	}
	
	.card .card-text{
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display:block;
		white-space : nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}
	.page-ui a{
		text-decoration: none;
		color: #000;
	}
	
	.page-ui a:hover{
		text-decoration: underline;
	}
	
	.page-ui a.active{
		color: red;
		font-weight: bold;
		text-decoration: underline;
	}
	.page-ui ul{
		list-style-type: none;
		padding: 0;
	}
	
	.page-ui ul > li{
		float: left;
		padding: 5px;
	}
	.input-group{
		width: 50%;
	}
	#kindBtn{
		margin-top: 10px;
		margin:20px;
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="resell" name="thisPage"/>
</jsp:include>
<div class="inner">
	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
      	<ul class="breadcrumb">
         	<li class="breadcrumb-item">
            	<a href="${pageContext.request.contextPath }/">
            		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6zm5-.793V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
						<path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z"/>
					</svg>
            	</a>
         	</li>
         	<li class="breadcrumb-item active">마켓</li>
      	</ul>
   	</nav>
   	<h2 align="center">ResellGallery</h2>
   	<div align="center">
			<a class="btn btn-dark" id="kindBtn" href="list.jsp?kind=buy">Buy</a>
			<a class="btn btn-dark" id="kindBtn" href="list.jsp?kind=sell">Sell</a>
   	</div>
	<div align="right" class="addBtn">
		<a href="private/resell_upload_form.jsp" class="btn btn-outline-secondary">글쓰기</a>
	</div>
	<br />
	<div class="row">
		<%for(ResellDto tmp:list){ %>
		<div class="col-6 col-md-4 col-lg-3">
			<div class="card mb-3">
				<a href="detail.jsp?kind=<%=tmp.getKind() %>&num=<%=tmp.getNum() %>&condition=<%=condition %>&keyword=<%=encodedK %>">
					<div class="img-wrapper">
						<img class="card-img-top" src="${pageContext.request.contextPath }<%=tmp.getImagePath() %>" />
					</div>
				</a>
				<!-- 이미지 링크 끝 -->
				<div class="card-body">
					<p class="card-text"><strong>제목</strong> : <%=tmp.getTitle() %></p>
					<p class="card-text"><strong>글 종류</strong> : <small><%=tmp.getKind() %></small></p>
					<p class="card-text"><strong>작성자</strong> : <%=tmp.getWriter() %></p>
					<p class="card-text">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
  							<path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"/>
  							<path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"/>
						</svg>
						<small><%=tmp.getRegdate() %></small>
					</p>
					<p class="card-text">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
  							<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
 							<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
						</svg>
						<small><%=tmp.getViewCount() %></small>
					</p>
				</div>
				<!-- card-body 끝 -->
			</div>
		</div>
		<%} %>
	</div>
	<div class="page-ui clearfix">
		<ul class="pagination justify-content-center">
			<%if(startPageNum != 1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?kind=<%=dto.getKind() %>&pageNum=<%=startPageNum-1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Prev</a>
				</li>
			<%} %>
			
			<%for(int i=startPageNum; i<=endPageNum ; i++){ %>
				<%if(pageNum == i){ %>
					<li class="page-item active">
						<a class="page-link" class="active" href="list.jsp?kind=<%=dto.getKind() %>&pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
					</li>
				<%}else{ %>
					<li>
						<a class="page-link" href="list.jsp?kind=<%=dto.getKind() %>&pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
					</li>
				<%} %>
			
			<%} %>
			<%if(endPageNum < totalPageCount){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?kind=<%=dto.getKind() %>&pageNum=<%=endPageNum+1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Next</a>
				</li>
			<%} %>
		</ul>
	</div>
	
	<div style="clear:both;"></div>
	
	<div align="right">
	<form action="list.jsp" method="get"> 
		<input type="hidden" name="kind" value="<%=dto.getKind() %>"/>
		<div class="input-group mb-6"> 
			<span class="input-group-text">검색조건</span>
			<select class="form-select" name="condition" id="condition">
				<option value="title_content" <%=condition.equals("title_content") ? "selected" : ""%>>제목+내용</option>
				<option value="title" <%=condition.equals("title") ? "selected" : ""%>>제목</option>
				<option value="writer" <%=condition.equals("writer") ? "selected" : ""%>>작성자</option>
			</select>
			<input class="form-control" type="text" id="keyword" name="keyword" placeholder="검색어..." value="<%=keyword%>"/>
			<button type="submit" class="btn btn-outline-success">검색</button>
		</div>
	</form>	
	</div>
	
	<%if(!condition.equals("")){ %>
		<p>
			<strong><%=totalRow %></strong> 개의 글이 검색 되었습니다.
		</p>
	<%} %>
</div>
<br />
</body>
</html>