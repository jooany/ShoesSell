<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/resell/private/resell_upload_form.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	.inner{
      max-width:1100px!important;
      margin:0 auto!important;
      box-sizing:border-box!important;
      position:relative!important;
   }
	#content{
		height: 500px;
		width: 1098px;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
   	<jsp:param value="resell" name="thisPage"/>
</jsp:include>
<div class="inner">
	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
   		<ul class="breadcrumb">
      		<li class="breadcrumb-item">
         		<a href="${pageContext.request.contextPath }/index.jsp">
         			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6zm5-.793V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
						<path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z"/>
					</svg>
         		</a>
      		</li>
      		<li class="breadcrumb-item">
      			<a href="${pageContext.request.contextPath }/resell/list.jsp?kind=buy">마켓</a>
      		</li>
      		<li class="breadcrumb-item active">글쓰기</li>
   		</ul>
	</nav>
	<h1>Resell Upload Form</h1>
	<form action="resell_upload.jsp" method="post" id="uploadForm" enctype="multipart/form-data">
		<div class="mb-3">
			<label class="form-label" for="title">제목</label>
			<input class="form-control" type="text" name="title" id="title"/>
		</div>
		<div class="mb-3">
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="kind" id="sell" value="buy" checked/>
				<label class="form-check-label" for="buy">구매글</label>
			</div>
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="kind" id="buy" value="sell"/>
				<label class="form-check-label" for="sell">판매글</label>
			</div>
		</div>
		<div class="mb-3"> 
			<label class="form-label" for="content">내용</label>
			<textarea name="content" id="content"></textarea>
		</div>
		<div class="mb-3">
			<label class="form-label" for="image">사진</label>
			<input class="form-control" type="file" name="image" id="image"
				accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
		</div>
		<br />
		<button class="btn btn-outline-success" type="submit">업로드</button>
		<div class="btn-group">
  			<a href="${pageContext.request.contextPath }/resell/list.jsp?kind=buy" class="btn btn-outline-danger" >취소</a>
		</div>
	</form>
	<br />
</div>
<%--
	[ SmartEditor 를 사용하기 위한 설정 ]
	
	1. WebContent 에 SmartEditor  폴더를 복사해서 붙여 넣기
	2. WebContent 에 upload 폴더 만들어 두기
	3. WebContent/WEB-INF/lib 폴더에 
	   commons-io.jar 파일과 commons-fileupload.jar 파일 붙여 넣기
	4. <textarea id="content" name="content"> 
	   content 가 아래의 javascript 에서 사용 되기때문에 다른 이름으로 바꾸고 
	      싶으면 javascript 에서  content 를 찾아서 모두 다른 이름으로 바꿔주면 된다. 
	5. textarea 의 크기가 SmartEditor  의 크기가 된다.
	6. 폼을 제출하고 싶으면  submitContents(this) 라는 javascript 가 
	      폼 안에 있는 버튼에서 실행되면 된다.
 --%>
<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["content"].getIR();
		alert(sHTML);
	}

	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
	
	//폼에 submit 이벤트가 일어났을때 실행할 함수 등록
	document.querySelector("#uploadForm")
		.addEventListener("submit", function(e){
			//에디터에 입력한 내용이 textarea 의 value 값이 될수 있도록 변환한다. 
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			//textarea 이외에 입력한 내용을 여기서 검증하고 
			const title=document.querySelector("#title").value;
			
			//만일 폼 제출을 막고 싶으면  
			//e.preventDefault();
			//을 수행하게 해서 폼 제출을 막아준다.
			if(title.length < 5){
				alert("제목을 5글자 이상 입력하세요!");
				e.preventDefault();
			}
			
		});
	// 파일을 안넣으면 넘어가지않게 실행할 함수등록
	document.querySelector("#uploadForm").addEventListener("submit", function(e){
		// 파일사이즈 검증하고 
		const myShare=document.querySelector("#image").value;
		//만일 폼 제출을 막고 싶으면  e.preventDefault();
		if(myShare.length < 1){
			alert("사진을 추가하세요");
			e.preventDefault();
		}
	});
</script>
</body>
</html>