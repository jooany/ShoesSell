<%@page import="java.net.URLEncoder"%>
<%@page import="test.share.dao.ShareDao"%>
<%@page import="java.util.List"%>
<%@page import="test.share.dto.ShareDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%

	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=5;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;
	
	// 1로 초기값 지정
	int pageNum=1;
	String strPageNum=request.getParameter("pageNum");
	
	if(strPageNum != null){	
		pageNum=Integer.parseInt(strPageNum);
	}
	
	// 페이지 시작
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	// 페이지 끝
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	// 검색키워드
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	// 키워드 == null
	if(keyword==null){
		keyword="";
		condition=""; 
	}
	
	//특수기호 인코딩한 키워드 준비 
	String encodedK=URLEncoder.encode(keyword);
		
	//FileDto 객체에 startRowNum 과 endRowNum 을 담는다.
	ShareDto dto=new ShareDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	// 참조값을 담을 지역변수생성
	List<ShareDto> list=null;
	// row 갯수를 담을 지역변수생성
	int totalRow=0;
	// 검색 키워드가 넘어오면
	if(!keyword.equals("")){
		//검색 조건따라 분기
		if(condition.equals("title_filename")){//제목 + 파일명 검색인 경우
			dto.setTitle(keyword);
			dto.setOrgFileName(keyword);
			list=ShareDao.getInstance().getListTF(dto);
			totalRow=ShareDao.getInstance().getCountTF(dto);
		}else if(condition.equals("title")){ //제목 검색인 경우
			dto.setTitle(keyword);
			list=ShareDao.getInstance().getListT(dto);
			totalRow=ShareDao.getInstance().getCountT(dto);
		}else if(condition.equals("writer")){ //작성자 검색인 경우
			dto.setWriter(keyword);
			list=ShareDao.getInstance().getListW(dto);
			totalRow=ShareDao.getInstance().getCountW(dto);
		}
	}else{
		list=ShareDao.getInstance().getList(dto);
		totalRow=ShareDao.getInstance().getCount();
	}
	
	// 페이지 번호 시작 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	// 페이지 번호 끝
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	
	
	// 전체 페이지 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정
	}
	
	// 로그인된 아이디 (로그인 null 주의)
	String id=(String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/share/share_list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
   	.container{
      	max-width: 1100px!important;
      	margin: 0 auto!important;
      	box-sizing: border-box!important;
      	position: relative!important;
   	}
   	h1{
   		text-align:center;
   		font-weight:bold;
   	}
   	table{
   		text-align:center;
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
	a {
		text-decoration: none;
	}
	#title > a{
		display: block;
		width:70px;
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
	}
	button{
		float: right;
	}
</style>
</head>
<body>
<div class="container">
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="file" name="thisPage"/>
</jsp:include>
	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}/index.jsp">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6zm5-.793V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
						<path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z"/>
					</svg>
				</a>
			</li>
			<li class="breadcrumb-item active">News</li>
		</ol>
	</nav>
	<h1>News</h1>
	<table class="table table-striped">
		<thead class="table-dark">
			<tr>
				<th scope="col">번호</th>
				<th scope="col">작성자</th>
				<th scope="col">제목</th>
				<th scope="col">공유파일</th>
				<th scope="col">파일크기</th>
				<th scope="col">등록일</th>
				<th scope="col">수정</th>
				<th scope="col">삭제</th>
			</tr>
		</thead>
		<tbody>
		<%for(ShareDto tmp:list){%>
			<tr>
				<td><%=tmp.getNum() %></td>
				<td><%=tmp.getWriter() %></td>
				<td id="title"><a href="detail.jsp?num=<%=tmp.getNum()%>"><%=tmp.getTitle() %></a></td>
				<td><a href="share_download.jsp?num=<%=tmp.getNum()%>"><%=tmp.getOrgFileName() %></a></td>
				<td><%=tmp.getFileSize() %>byte</td>
				<td><%=tmp.getRegdate() %></td>
				<td><a href="private/share_update_form.jsp?num=<%=tmp.getNum() %>">수정</a></td>
				<td>
					<%if(tmp.getWriter().equals(id)){ %>
						<a href="javascript:deleteConfirm(<%=tmp.getNum()%>)">삭제</a>
					<%} %>
				</td>
			</tr>
		<%} %>
		</tbody>
	</table>
	<button class="btn btn-outline-primary btn-sm" onclick = "location.href = 'private/share_upload_form.jsp'">share</button></a>
	<div class="page-ui clearfix">
		<ul class="pagination justify-content-center">
			<%if(startPageNum != 1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Prev</a>
				</li>	
			<%} %>
			
			<%for(int i=startPageNum; i<=endPageNum ; i++){ %>
				<li class="page-item active">
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
	
	<div style="clear:both;"></div>
	
	<form align="right" action="list.jsp" method="get"> 
		<label for="condition">검색조건</label>
		<select name="condition" id="condition">
			<option value="title_filename" <%=condition.equals("title_filename") ? "selected" : ""%>>제목+파일명</option>
			<option value="title" <%=condition.equals("title") ? "selected" : ""%>>제목</option>
			<option value="writer" <%=condition.equals("writer") ? "selected" : ""%>>작성자</option>
		</select>
		<input type="text" id="keyword" name="keyword" placeholder="검색어..." value="<%=keyword%>"/>
		<button type="submit">검색</button>
	</form>	
	
	<%if(!condition.equals("")){ %>
		<p>
			<strong><%=totalRow %></strong> 개의 자료가 검색 되었습니다.
		</p>
	<%} %>
</div>
<script>
	function deleteConfirm(num){
		const isDelete=confirm(num+" 번 자료를 삭제 하겠습니까?");
		if(isDelete){
			location.href="private/share_delete.jsp?num="+num;
		}
	}
</script>
</body>
</html>