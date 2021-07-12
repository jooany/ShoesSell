<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
   //session 영역에서 로그인된 아이디 얻어내기
   String id=(String)session.getAttribute("id");
 
   // 폼전송되는 구 비밀번호, 새 비밀번호 읽어오기
   String pwd=request.getParameter("pwd");
   String newPwd=request.getParameter("newPwd");
   // 구 비밀번호가 유효한 정보인지 알아낸다. 
   UsersDto dto=UsersDao.getInstance().getData(id);
   boolean isValid = pwd.equals(dto.getPwd());
   // 구 비밀번호가 맞다면 비밀번호를 수정한다.
   
   if(isValid){
      //dto 에 새 비밀번호를 담아서 
      dto.setPwd(newPwd);
      //dao 에 넘겨줘서 수정 반영한다. 
      UsersDao.getInstance().updatePwd(dto);
      //비밀번호를 수정했으면 로그 아웃처리를 하고 새로 로그인 하도록 한다.
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
   }
%>    
 {"isValid":<%=isValid%>}