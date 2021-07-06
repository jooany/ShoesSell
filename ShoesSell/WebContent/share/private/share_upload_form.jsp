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
		<div>
			<label for="myShare">첨부파일</label>
			<input type="file" name="myShare" id="myShare" />
		</div>
		<button type="submit">업로드</button>
	</form>
</div>
</body>
</html>