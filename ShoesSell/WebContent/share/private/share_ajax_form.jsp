<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
    
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
<title>share/private/share_ajax_form.jsp</title>
</head>
<body>
<div class="container">
	<h1>ajax_수정</h1>
	<form action="share_update.jsp" method="post" id="updateForm">
		<input type="hidden" name="imagePath" id="imagePath" value="<%=dto.getImagePath()%>"/>
		<input type="hidden" name="num" value="<%=dto.getNum() %>" />
		<div>
			<label for="writer">작성자</label>
			<input type="text" id="writer" value="<%=dto.getWriter() %>" disabled/>
		</div>
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title" value="<%=dto.getTitle() %>"/>
		</div>
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content"><%=dto.getContent() %></textarea>
		</div>
		<button id="submitBtn" type="submit">수정완료</button>
		<button type="reset">취소</button>
	</form>
	<form action="share_ajax_upload.jsp" method="post" id="ajaxForm" enctype="multipart/form-data">
		<div class="image-container">
			<label for="myShare">파일수정</label>
			<input type="file" name="myShare" id="myShare" value="<%=dto.getImagePath()%>"/>
		</div>
	</form>
	<div class="img-wrapper">
	   <img id="inputShare" src="${pageContext.request.contextPath}<%=dto.getImagePath() %>">
	</div>
	
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
</body>
</html>



