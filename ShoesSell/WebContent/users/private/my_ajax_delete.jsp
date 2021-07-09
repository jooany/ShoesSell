<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    <%
    	//1. ssesion 영역에서 로그인 된 아이디를 읽어온다.
    	String id=(String)session.getAttribute("id");
    	//2. 해당 아이디를 DB 에서 삭제한다.
    	boolean isSuccess = UsersDao.getInstance().delete(id);
    	//3. 로그 아웃 처리를 한다. (Seesion에서 지우기)
    	session.removeAttribute("id");
    	
    	Cookie[] cookies = request.getCookies();
    	for (int i = 0; i < cookies.length; i++) {
    		
    		if (cookies[i].getName().equals("savedId")){
    		cookies[i].setMaxAge(0);   // 유효시간을 0으로 설정함으로써 쿠키를 삭제 시킨다.  
    		cookies[i].setPath("/ShoesSell/users");
    		response.addCookie(cookies[i]);
    		}else if(cookies[i].getName().equals("savedPwd")){
    			cookies[i].setMaxAge(0);   // 유효시간을 0으로 설정함으로써 쿠키를 삭제 시킨다.  
        		cookies[i].setPath("/ShoesSell/users");
        		response.addCookie(cookies[i]);	
    		}
    	}
    %>
{"isSuccess":<%=isSuccess %>}