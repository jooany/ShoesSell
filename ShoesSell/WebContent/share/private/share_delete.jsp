<%@page import="test.share.dao.ShareDao"%>
<%@page import="java.io.File"%>
<%@page import="test.share.dto.ShareDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//GET 방식 파라미터로 전달되는 삭제할 파일의 번호를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	//삭제할 파일의 정보를 읽어온다.
	ShareDto dto=ShareDao.getInstance().getData(num);
	//session 영역에 저장된 아이디를 읽어온다.
	String id=(String)session.getAttribute("id");
	//로그인된 아이디와 파일의 업로더가 다르면 
	if(!id.equals(id)){	
		//금지된 요청이라고 응답한다.
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "삭제 불가!");
		//메소드 끝내기
		return;
	}
	//삭제할 파일의 파일시스템 상에서의 절대경로 얻어오기 
	String path=request.getServletContext().getRealPath("/upload")+File.separator+dto.getSaveFileName();
	//1. 파일 시스템에서 실제 파일을 삭제
	File f=new File(path);
	f.delete();
	//2. DB 에서 파일 정보 삭제
	ShareDao.getInstance().delete(num);
	//3. 응답하기 
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/share/list.jsp");
%> 