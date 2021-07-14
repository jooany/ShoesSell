<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/share/private/share_upload_form.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>

<style>
   	.container{
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
	a {
		text-decoration: none;
	}
	button{
		float: right;
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
			<li class="breadcrumb-item active">add</li>
		</ol>
	</nav>
	<h1>share upload form</h1>
	<form action="share_upload.jsp" method="post" enctype="multipart/form-data" >
		<div class="mb-3">
			<label for="title">제목</label>
			<input class="form-control" type="text" name="title" id="title" />
		</div>
		<div class="form-floating mb-3">
			<textarea class="form-control" name="content" id="content" style="height: 100px"></textarea>
			<label for="content">내용</label>
		</div>
		<div class="image-container mb-3">
			<label class="form-label" for="myShare">첨부파일 미리보기</label>
			<img class="mb-3" style="width: 300px; height: 200px;" id="inputShare" src="https://dummyimage.com/300x200/fff/000.jpg&text=+Attachments" onerror="this.parentNode.style.display='none'"/>
			<input class="form-control" style="display: block;" type="file" name="myShare" id="myShare">
		</div>
		<button class="btn btn-outline-primary btn-sm" type="submit">업로드</button>
	</form>
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
		        reader.readAsDataURL(input.files[0]);
		    }
		};
		
		// input file에 change 이벤트 부여
		const inputImage = document.getElementById("myShare");
		inputImage.addEventListener("change",function(e){
		    readImage(e.target);
		});
	</script>
</div>
</body>
</html>