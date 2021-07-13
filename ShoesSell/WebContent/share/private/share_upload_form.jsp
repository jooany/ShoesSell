<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/share/private/share_upload_form.jsp</title>
</head>
<body>
<div class="container">
	<h1>share upload form</h1>
	<form action="share_upload.jsp" method="post" enctype="multipart/form-data" >
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title" />
		</div>
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content"></textarea>
		</div>
		<div class="image-container">
			<label for="myShare">첨부파일</label>
			<img style="width: 100px; height: 100px;" id="inputShare" src="https://dummyimage.com/600x400/fff/000.jpg&text=+Attachments" onerror="this.style.display='none'"/>
			<input style="display: block;" type="file" name="myShare" id="myShare">
		</div>
		<button type="submit">업로드</button>
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