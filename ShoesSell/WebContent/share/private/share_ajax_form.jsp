<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
	//1. form 전송되는 수정할  정보를 읽어온다.
	request.setCharacterEncoding("utf-8");
	int num=Integer.parseInt(request.getParameter("num"));
	String writer=request.getParameter("writer");
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	String imagePath=request.getParameter("imagePath");
	//String orgFileName = request.getParameter("orgFileName");
	//String saveFileName=request.getParameter("saveFileName");
	// 정보를 ShareDto 객체에 담는다.
	ShareDto dto=new ShareDto();
	dto.setNum(num);
	dto.setWriter(writer);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setImagePath(imagePath);
	//dto.setOrgFileName(orgFileName);
	//dto.setSaveFileName(saveFileName);
	//2. DB 에 수정 반영한다.
	boolean isSuccess=ShareDao.getInstance().update(dto);
	//3. 응답한다.
%>    
{"isSuccess":<%=isSuccess %>}
