<%@page import="test.feed.dao.FeedDao"%>
<%@page import="test.feed.dto.FeedGoodDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String user=request.getParameter("id");
	
	FeedGoodDto dto=new FeedGoodDto();
	dto.setFeed_num(num);
	dto.setLiked_user(user);
	
	
	boolean isDeleteGood=false;
	boolean isGood=FeedDao.getInstance().isGood(dto);
	if(isGood==true){
		isDeleteGood=FeedDao.getInstance().goodDelete(dto);	
	}
%>
    
{"isDeleteGood":"<%=isDeleteGood%>"}