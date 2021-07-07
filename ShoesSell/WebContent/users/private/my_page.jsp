<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //1. session 영역에서 로그인된 아이디를 읽어온다.
   String id=(String)session.getAttribute("id");
   //2. UsersDao 객체를 이용해서 가입된 정보를 얻어온다.
   UsersDto dto=UsersDao.getInstance().getData(id);
   String currentPwd=dto.getPwd();
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
    #link{
    	decoration : none;
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
	        <strong><a href="javascript:" data-bs-toggle="modal" data-bs-target="#changePwdModal">수정하기</a></strong>
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
	    
   	   <div id="link" class="btn-toolbar mx-auto" role="toolbar" >
			  <div class=" btn-group me-2" role="group" >
			    <a href="my_update_form.jsp" class="w-100 btn btn-outline-primary">회원정보 수정</a>
			  </div>
			  <div class="btn-group me-2" role="group" >
			   <a href="javascript:deleteConfirm()" class="w-100 btn btn-outline-danger">회원 탈퇴</a>
			  </div>
		</div>	
	    
	  </div>
	 </main>
 
</div>

<!-- 패스워드 변경에 대한 Modal -->
   <div class="modal fade" id="changePwdModal" tabindex="-1" aria-labelledby="changePwdModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
                 <h5 class="modal-title" id="changePwdModalLabel">Password Change</h5>
                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
             </div>
              <div class="modal-body">
                 <form action="my_ajax_pwd_update.jsp" method="post" id="changePwdForm">
                    <div class="form-group">
                       <label class="form-label" for="pwd">현재 비밀번호</label>
                       <input class="form-control" type="password" name="pwd" id="pwd"/>
                       <small class="form-text text-muted" >현재 비밀번호를 입력해주세요.</small>
	              	   <div class="invalid-feedback">현재 비밀번호와 다릅니다.</div>
                    </div>
                    <br />
                    <div class="form-group">
                       <label class="form-label" for="newPwd">변경 비밀번호</label>
                       <input class="form-control" type="password" name="newPwd" id="newPwd"/>
		              <small class="form-text text-muted" >5글자~10글자 이내로 입력하세요.</small>
		              <div class="invalid-feedback">형식에 맞지 않는 비밀번호입니다.</div>
                    </div>
                    <br />
                    <div class="form-group">
                       <label class="form-label" for="newPwd2">변경 비밀번호 확인</label>
                       <input class="form-control" type="password" name="newPwd2" id="newPwd2"/>
                       <small class="form-text text-muted" >동일한 비밀번호를 다시 한번 입력해주세요.</small>
	                   <div class="invalid-feedback">새로운 비밀번호와 일치하지 않습니다.</div>
                    </div>
                 </form>
              </div>
              <div class="modal-footer">
                 <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                 <button id="changePwdBtn" type="reset" class="btn btn-primary" data-bs-dismiss="modal">변경하기</button>
             </div>
           </div>
        </div>
   </div>  

<script src="../../js/gura_util.js"></script>

<script>
   function deleteConfirm(){
      const isDelete=confirm("<%=id%> 님 탈퇴 하시겠습니까?");
      if(isDelete){
         location.href="my_delete.jsp";
      }
   }
   
   let currentPwd = "<%=currentPwd%>";
   
   //현재 비밀번호 유효성 검사
   function checkPwd(){
		  document.querySelector("#pwd").classList.remove("is-valid");
		  document.querySelector("#pwd").classList.remove("is-invalid");
	   
	      const pwd=document.querySelector("#pwd").value;
	      	      
	      if(pwd != currentPwd ){      
		         document.querySelector("#pwd").classList.add("is-invalid");
		      }else{
		         document.querySelector("#pwd").classList.add("is-valid");
		      }
	   }
	   
	   //비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
	   document.querySelector("#pwd").addEventListener("input", checkPwd);
	   
	   //새로운 비밀번호 확인하는 함수 
	   function newcheckPwd(){
		  document.querySelector("#newPwd").classList.remove("is-valid");
		  document.querySelector("#newPwd").classList.remove("is-invalid");
		  document.querySelector("#newPwd2").classList.remove("is-valid");
		  document.querySelector("#newPwd2").classList.remove("is-invalid");
		   
	      const pwd=document.querySelector("#newPwd").value;
	      const pwd2=document.querySelector("#newPwd2").value;
	      
	      // 최소5글자 최대 10글자인지를 검증할 정규표현식
	      const reg_pwd=/^.{5,10}$/;
	      if(!reg_pwd.test(pwd)){
	         document.querySelector("#newPwd").classList.add("is-invalid");
	         return; //함수를 여기서 종료
	      }else{
	          document.querySelector("#newPwd").classList.add("is-valid");
	      }
	      
	      if(pwd != pwd2){//비밀번호와 비밀번호 확인란이 다르면      
		         document.querySelector("#newPwd2").classList.add("is-invalid");
		      }else{
		         document.querySelector("#newPwd2").classList.add("is-valid");
		      }
	   }
	   
	   //새 비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
	   document.querySelector("#newPwd").addEventListener("input", newcheckPwd);
	   document.querySelector("#newPwd2").addEventListener("input", newcheckPwd);
	   
   
   //비밀번호 변경 버튼을 눌렀을때 호출되는 함수 등록 
   document.querySelector("#changePwdBtn").addEventListener("click", function(){
      //ajax 제출할 폼의 참조값 얻어오기
      let changePwdForm=document.querySelector("#changePwdForm");
      // gura_util.js 에 있는 함수를 이용해서 ajax 전송한다. 
      ajaxFormPromise(changePwdForm)
      .then(function(response){
         return response.json();
      })
      .then(function(data){
    	  console.log(data);
         if(data.isValid){
            alert("수정에 성공하셨습니다. 로그인 화면으로 이동합니다.");
            location.href="<%=request.getContextPath()%>/users/login_form.jsp";
         }else{
            alert("수정 실패!");
         }
      });
   });
</script>
</body>
</html>




