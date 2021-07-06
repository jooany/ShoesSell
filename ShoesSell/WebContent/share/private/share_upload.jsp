<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 파일을 업로드할 절대 경로를 메소드를 통해서 얻어오기 (WebContent 하위의 upload 폴더)
	String path=request.getServletContext().getRealPath("/upload");
	// 경로 확인
	System.out.println(path);
	// 만일 폴더가 만들어져 있지 않다면 폴더를 만든다.
	File file=new File(path);
	if(!file.exists()){
		file.mkdir();
	}
	// cos.jar 에서 제공해주는 MultiPartRequest 객체 생성하기
	MultipartRequest mr=new MultipartRequest(request, //HttpServletRequest
			path, // 파일을 저장할 경로 
			1024*1024*100, // 최대 업로드 사이즈 제한
			"utf-8", // 한글 파일명 깨지지 않도록 인코딩 설정 
			new DefaultFileRenamePolicy()); //동일한 파일명이 있으면 자동으로 파일명 바꿔서 저장
	
	// 문자열 얻어오기
	String title=mr.getParameter("title");
	// 내용얻어오기
	String content = mr.getParameter("content");
	// 업로드된 파일을 access 할수 있는 File 객체
	File myShare=mr.getFile("myShare");
	//파일의 크기 (byte)
	long fileSize=myShare.length();	
	//원본 파일명 
	String orgFileName=mr.getOriginalFileName("myShare");
	
	String saveFileName=mr.getFilesystemName("myShare");
	
	String writer = (String)session.getAttribute("id");
	
	ShareDto dto = new ShareDto();
	dto.setWriter(writer);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setOrgFileName(orgFileName);
	dto.setSaveFileName(saveFileName);
	dto.setFileSize(fileSize);
	
	// DB에 저장한다.
	boolean isSuccess = ShareDao.getInstance().insert(dto);
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/share/share_upload.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<p>
			파일업로드 되었습니다. <a href="../list.jsp">확인</a>
		</p>
	<%}else{ %>
		<p>
			업로드 실패 <a href="share_upload_form.jsp">다시시도</a>
		</p>
	<%} %>
</body>
</html>





