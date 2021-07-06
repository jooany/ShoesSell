<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="test.resell.dto.ResellDto"%>
<%@page import="test.resell.dao.ResellDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=8;
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
		
	//ResellDto 객체에 startRowNum 과 endRowNum 을 담는다.
	ResellDto dto=new ResellDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
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
		totalRow=ResellDao.getInstance().getCount();
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
</style>
</head>
<body>
<div class="container">
	<h1>Resell Gallery</h1><br/>
	<a href="private/resell_upload_form.jsp">글쓰기</a>
	<div class="row">
		<%for(ResellDto tmp:list){ %>
		<div class="col-6 col-md-4 col-lg-3">
			<div class="card mb-3">
				<a href="detail.jsp?num=<%=tmp.getNum() %>">
					<div class="img-wrapper">
						<img class="card-img-top" src="${pageContext.request.contextPath }<%=tmp.getImagePath() %>" />
					</div>
				</a>
				<!-- 이미지 링크 끝 -->
				<div class="card-body">
					<p class="card-text"><%=tmp.getTitle() %></p>
					<p class="card-text">by <strong><%=tmp.getWriter() %></strong></p>
					<p><small><%=tmp.getRegdate() %></small></p>
					<p><small><%=tmp.getViewCount() %></small></p>
				</div>
				<!-- card-body 끝 -->
			</div>
		</div>
		<%} %>
	</div>
	<nav>
		<ul class="pagination justify-content-center">
			<%if(startPageNum != 1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>">Prev</a>
				</li>
			<%}else{ %>
				<li class="page-item disabled">
					<a class="page-link" href="javascript:">Prev</a>
				</li>
			<%} %>
			<%for(int i=startPageNum; i<=endPageNum; i++) {%>
				<%if(i==pageNum){ %>
					<li class="page-item active">
						<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
					</li>
				<%}else{ %>
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
					</li>
				<%} %>
			<%} %>
			<%if(endPageNum < totalPageCount){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>">Next</a>
				</li>
			<%}else{ %>
				<li class="page-item disabled">
					<a class="page-link" href="javascript:">Next</a>
				</li>
			<%} %>
		</ul>
	</nav>	
</div>
<div style="clear:both;"></div>
	
	<form action="list.jsp" method="get"> 
		<label for="condition">검색조건</label>
		<select name="condition" id="condition">
			<option value="title_content" <%=condition.equals("title_content") ? "selected" : ""%>>제목+내용</option>
			<option value="title" <%=condition.equals("title") ? "selected" : ""%>>제목</option>
			<option value="writer" <%=condition.equals("writer") ? "selected" : ""%>>작성자</option>
		</select>
		<input type="text" id="keyword" name="keyword" placeholder="검색어..." value="<%=keyword%>"/>
		<button type="submit">검색</button>
	</form>	
	
	<%if(!condition.equals("")){ %>
		<p>
			<strong><%=totalRow %></strong> 개의 글이 검색 되었습니다.
		</p>
	<%} %>
</body>
</html>