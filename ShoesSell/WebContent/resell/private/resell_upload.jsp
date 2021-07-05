<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="test.resell.dto.ResellDto"%>
<%@page import="test.resell.dao.ResellDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//업로드된 이미지 정보를 DB 에 저장하고
	// Tomcat 서버를 실행했을때 WebContent/upload 폴더의 실제 경로 얻어오기
	String realPath=application.getRealPath("/upload");
	System.out.println("realPath:"+realPath);
	//해당 경로를 access 할수 있는 파일 객체 생성
	File f=new File(realPath);
	if(!f.exists()){ //만일  폴더가 존재 하지 않으면
		f.mkdir(); //upload 폴더 만들기 
	}
	
	//최대 업로드 사이즈 설정
	int sizeLimit=1024*1024*10; // 10 MByte
	
	// <form enctype="multipart/form-data"> 로 전송된 값은 아래의 객체를 이용해서 추출한다.
	MultipartRequest mr=new MultipartRequest(request,
			realPath,
			sizeLimit,
			"utf-8",
			new DefaultFileRenamePolicy());	
	// /Resell/list.jsp  페이지로 리다일렉트 이동해서 업로드된 이미지목록을 
	// 보여주는 프로그래밍을 해 보세요.
	
	//이미지 설명
	String title=mr.getParameter("title");
	//원본 파일명 
	String orgFileName=mr.getOriginalFileName("image");
	//upload 폴더에 저장된 파일명 
	String saveFileName=mr.getFilesystemName("image");
	//업로드한 클라이언트의 아이디
	String writer=(String)session.getAttribute("id");
	//업로드된 파일 정보를 ResellDto 에 담아서
	ResellDto dto=new ResellDto();
	dto.setTitle(title);
	dto.setImagePath("/upload/"+saveFileName);
	dto.setWriter(writer);
	//DB 에 저장
	ResellDao.getInstance().insert(dto);
	//목록 보기로 리다일렉트 이동  응답
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/resell/list.jsp");
%>    