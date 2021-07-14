<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    <%
      //폼 전송 되는 가입할 회원의 정보를 읽어온다.
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    String email = request.getParameter("email");
    
    //UserDto 객체에 회원의 점보를 담고
    UsersDto dto = new UsersDto();
    dto.setId(id);
    dto.setPwd(pwd);
    dto.setEmail(email);
    
    //UsersDao객체를 이용해서 DB에 저장하기
    boolean isSuccess = UsersDao.getInstance().insert(dto);
    
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
{"isSuccess":<%=isSuccess%>}