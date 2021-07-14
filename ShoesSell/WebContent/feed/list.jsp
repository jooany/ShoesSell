<%@page import="test.feed.dto.FeedGoodDto"%>
<%@page import="test.feed.dao.FeedDao"%>
<%@page import="java.util.List"%>
<%@page import="test.feed.dto.FeedDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //로그인 된 아이디 읽어오기 
    String id=(String)session.getAttribute("id");
	//로그인 여부
	boolean isLogin=false;
	if(id != null){
		isLogin=true;
	}
	
	int currentPage=1;
	FeedDto dto=new FeedDto();
	dto=FeedDao.getInstance().getData(currentPage);
	
	//추천 테이블의 dto의 user에 로그인한 id를 저장함.
	FeedGoodDto dto2=new FeedGoodDto();
	dto2.setLiked_user(id);
	dto2.setFeed_num(dto.getNum());
	
	//불러오는 글을 User가 눌렀는지 확인
	boolean isUserGood=FeedDao.getInstance().isGood(dto2);
	
	//추천 글의 개수 
	int goodCount=FeedDao.getInstance().goodCount(dto.getNum());
	
	int totalFeedCount=FeedDao.getInstance().feedCount();
%>    
    
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


<title>/feed/list.jsp</title>

<style>
	textarea::-webkit-input-placeholder { 
		line-height:55px;
		font-size:14px;	
	 }
	textarea::-moz-placeholder { 
		line-height:5px;
		font-size:14px;	 }
	textarea:-ms-input-placeholder { 
		line-height:55px;
		font-size:14px;	 }
	textarea:-moz-placeholder { 
		line-height:55px;
		font-size:14px;	 }
	textarea::placeholder { 
		line-height:55px;
		font-size:14px;	 }
		
   .inner{
      max-width:1100px!important;
      margin:0 auto!important;
      box-sizing:border-box!important;
      position:relative!important;
   }
   .inner2{
      max-width:1000px!important;
      margin:0 auto!important;
      box-sizing:border-box!important;
      position:relative!important;   	
   }
   	.right_side{
		float:right;
	}
	.right_side .introduce_box{
		border:1px solid;
		width:300px;
		height:150px;
		margin-bottom:30px;
	}
	.write_btn>div{
		border:1px solid rgba(0,0,0,.5);
		border-radius:4px;
		width:300px;
		height:50px;
		text-align:center;
		line-height:50px;
	}
	.banner_box{
		width:630px;
		margin-top:50px;
		box-sizing:border-box;
		overflow:hidden;
	}
	.banner_box .img1{
		margin-bottom:30px;
	}
	.article_list{
		width:630px;
		height:fit-content;

	}
	.article_content{
		width:630px;
		height:fit-content;
		border:1px solid rgba(0,0,0,.15);	
		box-sizing:border-box!important;
		overflow:hidden;
		margin-bottom:30px;	
	}
	.article_content .profile_header{
		width:150px;
		height:60px;
		display:flex;
		
		align-items:center;
	}
	.profile_header .profile_img{
		width:35px;
		height:35px;
		border-radius:50%;
		margin-left:15px;
	}
	.profile_header .writer_date{
		margin-left:10px;
	}
	.writer_date .writer_name{
		font-size:15px;
		font-weight:600;
		color:rgba(0,0,0,.8);
	}
	.writer_date .write_time{
		font-size:13px;
		color:rgba(0,0,0,.7);
	}
	
	.article_content .img_box{
	}
	.article_content .img_box>img{
		max-width:630px;
	}
	
	.article_content .good_box{
		width:150px;
		height:50px;
		box-sizing:border-box;
		line-height:50px;
	}
	.good_box .heart_btn{
		color:rgb(255, 54, 90);
		text-decoration:none;
		margin-left:15px!important;
	}
	.good_box .heart_btn>i{
		font-size:18px;
		margin-top:10px;
	}
	.good_box span{
		font-size:18px;
		font-weight:500!important;
	}
	.content_box{
		font-size:14px;
		margin-left:15px;
	}
	.content_box .content_writer_name{
		font-weight:600;
		color:rgba(0,0,0,.8);
	}
	.content_box .content_title{
	}
	/*댓글 박스 시작*/
	.comment_box{
		border-top:1px solid rgba(0,0,0,.2);
	}
	.comment_box form{
		display:flex;
		justify-content:center;
	}
	.comment_box textarea{
		margin-left:15px;
		width:550px;
		height:55px;
		border:none;
	}
	.comment_box button{
		border:none;
		background:none;
	}

	
	.loader{
		/* 로딩 이미지를 가운데 정렬하기 위해 */
		text-align: center;
		/* 일단 숨겨 놓기 */
		display: none;
		width:30px;
	}
	.loader svg{
		animation: rotateAni 1s ease-out infinite;
		
	}	
	@keyframes rotateAni{
		0%{
			transform: rotate(0deg);
		}
		100%{
			transform: rotate(360deg);
		}
	}	
	
</style>
</head>
<body>
<div class="inner">
	<jsp:include page="../include/navbar.jsp"></jsp:include>
</div>
<div class="inner2">
	<div class="banner_box">
		<img class="img1" src="../images/adver2.PNG" alt="news" />
	</div>
	<div class="article_list">
		<article class="article_content">
			<header class="profile_header">
				<img class="profile_img" src="<%=request.getContextPath()%><%=dto.getProfile()%>"/>
				<div class="writer_date">
					<div class="writer_name"><%=dto.getWriter() %></div>
					<div class="write_time"><%=dto.getRegdate() %></div>
				</div>
			</header>
			<div class="img_box">
				<img src="${pageContext.request.contextPath }<%=dto.getImagePath() %>" />
				<div class="heart_1"></div>
			</div>
			<div class="good_box">				
				<a data-orgnum="<%=dto.getNum() %>" data-num="1" data-isgood="<%=isUserGood %>" data-goodcount="<%=goodCount %>"  class="data1 good_event heart_btn" href="javascript:">				
					<% if(isUserGood==false){ %>
						  <i class="heart_icon far fa-heart"></i>
					<%}else{ %>
						  <i class="heart_icon fas fa-heart"></i>
					<%} %>	
				</a>	
				
				<span><%=goodCount%> </span>
			</div>
			<div class="content_box">
				<span class="content_writer_name"><%=dto.getWriter() %></span>
				<span class="content_title"><%=dto.getTitle() %></span>
				<p class="content"><%=dto.getContent() %></p>
			</div>
			<div class="comment_box">				
				<!-- 원글에 댓글을 작성할 폼 -->
				<form class="comment-form insert-form " action="private/comment_insert.jsp" method="post">
					<!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
					<input type="hidden" name="ref_group" value="<%=dto.getNum()%>"/>
					<!-- 원글의 작성자가 댓글의 대상자가 된다. -->
					<input type="hidden" name="target_id" value="<%=dto.getWriter()%>"/>
					
					<textarea placeholder="댓글 달기..." name="content" style="overflow:hidden;"></textarea>
					<button type="submit">등록</button>			
				</form>
			</div>
		</article>	
	</div><!-- article_list.end -->
	<div class="loader">
			<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
				  <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
				  <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
			</svg>
	</div>
</div>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>

	//클라이언트가 로그인 했는지 여부
	let isLogin=<%=isLogin%>;
	
	//list.jsp 로딩 시점에 만들어진 1 페이지 해당되는 피드에 이벤트 리스너 등록
	addIsGoodListener(".good_event");
	   
	//댓글의 현재 페이지 번호를 관리할 변수를 만들고 초기값 1 대입하기
	let currentPage=1;
	//마지막 페이지는 totalPageCount 이다.  
	let lastPage=<%=totalFeedCount%>;
	//추가로 댓글을 요청하고 그 작업이 끝났는지 여부를 관리할 변수 
	let isLoading=false; //현재 로딩중인지 여부 
	
	/*
		window.scrollY => 위쪽으로 스크롤된 길이
		window.innerHeight => 웹브라우저의 창의 높이
		document.body.offsetHeight => body 의 높이 (문서객체가 차지하는 높이)
	*/
		
	window.addEventListener("scroll", function(){
		//바닥 까지 스크롤 했는지 여부 
		const isBottom = 
			window.innerHeight + window.scrollY  >= document.body.offsetHeight;	
		let isLast = currentPage == lastPage; 
		//현재 바닥까지 스크롤 했고 로딩중이 아니고 현재 페이지가 마지막이 아니라면
		if(isBottom && !isLoading && !isLast){
			//로딩바 띄우기
			document.querySelector(".loader").style.display="block";
			
			//로딩 작업중이라고 표시
			isLoading=true;
			
			//현재 댓글 페이지를 1 증가 시키고 
			currentPage++;
			
			/*
				해당 페이지의 내용을 ajax 요청을 통해서 받아온다.
				"pageNum=xxx&num=xxx" 형식으로 GET 방식 파라미터를 전달한다. 
			*/
			ajaxPromise("ajax_list.jsp","get",
					"pageNum="+currentPage)
			.then(function(response){
				//json 이 아닌 html 문자열을 응답받았기 때문에  return response.text() 해준다.
				return response.text();
			})
			.then(function(data){
				// beforebegin | afterbegin | beforeend | afterend
				document.querySelector(".article_list")
					.insertAdjacentHTML("beforeend", data);
				//로딩이 끝났다고 표시한다.
				isLoading=false;
				
				//새로 추가된 피드의 하트 버튼인 a 요소를 찾아서 이벤트 리스너 등록 하기
				addIsGoodListener(".page-"+currentPage+" .good_event");
				
				//로딩바 숨기기
				document.querySelector(".loader").style.display="none";
			});
		}
	});
				
	function addIsGoodListener(sel){
		//좋아요 기능 링크의 참조값을 배열에 담아오기 
		let goodLinks=document.querySelectorAll(sel);
		for(let i=0; i<goodLinks.length; i++){
			goodLinks[i].addEventListener("click",function(){
				//click 이벤트가 일어난 바로 그 요소의 isGood(로그인유저의 추천여부)를 data-isGood으로 읽어옴.
				let isGood=this.getAttribute("data-isgood");
				let goodCount=this.getAttribute("data-goodcount");
				let num=this.getAttribute("data-num");
				let orgnum=this.getAttribute("data-orgnum");
				
				alert(orgnum);
				//유저가 이미 추천했다면, 추천 테이블에 delete하고, 아이콘을 빈 하트로.
				//유저가 추천하지않았다면, 추천 테이블에 insert하고, 아이콘을 꽉 찬 하트로.
				if(isGood=="true"){						
					$(this).html("<i class='far fa-heart'></i>");
					
					goodCount--;
					$(this).next().replaceWith("<span>"+goodCount+"</span>");
					
					ajaxPromise("private/ajax_good_delete.jsp", "get", "num=<%=dto.getNum()%>&id=<%=id%>")
					.then(function(response){
						return response.json();
					})
					.then(function(data){
						if(data.isDeleteGood){//유저가 테이블에 추가되었다면 
							alert("테이블 삭제됨!");
							$(".data"+num).removeAttr("data-isgood");
							$(".data"+num).removeAttr("data-goodcount");
							$(".data"+num).attr('data-isgood','false');
							$(".data"+num).attr('data-goodcount',goodCount);							
						}else{
							alert("삭제 실패!!!");
						}
					});		
				}else{
					$(this).html("<i class='fas fa-heart'></i>");
					
					goodCount++;
					$(this).next().replaceWith("<span>"+goodCount+"</span>");
					
					ajaxPromise("private/ajax_good_insert.jsp", "get", "num=<%=dto.getNum()%>&id=<%=id%>")
					.then(function(response){
						return response.json();
					})
					.then(function(data){
						if(data.isInsertGood){//유저가 테이블에 추가되었다면 
							alert("테이블 추가됨!");
							$(".data"+num).removeAttr("data-isgood");
							$(".data"+num).removeAttr("data-goodcount");
							$(".data"+num).attr('data-isgood','true');
							$(".data"+num).attr('data-goodcount',goodCount);
						}else{
							alert("등록 실패!!")
							
						}
					});	
					
				}//else 끝 				
			})
		}
	}

	
</script>

</body>
</html>