<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
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
	
	//로그인한 id로 users dto에서 profile 이미지 가져옴.
	UsersDto dto3=UsersDao.getInstance().getData(id);
	
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
<!-- Remember to include jQuery :) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

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
   /*오른쪽 글쓰기 버튼 콘텐츠*/
   	.right_side{
   		margin-top:100px;
		float:right;
		width:300px;
		height:content-fit;
		border:1px solid rgba(0,0,0,.15);
		border-radius:4px;
		box-sizing:border-box!important;
		overflow:hidden;
	}
	.right_side .introduce_box{
		width:300px;
		margin-left:15px;
		margin-top:30px;
		margin-bottom:30px;
		display:flex!important;
	}
	.introduce_box>img{
		width:45px;
		height:45px;
		border-radius:50%;
	}
	.introduce_box .introduce{
		margin-left:10px;
	}
	.lead_write{
		font-size:13px;
		color:rgba(0,0,0,.7);
	}
	.introduce .nim{
		font-size:14px;
	}
	/*글쓰기 버튼*/
	.write_btn{
		text-decoration:none;
		color:white;
		font-weight:600;
		background-color:rgb(255, 153, 20);
		width:300px;
		height:50px;
		text-align:center;
		line-height:50px;
		border:none;
	}
	.write_btn:hover{
		color:white;
		background-color:rgb(201, 81, 0);
	}

	
	/*광고 배너*/
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
		display:flex;
		justify-content:center;
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
	.modal-content{
		width:500px;
		height:content-fit;
		margin:0 auto!important;
	}
	.modal-content textarea{
		width:466px;
		height:150px;
		border:1px solid rgba(0,0,0,.15);
		border-radius:4px;
	}
	.insert_btn{
		margin-top:30px;
		margin-bottom:30px;
		width:466px;
		height:50px;
		border:none;
		text-decoration:none;
		color:white;
		font-weight:600;
		background-color:rgb(255, 153, 20);
		text-align:center;
		line-height:50px;
		border-radius:4px;

	}
	.insert_btn:hover{
		color:white;
		background-color:rgb(201, 81, 0);
	}

</style>
</head>
<body>
<div class="inner">
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="feed" name="thisPage"/>
	</jsp:include>
</div>

<div class="inner2">

<!-- Modal -->
<div class="modal fade modal_total" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">새 게시물 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- modal 안의 내용 -->
      <div class="modal-body">
      
        <form id="uploadForm" action="private/feed_insert.jsp" method="post" id="insertForm" enctype="multipart/form-data">
            <div class="input-group flex-nowrap">
            	 <span class="input-group-text" id="title">제목</span>
		         <label class="form-label" for="title"></label>
		         <input class="form-control" type="text" name="title" id="title" aria-label="title" aria-describedby="title"/>
      		</div>
	        <div> 
				<label class="form-label" for="content"></label>
				<textarea name="content" id="content"></textarea>
			</div>
			<div>
				<label class="form-label" for="image"></label>
				<input class="form-control" type="file" name="image" id="image"
					accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
			</div>
			<button type="submit" class="insert_btn">작성</button>
        
        </form> 
              
      </div> 
        
     
    </div>
  </div>
</div>

	 <div class="right_side">
	     <div class="introduce_box">
				<img class="profile_img" src="<%=request.getContextPath()%><%=dto3.getProfile()%>"/>
				<div class="introduce">
					<div class="introduce_content">
						<span class="fw-bolder"><%=id %></span><span class="nim"> 님,</span>
						<p class="lead_write">피드를 작성해보세요!</p>
					</div>
				</div>
			</div>
		<div>
			

    	<button type="button" class="write_btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
    		<div>글쓰기</div>
    	</button>
    		
   		</div>
	      
    </div>
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
				<form class="comment-form insert-form " action="private/comment_insert.jsp" method="post" enctype="multipart/form-data">
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



<script>

	//클라이언트가 로그인 했는지 여부
	let isLogin=<%=isLogin%>;
	
	//list.jsp 로딩 시점에 만들어진 1 페이지 해당되는 피드에 이벤트 리스너 등록
	addIsGoodListener(".good_event");
	   
	//댓글의 현재 페이지 번호를 관리할 변수를 만들고 초기값 1 대입하기
	let currentPage=1;
	//마지막 페이지는 totalPageCount 이다.  
	let lastPage=<%=totalFeedCount %>;
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
				
				//로그인 하지 않았다면, 로그인 알림과 함께 로그인 폼으로 보내버리기
				if(!isLogin){
					location.href=
						"${pageContext.request.contextPath}/users/login_form.jsp?url=${pageContext.request.contextPath}/feed/list.jsp";
				}
				
				//click 이벤트가 일어난 바로 그 요소의 isGood(로그인유저의 추천여부)를 data-isGood으로 읽어옴.
				let isGood=this.getAttribute("data-isgood");
				let goodCount=this.getAttribute("data-goodcount");
				let num=this.getAttribute("data-num");
				let orgnum=this.getAttribute("data-orgnum");

				//유저가 이미 추천했다면, 추천 테이블에 delete하고, 아이콘을 빈 하트로.
				//유저가 추천하지않았다면, 추천 테이블에 insert하고, 아이콘을 꽉 찬 하트로.
				if(isGood=="true"){						
					$(this).html("<i class='far fa-heart'></i>");
					
					goodCount--;
					$(this).next().replaceWith("<span>"+goodCount+"</span>");
					
					ajaxPromise("private/ajax_good_delete.jsp", "get", "num="+orgnum+"&id=<%=id%>")
					.then(function(response){
						return response.json();
					})
					.then(function(data){
						if(data.isDeleteGood){//유저가 테이블에 추가되었다면 
							$(".data"+num).removeAttr("data-isgood");
							$(".data"+num).removeAttr("data-goodcount");
							$(".data"+num).attr('data-isgood','false');
							$(".data"+num).attr('data-goodcount',goodCount);							
						}else{
							alert("isGood : "+data.isGood+"이 true여야하는데 실패함.");
						}
					});		
				}else{
					$(this).html("<i class='fas fa-heart'></i>");
					
					goodCount++;
					$(this).next().replaceWith("<span>"+goodCount+"</span>");
					
					ajaxPromise("private/ajax_good_insert.jsp", "get", "num="+orgnum+"&id=<%=id%>")
					.then(function(response){
						return response.json();
					})
					.then(function(data){
						if(data.isInsertGood){//유저가 테이블에 추가되었다면 
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
	$(".write_btn").on("click",function(){
		//로그인 하지 않았다면, 로그인 알림과 함께 로그인 폼으로 보내버리기
		if(!isLogin){
			location.href=
				"${pageContext.request.contextPath}/users/login_form.jsp?url=${pageContext.request.contextPath}/feed/list.jsp";
		}
	})
	
</script>

</body>
</html>