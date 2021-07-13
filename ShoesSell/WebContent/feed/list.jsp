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
%>    
    
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


<title>/feed/list.jsp</title>

<style>
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
	.article_list{

	}
	.article_content{
		width:640px;
		height:700px;
		border:1px solid pink;		
	}
	.banner_box{
		width:640px;
		margin-top:50px;
		box-sizing:border-box;
		overflow:hidden;
	}
	.banner_box .img1{
		margin-bottom:30px;
	}
	.banner_box .img2{
	
	}
	.loader{
		/* 로딩 이미지를 가운데 정렬하기 위해 */
		text-align: center;
		/* 일단 숨겨 놓기 */
		display: none;
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
	button{
		border:none!important;
		background:none!important;
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
	
</style>
</head>
<body>
<div class="inner">
	<jsp:include page="../include/navbar.jsp"></jsp:include>
</div>
<div class="inner2">
	<div class="right_side">
		<div class="introduce_box"></div>
		<a class="write_btn" href="private/feed_insertform.jsp">
			<div>글쓰기</div>
		</a>
	</div>
	<div class="banner_box">
		<img class="img1" src="../images/adver2.PNG" alt="news" />
	</div>
	<div class="article_list">
		<article class="article_content">
			<header>
				<div class="profile_img"><%=dto.getProfile() %></div>
				<div class="writer_name"><%=dto.getWriter() %></div>
			</header>
			<div class="img_box">
				<img src="../images/kim1.png" />
				<div class="heart_1"></div>
			</div>
			<div class="good_box">
				<button class="heart_btn">
				<% if(isUserGood==false){ %>
					  <i class="heart_icon far fa-heart"></i>
				<%}else{ %>
					  <i class="heart_icon fas fa-heart"></i>
				<%} %>	
				</button>
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
		<div class="loader">
			<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
				  <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
				  <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
			</svg>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>

	//이벤트 리스너 등록
	add

	//댓글의 현재 페이지 번호를 관리할 변수를 만들고 초기값 1 대입하기
	let currentPage=1;
	
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
		//현재 바닥까지 스크롤 했고 로딩중이 아니고 현재 페이지가 마지막이 아니라면
		if(isBottom && !isLoading){
			
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
				//로딩바 숨기기
				document.querySelector(".loader").style.display="none";
			});
		}
	});
				
	
	$(".heart_btn").on("click",function(){	
		
		let isGood =<%=isUserGood%>;
		let goodCount=<%=goodCount%>;
				
		//유저가 추천하지않았다면, 추천 테이블에 insert하고, 아이콘을 꽉 찬 하트로.
		if(isGood==false){
			
			$(this).html("<i class='fas fa-heart'></i>");
			
			goodCount++;
			$(this).next().replaceWith("<span>좋아요 "+goodCount+" 개</span>");
			
			ajaxPromise("private/ajax_good_insert.jsp", "get", "num=<%=dto.getNum()%>&id=<%=id%>")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
				//추천테이블에 insert 성공하면 색있는 하트로 변함.		
				if(data.isInsertGood){//유저가 테이블에 추가되었다면 
					isGood=true;
				}
			});

			
		//유저가 이미 추천했다면, 추천 테이블에 delete하고, 아이콘을 빈 하트로.
		}else{
		
			$(this).html("<i class='far fa-heart'></i>");
			
			goodCount--;
			$(this).next().replaceWith("<span>좋아요 "+goodCount+" 개</span>");
			
			
			ajaxPromise("private/ajax_good_delete.jsp", "get", "num=<%=dto.getNum()%>&id=<%=id%>")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
				//추천테이블에 delete를 성공하면 빈 하트로 변함.
				if(data.isDeleteGood){//유저가 테이블에 추가되었다면 
					isGood=false;
				}
			});
			
		}
	});
	
</script>

</body>
</html>