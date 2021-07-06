<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //1. session 영역에서 로그인된 아이디를 읽어온다.
   String id=(String)session.getAttribute("id");
   //2. UsersDao 객체를 이용해서 가입된 정보를 얻어온다.
   UsersDto dto=UsersDao.getInstance().getData(id);
   //3. 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
   /* 프로필 이미지를 작은 원형으로 만든다 */
   #profileImage{
      width: 150px;
      height: 150px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
   .bd-placeholder-img {
      font-size: 1.125rem;
      text-anchor: middle;
      -webkit-user-select: none;
      -moz-user-select: none;
      user-select: none;
   }

    @media (min-width: 768px) {
      .bd-placeholder-img-lg {
        font-size: 3.5rem;
      }
    }
</style>
<link href="offcanvas.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">

	<main class="container">
	
	  <div class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm">
	    <img class="me-3" src="https://getbootstrap.com/docs/5.0/assets/brand/bootstrap-logo-white.svg" alt="" width="48" height="38">
	    <div class="lh-1">
	      <h1 class="h6 mb-0 text-white lh-1">MyPage</h1>
	    </div>
	  </div>
	
	  <div class="my-3 p-3 bg-body rounded shadow-sm">
	    <h6 class="border-bottom pb-2 mb-0">개인정보</h6>
	    
	    <div class="d-flex text-muted pt-3">
	      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#007bff"/><text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text></svg>
	      <p class="pb-3 mb-0 small lh-sm border-bottom">
	        <strong class="d-block text-gray-dark">아이디</strong>
	        <strong><%=id %></strong>
	      </p>
	      
	    </div>
	    
	    <div class="d-flex text-muted pt-3">
	      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#e83e8c"/><text x="50%" y="50%" fill="#e83e8c" dy=".3em">32x32</text></svg>
	
	      <p class="pb-3 mb-0 small lh-sm border-bottom">
	        <strong class="d-block text-gray-dark">비밀번호 수정</strong>
	        <strong><a href="my_pwd_update_form.jsp">수정하기</a></strong>
	      </p>
	    </div>
	    
	    <div class="d-flex text-muted pt-3">
	      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#6f42c1"/><text x="50%" y="50%" fill="#6f42c1" dy=".3em">32x32</text></svg>
	
	      <p class="pb-3 mb-0 small lh-sm border-bottom">
	        <strong class="d-block text-gray-dark">프로필 사진</strong><br>
	        <%if(dto.getProfile() == null){ %>   
	            <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
	              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
	              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
	            </svg>
        	 <%}else{ %>
         		<img id="profileImage" src="<%=request.getContextPath()%><%=dto.getProfile()%>"/>
         	 <%} %>   
	      </p>
	    </div>
	    
	    <div class="d-flex text-muted pt-3">
	      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#e83e8c"/><text x="50%" y="50%" fill="#e83e8c" dy=".3em">32x32</text></svg>
	
	      <p class="pb-3 mb-0 small lh-sm border-bottom">
	        <strong class="d-block text-gray-dark">Email</strong>
	        <strong><%=dto.getEmail() %></strong>
	      </p>
	    </div>
	    
	    <div class="d-flex text-muted pt-3">
	      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#007bff"/><text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text></svg>
	      <p class="pb-3 mb-0 small lh-sm border-bottom">
	        <strong class="d-block text-gray-dark">가입일</strong>
	        <strong><%=dto.getRegdate() %></strong>
	      </p>
	    </div>
	    
	    <div>
		    <small class="text-end mt-3">
		      <a href="my_update_form.jsp">회원정보 수정</a>
		    </small>
		    
		    <small class="text-end mt-3">
		      <a href="javascript:deleteConfirm()">회원 탈퇴</a>
		    </small>
	    </div>
	    
	  </div>
	 </main>
 
</div>
<script>
   function deleteConfirm(){
      const isDelete=confirm("<%=id%> 님 탈퇴 하시겠습니까?");
      if(isDelete){
         location.href="my_delete.jsp";
      }
   }
</script>
</body>
</html>




