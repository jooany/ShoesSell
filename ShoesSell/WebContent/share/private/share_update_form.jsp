<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 요청 파라미터로 전달되는 수정할 내용를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	//2. 번호에 해당하는 내용을 얻어온다.
	ShareDao dao=ShareDao.getInstance();
	ShareDto dto=dao.getData(num);
	//3. 수정할 양식(form) 을 응답한다.
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/share/private/share_update_form.jsp</title>
</head>
<body>
<div class="container">	
	<form action="share_update.jsp" method="post" id="updateForm">
		<div>
			<input type="hidden" name="imagePath" id="imagePath" value="<%=dto.getImagePath()%>"/>
		</div>
		<div>
			<input type="hidden" name="num" value="<%=dto.getNum() %>" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="num">번호</label>
			<%-- input 요소에 disabled 속성을 추가하면 수정도 불가하고 전송도 되지 않는다. --%>
			<input class="form-control" type="text" name="num" id="num" value="<%=dto.getNum() %>" disabled/>
		</div>
		<div class="mb-3">
			<label class="form-label" for="title">제목</label>
			<input class="form-control" type="text" name="title" id="title" value="<%=dto.getTitle() %>"/>
		</div>
		<div class="mb-3">
			<label class="form-label" for="content">내용</label>
			<input class="form-control" type="text" name="content" id="content" value="<%=dto.getContent() %>"/>
		</div>
		<div>
			<img id="inputShare" src="${pageContext.request.contextPath}/<%=dto.getImagePath() %>" onerror="this.style.display='none'"/>
		</div>
		<button class="btn btn-primary" type="submit">수정확인</button>
		<button class="btn btn-warning" type="reset">취소</button>
	</form>
	<form action="share_ajax_upload.jsp" method="post" id="ajaxForm" enctype="multipart/form-data" >
		<div class="image-container">
			<label for="myShare">파일수정</label>
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
			//img 요소에 src 속성의 값을 넣어주어서 이미지 출력하기
			document.querySelector("#inputShare").setAttribute("src", path);
			//input type="hidden"인 요소에 value 를 넣어준다.
			document.querySelector("#imagePath").value = data.imagePath;
			
		});
	});
	
</script>
</body>
</html>