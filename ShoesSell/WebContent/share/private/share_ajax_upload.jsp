<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   	// Tomcat 서버를 실행했을때 WebContent/upload 폴더의 실제 경로 얻어오기
   	String realPath=application.getRealPath("/upload");
   	System.out.println("realPath:"+realPath);
   	//해당 경로를 access 할수 있는 파일 객체 생성
   	File f=new File(realPath);
   	if(!f.exists()){ //만일  폴더가 존재 하지 않으면
      	f.mkdir(); //upload 폴더 만들기 
   	}
   	//최대 업로드 사이즈 설정
   	int sizeLimit=1024*1024*100; // 100 MByte
   	// <form enctype="multipart/form-data"> 로 전송된 값은 아래의 객체를 이용해서 추출한다.
   	MultipartRequest mr=new MultipartRequest(request,
         	realPath,
         	sizeLimit,
         	"utf-8",
         	new DefaultFileRenamePolicy());
   	//업로드된 이미지 파일의 저장 경로만 json 으로 응답하면 된다.
   	String saveFileName=mr.getFilesystemName("image");
   	String imagePath="/upload/"+saveFileName;
%>    
{"imagePath":"<%=imagePath %>"}

