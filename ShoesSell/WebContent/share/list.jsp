<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="file" name="thisPage"/>
</jsp:include>
<div class="container">
	<a href="private/share_upload_form.jsp">share</a>
	<h1>Share List</h1>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>공유파일</th>
				<th>파일크기</th>
				<th>등록일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<%for(ShareDto tmp:list){%>
			<tr>
				<td><%=tmp.getNum() %></td>
				<td><%=tmp.getWriter() %></td>
				<td><%=tmp.getTitle() %></td>
				<td><a href="share_download.jsp?num=<%=tmp.getNum()%>"><%=tmp.getOrgFileName() %></a></td>
				<td><%=tmp.getFileSize() %>byte</td>
				<td><%=tmp.getRegdate() %></td>
				<td><a href="../private/share_update_form.jsp">수정</a></td>
				<td><a href="../private/share_delete.jsp">삭제</a></td>
			</tr>
		<%} %>
		</tbody>
	</table>
	<div class="page-ui clearfix">
		<ul>
			<%if(startPageNum != 1){ %>
				<li>
					<a href="list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Prev</a>
				</li>	
			<%} %>
			
			<%for(int i=startPageNum; i<=endPageNum ; i++){ %>
				<li>
					<%if(pageNum == i){ %>
						<a class="active" href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
					<%}else{ %>
						<a href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
					<%} %>
				</li>	
			<%} %>
			<%if(endPageNum < totalPageCount){ %>
				<li>
					<a href="list.jsp?pageNum=<%=endPageNum+1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Next</a>
				</li>
			<%} %>
		</ul>
	</div>
	
	<div style="clear:both;"></div>
	
	<form action="list.jsp" method="get"> 
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