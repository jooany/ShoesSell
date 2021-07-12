<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.free.dto.FreeDto"%>
<%@page import="test.free.dao.FreeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=5;
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
		
	//FreeDto 객체에 startRowNum 과 endRowNum 을 담는다.
	FreeDto dto=new FreeDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);

	//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
	List<FreeDto> list=null;
	//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
	int totalRow=0;
	//만일 검색 키워드가 넘어온다면 
	if(!keyword.equals("")){
		//검색 조건이 무엇이냐에 따라 분기 하기
		if(condition.equals("title_content")){//제목 + 내용 검색인 경우
			//검색 키워드를 FreeDto 에 담아서 전달한다.
			dto.setTitle(keyword);
			dto.setContent(keyword);
			//제목+내용 검색일때 호출하는 메소드를 이용해서 목록 얻어오기 
			list=FreeDao.getInstance().getListTC(dto);
			//제목+내용 검색일때 호출하는 메소드를 이용해서 row  의 갯수 얻어오기
			totalRow=FreeDao.getInstance().getCountTC(dto);
		}else if(condition.equals("title")){ //제목 검색인 경우
			dto.setTitle(keyword);
			list=FreeDao.getInstance().getListT(dto);
			totalRow=FreeDao.getInstance().getCountT(dto);
		}else if(condition.equals("writer")){ //작성자 검색인 경우
			dto.setWriter(keyword);
			list=FreeDao.getInstance().getListW(dto);
			totalRow=FreeDao.getInstance().getCountW(dto);
		} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	}else{//검색 키워드가 넘어오지 않는다면
		//키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
		list=FreeDao.getInstance().getList(dto);
		//키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
		totalRow=FreeDao.getInstance().getCount();
	}
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	

	//전체 페이지의 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다.
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/free/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
   	.inner{
      	max-width: 1100px!important;
      	margin: 0 auto!important;
      	box-sizing: border-box!important;
      	position: relative!important;
   	}
   	h1{
   		margin: 10px;
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
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="inner">
	<div class="container">
	<a href="private/free_insertform.jsp">Add New Free Text</a>
	<h1 align="center">Free Bulletin Board</h1>
	<table class="table table-striped">
		<thead class="table-dark">
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">조회수</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
		<%for(FreeDto tmp:list){%>
			<tr>
				<td><%=tmp.getNum() %></td>
				<td><%=tmp.getWriter() %></td>
				<td>
					<a href="detail.jsp?num=<%=tmp.getNum()%>&keyword=<%=encodedK %>&condition=<%=condition%>"><%=tmp.getTitle() %></a>
				</td>
				<td><%=tmp.getViewCount() %></td>
				<td><%=tmp.getRegdate() %></td>
			</tr>
		<%} %>
		</tbody>
	</table>
	<div class="page-ui clearfix">
		<ul class="pagination justify-content-center">
			<%if(startPageNum != 1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Prev</a>
				</li>
			<%} %>
			
			<%for(int i=startPageNum; i<=endPageNum ; i++){ %>
				<%if(pageNum == i){ %>
					<li class="page-item active">
						<a class="page-link" class="active" href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
					</li>
				<%}else{ %>
					<li>
						<a class="page-link" href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
					</li>
				<%} %>
			
			<%} %>
			<%if(endPageNum < totalPageCount){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Next</a>
				</li>
			<%} %>
		</ul>
	</div>
	</div>
	<div style="clear:both;"></div>
	
	<form align="right" action="list.jsp" method="get"> 
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
</div>
</body>
</html>