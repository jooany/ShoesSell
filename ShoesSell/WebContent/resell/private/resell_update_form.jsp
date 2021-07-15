<%@page import="java.net.URLEncoder"%>
<%@page import="test.resell.dao.ResellDao"%>
<%@page import="test.resell.dto.ResellDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	ResellDto dto=ResellDao.getInstance().getData(num);
	
	String kind=request.getParameter("kind");
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	
	String encodedK=URLEncoder.encode(keyword);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/resell/private/resell_update_form.jsp</title>
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
         		<a href="${pageContext.request.contextPath }/resell/list.jsp?kind=<%=dto.getKind()%>">마켓</a>
      		</li>
      		<li class="breadcrumb-item active">Detail</a>
      		</li>
      		<li class="breadcrumb-item active">수정</li>
   		</ul>
	</nav>
	<h1>Resell Update Form</h1>
	<form action="resell_update.jsp" method="post" id="updateForm">
		<div class="mb-3">
			<input type="hidden" name="imagePath" id="imagePath" value="<%=dto.getImagePath()%>"/>
		</div>
		<div class="mb-3">
			<input type="hidden" name="kind" value="<%=kind %>" />
			<input type="hidden" name="num" value="<%=num %>" />
			<input type="hidden" name="keyword" value="<%=encodedK %>" />
			<input type="hidden" name="condition" value="<%=condition %>" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="writer">작성자</label>
			<input class="form-control" type="text" id="writer" value="<%=dto.getWriter() %>" disabled/>
		</div>
		<div class="mb-3">
			<label class="form-label" for="title">제목</label>
			<input class="form-control" type="text" name="title" id="title" value="<%=dto.getTitle()%>"/>
		</div>
		<div class="mb-3">
			<label class="form-label" for="content">내용</label>
			<textarea name="content" id="content"><%=dto.getContent() %></textarea>
		</div>		
		<br />
		<img class="img-wrapper" src="${pageContext.request.contextPath }/<%=dto.getImagePath()%>"/>
		<br/>
		<button class="btn btn-outline-success" id="submitBtn" type="submit" onclick="submitContents(this); ">수정확인</button>
		<div class="btn-group">
  			<a href="${pageContext.request.contextPath }/resell/detail.jsp?kind=<%=dto.getKind() %>&num=<%=dto.getNum()%>&keyword=<%=encodedK %>&condition=<%=condition%>" class="btn btn-outline-danger" >취소</a>
		</div>
	</form>
	<form action="resell_ajax_upload.jsp" method="post" id="ajaxForm" enctype="multipart/form-data" >
		<div class="mb-3">
			<label class="form-label" for="image">사진 수정</label>
			<input class="form-control" type="file" name="image" id="image" 
				accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
		</div>
	</form>
</div>
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
		
	function submitContents(elClickedObj) {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script>
	//이미지를 선택했을때 실행할 함수 등록
	document.querySelector("#image").addEventListener("change", function(){
		//id가 ajaxForm 인 form 을 ajax 전송 시킨다.
		const form=document.querySelector("#ajaxForm");
		//util 함수를 이용해서 ajax 전송
		ajaxFormPromise(form)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			//data 는 {imagePath:"업로드된 이미지 경로"}
			console.log(data);
			//이미지 경로에 context path 추가하기
			const path="${pageContext.request.contextPath}"+data.imagePath;
			//img 요소에 srx 속성의 값을 넣어주어서 이미지 출력하기
			document.querySelector(".img-wrapper")
				.setAttribute("src", path);
			//input type="hidden"인 요소에 value 를 넣어준다.
			document.querySelector("#imagePath").value = data.imagePath;
		});
	});
	
	//등록 버튼을 눌렀을때 첫번째 form 을 강제 submit 시키기
	document.querySelector("#submitBtn")
		.addEventListener("click", function(){
			document.querySelector("#insertForm").submit();
		});
</script>
</body>
</html>