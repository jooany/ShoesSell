<%@page import="test.feed.dto.FeedGoodDto"%>
<%@page import="test.feed.dao.FeedDao"%>
<%@page import="test.feed.dto.FeedDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//테스트로 응답을 3초 지연 시키기 
	Thread.sleep(500);

	//로그인된 아이디
	String id=(String)session.getAttribute("id");
	//ajax 요청 파라미터로 넘어오는  피드 순서 번호를 읽어낸다
	int articleNum=Integer.parseInt(request.getParameter("pageNum"));
	/*
		[ 댓글 페이징 처리에 관련된 로직 ]
	*/
	
	FeedDto dto= FeedDao.getInstance().getData(articleNum);
	
	//추천 테이블의 dto의 user에 로그인한 id를 저장함.
	FeedGoodDto dto2=new FeedGoodDto();
	dto2.setLiked_user(id);
	dto2.setFeed_num(dto.getNum());
	
	//불러오는 글을 User가 눌렀는지 확인
	boolean isUserGood=FeedDao.getInstance().isGood(dto2);
	
	//추천 글의 개수 
	int goodCount=FeedDao.getInstance().goodCount(dto.getNum());
	
%>      

<article class="article_content">
			<header>
				<div class="profile_img"><%=dto.getProfile() %></div>
				<div class="writer_name"><%=dto.getWriter() %></div>
			</header>
			<div class="img_box">
				<img src="../images/kim1.png" />
				<div class="heart_1"></div>
			</div>
			<div class="good_box page-<%=articleNum%>">				
				<a data-num="<%=articleNum %>" data-isgood="<%=isUserGood %>" data-goodcount="<%=goodCount %>" class="data<%=articleNum %> good_event heart_btn" href="javascript:">				
					<% if(isUserGood==false){ %>
						  <i class="heart_icon far fa-heart"></i>
					<%}else{ %>
						  <i class="heart_icon fas fa-heart"></i>
					<%} %>	
				</a>	
				
				<span>좋아요 <%=goodCount%> 개</span>
			</div>
			
			<div class="comment_box">있잖아 이거 댓글 박스이고 첫번째 글이야!!!</div>
			<div class="write_time"><%=dto.getRegdate() %></div>
			
		<!-- 원글에 댓글을 작성할 폼 -->
		<form class="comment-form insert-form" action="private/comment_insert.jsp" method="post">
			<!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
			<input type="hidden" name="ref_group" value="<%=dto.getNum()%>"/>
			<!-- 원글의 작성자가 댓글의 대상자가 된다. -->
			<input type="hidden" name="target_id" value="<%=dto.getWriter()%>"/>
			
			<textarea name="content"></textarea>
			<button type="submit">등록</button>
		</form>
</article>