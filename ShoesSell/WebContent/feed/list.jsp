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
	
%>    
    
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"></jsp:include>

<title>/feed/list.jsp</title>

<style>
   .inner{
      max-width:1100px!important;
      margin:0 auto!important;
      box-sizing:border-box!important;
      position:relative!important;
   }
	.article_list{

	}
	.article_content{
		width:600px;
		height:700px;
		border:1px solid pink;
	}
	.test_box{
		width:600px;
		height:500px;
		border:1px solid red;
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
</style>
</head>
<body>
<div class="inner">
	<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="test_box"></div>
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
					  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
	  					 <path d="m8 6.236-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"/>
					  </svg>
				</button>
				<span>좋아요 <%=dto.getGoodCount() %> 개</span>
			</div>
			
			<div class="comment_box">hihi  안녕안녕!!여기는 댓글 임시장소</div>
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
		
	let isGood=false; 
		
	$(".heart_btn").on("click",function(){
		//2. util 에 있는 함수를 이용해서 ajax 요청하기
		ajaxPromise("ajax_feed_good.jsp", "get", "isGood="+isGood)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			console.log(data);
			//data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
			if(data.isExist){//만일 존재한다면
				//사용할수 없는 아이디라는 피드백을 보이게 한다. 
				isIdValid=false;
				// is-invalid 클래스를 추가한다. 
				document.querySelector("#id").classList.add("is-invalid");
			}else{
				isIdValid=true;
				document.querySelector("#id").classList.add("is-valid");
			}
		});
		
	});
</script>

</body>
</html>