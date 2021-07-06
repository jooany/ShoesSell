<%@page import="test.share.dto.ShareDto"%>
<%@page import="test.share.dao.ShareDao"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="application/octet-stream; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//GET 방식 파라미터로 전달되는 파일번호 읽어오기
	int num=Integer.parseInt(request.getParameter("num"));
	// DB 에서 다운로드해줄 파일의 정보를 얻어온다.
	ShareDto dto=ShareDao.getInstance().getData(num);

	//파일을 다운로드 하는 작업을 해준다.
	long fileSize=dto.getFileSize();
	String orgFileName=dto.getOrgFileName();
	String saveFileName=dto.getSaveFileName();
	
	//다운로드 시켜줄 파일의 실제 경로 구성하기 
	// File.separator 는 window 에서는 \ , linux 에서는 /  를 얻어오게 된다. 
	String path=request.getServletContext().getRealPath("/upload")+File.separator+saveFileName;
	//다운로드할 파일에서 읽어들일 스트림 객체 생성하기
	FileInputStream fis=new FileInputStream(path);
	//다운로드 시켜주는 작업을 한다. (실제 파일 데이터와 원본파일명을 보내줘야한다.)
	String encodedName=null;
	System.out.println(request.getHeader("User-Agent"));
	//한글 파일명 세부처리 
	if(request.getHeader("User-Agent").contains("Firefox")){
		//벤더사가 파이어 폭스인경우 
		encodedName=new String(orgFileName.getBytes("utf-8"),"ISO-8859-1");
	}else{ //그외 다른 벤더사 
		encodedName=URLEncoder.encode(orgFileName, "utf-8");
		//파일명에 공백이있는 경우 처리 
		encodedName=encodedName.replaceAll("\\+"," ");
	}
	
	//응답 헤더 정보 설정
	response.setHeader("Content-Disposition","attachment;filename="+encodedName);
	response.setHeader("Content-Transfer-Encoding", "binary");
	
	//다운로드할 파일의 크기 읽어와서 다운로드할 파일의 크기 설정
	response.setContentLengthLong(fileSize);
	
	//클라이언트에게 출력할수 있는 스트림 객체 얻어오기
	// response.getOutputStream() 메소드는 클라이언트에게 출력할수 있는 OutputStream 객체를 반환한다.
	BufferedOutputStream bos=new BufferedOutputStream(response.getOutputStream());
	//한번에 최대 1M byte 씩 읽어올수 있는 버퍼
	byte[] buffer=new byte[1024*1024];
	int readedByte=0;
	//반복문 돌면서 출력해주기
	while(true){
		//byte[] 객체를 이용해서 파일에서 byte 알갱이 읽어오기
		readedByte = fis.read(buffer);
		if(readedByte == -1)break; //더이상 읽을 데이터가 없다면 반복문 빠져 나오기
		//읽은 만큼 출력하기
		bos.write(buffer, 0, readedByte);
		bos.flush(); //출력
	}
	//FileInputStream 닫아주기 
	fis.close();
%>    
