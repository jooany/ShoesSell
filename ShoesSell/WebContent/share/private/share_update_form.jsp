<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//post 방식 전송했을때 한글 깨지지 않도록 
	request.setCharacterEncoding("utf-8");
	int num=Integer.parseInt(request.getParameter("num"));
	ShareDto dto=ShareDao.getInstance().getData(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/share/private/share_update_form.jsp</title>
</head>
<body>
<div class="container">
	<h1>share수정폼</h1>
	<form action="share_update.jsp" method="post" id="updateForm">
		<input type="hidden" name="imagePath" id="imagePath" value="<%=dto.getImagePath()%>"/>
		<input type="hidden" name="num" value="<%=num %>" />
		<div>
			<label for="writer">작성자</label>
			<input type="text" id="writer" value="<%=dto.getWriter() %>" disabled/>
		</div>
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title" value="<%=dto.getTitle()%>"/>
		</div>
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content"><%=dto.getContent() %></textarea>
		</div>
		<button id="submitBtn" type="submit" onclick="submitContents(this);">수정확인</button>
		<button type="reset">취소</button>
	</form>
	<form action="share_ajax_upload.jsp" method="post" id="ajaxForm" enctype="multipart/form-data" >
		<div class="image-container">
			<label for="myShare">파일수정</label>
			<img id="inputShare" src="${pageContext.request.contextPath}<%=dto.getImagePath() %>">
			<input style="display: block;" type="file" name="myShare" id="myShare">
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
			
		});
	});
	//등록 버튼을 눌렀을때 첫번째 form 을 강제 submit 시키기
	document.querySelector("#submitBtn").addEventListener("click", function(){
		document.querySelector("#updateForm").submit();
	});
</script>
</body>
</html>