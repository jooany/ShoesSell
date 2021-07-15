<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 요청 파라미터로 전달되는 수정할 내용를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	//2. 번호에 해당하는 내용을 얻어온다.
	ShareDto dto=ShareDao.getInstance().getData(num);
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/share/private/share_update_form.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	.container{
      	max-width: 1100px!important;
      	margin: 0 auto!important;
      	box-sizing: border-box!important;
      	position: relative!important;
   	}
	button{
		float: right;
	}
	a{
		text-decoration: none;
	}
	#inputShare{
		padding-left: 30px;
		max-width: 700px!important;
		max-height: 500px!important;
	}
</style>
</head>
<body>
<div class="container">
<jsp:include page="../../include/navbar.jsp">
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
			<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/share/list.jsp">News</a></li>
			<li class="breadcrumb-item active">rewrite</li>
		</ol>
	</nav>
	<form action="share_update.jsp" method="post" id="updateForm">
		<div class="mb-3">
			<input class="form-control" type="hidden" name="imagePath" id="imagePath" value="<%=dto.getImagePath()%>"/>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<button class="btn btn-outline-success btn-sm me-md-2" type="submit">수정확인</button>
			<button class="btn btn-outline-primary btn-sm" type="reset" onclick="location.href='javascript:history.back();'">뒤로가기</button>
		</div>
		<div class="mb-3">
			<input class="form-control" type="hidden" name="num" value="<%=dto.getNum() %>" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="num"></label>
			<%-- input 요소에 disabled 속성을 추가하면 수정도 불가하고 전송도 되지 않는다. --%>
			<input type="hidden" class="form-control" type="text" name="num" id="num" value="<%=dto.getNum() %>" disabled/>
		</div>
		<div class="mb-3">
			<label class="form-label" for="title">제목</label>
			<input class="form-control" type="text" name="title" id="title" value="<%=dto.getTitle() %>"/>
		</div>
		<div class="mb-3">
			<label class="form-label" for="content">내용</label>
			<textarea class="form-control" name="content" id="content" style="height: 100px"><%=dto.getContent() %></textarea>
		</div>
		<div>
			<label for="myShare" class="mb-3">파일수정</label>
			<img id="inputShare" src="${pageContext.request.contextPath}/<%=dto.getImagePath() %>" onerror="this.src='https://dummyimage.com/300x200/fff/000.jpg&text=NO+IMAGE'"/>
		</div>
	</form>
	<form action="share_ajax_upload.jsp" method="post" id="ajaxForm" enctype="multipart/form-data" >
		<div class="image-container mb-3">
			<input type="hidden" name="num" value="<%=num %>" />
			<label for="myShare"></label>
			<input class="form-control form-control" style="display: block;" type="file" name="myShare" id="myShare">
		</div>
	</form>

</div>

<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>

<script>
	function readImage(input) {
	    // 인풋 태그에 파일이 있는 경우
	    if(input.files && input.files[0]) {
	        // FileReader 인스턴스 생성
	        const reader = new FileReader()
	        // 이미지가 로드가 된 경우
	        reader.onload = function(e){
	            const previewImage = document.getElementById("inputShare");
	            previewImage.src = e.target.result;
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0])
	    }
	};
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("myShare");
	inputImage.addEventListener("change",function(e){
	    readImage(e.target);
	});
</script>
<script>
	//이미지를 선택했을때 실행할 함수 등록
	document.querySelector("#myShare").addEventListener("change", function(){
		//id가 ajaxForm 인 form 을 ajax 전송 시킨다.
		const form=document.querySelector("#ajaxForm");
		//util 함수 이용해서 ajax 전송
		ajaxFormPromise(form)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			//data 는 {imagePath:"업로드된 이미지 경로"}
			console.log(data);
			//이미지 경로에 context path 추가하기
			const path="${pageContext.request.contextPath}"+data.imagePath;
			//img 요소에 src 속성의 값을 넣어주어서 이미지 출력하기
			document.querySelector("#inputShare").setAttribute("src", path);
			//input type="hidden"인 요소에 value 를 넣어준다.
			document.querySelector("#imagePath").value = data.imagePath;
			
		});
	});
	
</script>
</body>
</html>