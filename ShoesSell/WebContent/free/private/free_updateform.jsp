<%@page import="test.free.dao.FreeDao"%>
<%@page import="test.free.dto.FreeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	FreeDto dto=FreeDao.getInstance().getData(num);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/free/private/free_updateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	.inner{
      	max-width: 1100px!important;
      	margin: 0 auto!important;
      	box-sizing: border-box!important;
      	position: relative!important;
   	}
	.container{
      	max-width: 1100px!important;
      	margin: 0 auto!important;
      	box-sizing: border-box!important;
      	position: relative!important;
   	}
   	h1{
		font-weight: bold!important;
		text-align: center;
	}
	body {
  		height: 100%;
	}
	#content{
		width: 99.5%;
		height: 500px;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="free" name="thisPage"/>
</jsp:include>
<div class="container">
	<h1 align="center">rewrite</h1>
	<form action="free_update.jsp" method="post">
		<input type="hidden" name="num" value="<%=num %>" />
		<div class="mb-3">
			<label class="form-label" for="writer">작성자</label>
			<input class="form-control" type="text" id="writer" value="<%=dto.getWriter() %>" disabled/>
		</div>
		<div class="mb-3">
			<label class="form-label" for="title">제목</label>
			<input class="form-control" type="text" name="title" id="title" value="<%=dto.getTitle()%>"/>
		</div>
		<div class="mb-6">
			<label class="form-label" for="content">내용</label>
			<textarea name="content" id="content"><%=dto.getContent() %></textarea>
		</div>
	</form>
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		<button class="btn btn-outline-primary me-md-2 btn-sm" type="submit" onclick="submitContents(this);">수정 확인</button>
		<button class="btn btn-outline-danger btn-sm" type="reset" onclick="location.href='javascript:history.back();'">취소</button>
	</div>
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
</body>
</html>