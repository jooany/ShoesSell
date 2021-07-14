<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //session 영역에 저장된 아이디를 이용해서 
   String id=(String)session.getAttribute("id");
   //개인정보를 불러와서
   UsersDto dto=UsersDao.getInstance().getData(id);
   //개인정보 수정폼에 출력해 준다. 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
   #profileImage{ /* 프로필 이미지를 작은 원형으로 만든다 */
      width: 150px;
      height: 150px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
  #imageForm{
  	display: none;
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
	      <h1 class="h6 mb-0 text-white lh-1">MyUpdate </h1>
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
	      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#6f42c1"/><text x="50%" y="50%" fill="#6f42c1" dy=".3em">32x32</text></svg>
	
	      <p class="pb-3 mb-0 small lh-sm border-bottom">
	        <strong class="d-block text-gray-dark">프로필 사진</strong><br>
	        <a id="profileLink" href="javascript:">
	      	 <%if(dto.getProfile()==null){ %>
		         <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
		              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
		              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
		         </svg>
	      	 <%}else{ %>
		         <img id="profileImage" 
		            src="<%=request.getContextPath() %><%=dto.getProfile() %>" />
	      	 <%} %>
	   		 </a>
	   		 <strong>이미지 변경을 위해서는 사진을 클릭해주세요.</strong>
	      </p>
	    </div>
	    
	  <form action="my_ajax_update.jsp" method="post" id="updateForm">  
	    <input type="hidden" name="profile" value="<%=dto.getProfile()==null ? "empty" : dto.getProfile() %>"/> 
	    
	    <div class="d-flex text-muted pt-3">
	      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#e83e8c"/><text x="50%" y="50%" fill="#e83e8c" dy=".3em">32x32</text></svg>
	      <p class="pb-3 mb-0 small lh-sm border-bottom">
	        <strong class="d-block text-gray-dark"><label for="email" class="form-label">Email (@을 포함하여 작성해주세요.)</label></strong>
	        <strong><input type="text" class="form-control" name="email" id="email" value="<%=dto.getEmail() %>"/></strong>
	        <div class="invalid-feedback">이메일 형식을 확인하세요.</div>
	      </p>
	    </div>
	    
	 
	    <div class="d-flex text-muted pt-3">
	      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#007bff"/><text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text></svg>
	      <p class="pb-3 mb-0 small lh-sm">
	        <strong class="d-block text-gray-dark">가입일</strong>
	        <strong><%=dto.getRegdate() %></strong>
	      </p>
	    </div>
	    
		 <button id="updateBtn" type="button" class="btn btn-outline-dark">수정 반영</button>
		 <a href="my_page.jsp" class="btn btn-outline-dark">수정 취소</a>
		 
	     </form>
	  </div>
	 </main>
	
	<form action="my_ajax_profile_upload.jsp" method="post" id="imageForm" enctype="multipart/form-data">
	      <input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif"/>
	</form>
</div>

<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>

<script>

	let isEmailValid=false;
	
	const inputEmail=document.querySelector("#email").value;
    //2. 이메일을 검증할 정규 표현식 객체를 만들어서
    const reg_email=/@/;
    //3. 정규표현식 매칭 여부에 따라 분기하기
    if(reg_email.test(inputEmail)){//만일 매칭된다면
       //document.querySelector(".invalid-feedback3").style.display="none";
       isEmailValid=true;
	   document.querySelector("#email").classList.add("is-valid");
    }else{
       //document.querySelector(".invalid-feedback3").style.display="block";
       isEmailValid=false;
       document.querySelector("#email").classList.add("is-invalid");
    }
	
	
	//이메일을 입력했을때 실행할 함수 등록
	   document.querySelector("#email").addEventListener("input", function(){
		   document.querySelector("#email").classList.remove("is-valid");
		   document.querySelector("#email").classList.remove("is-invalid");
		   
	      //1. 입력한 이메일을 읽어와서
	      const reinputEmail=this.value;
	      //2. 이메일을 검증할 정규 표현식 객체를 만들어서
	      const reg_email=/@/;
	      //3. 정규표현식 매칭 여부에 따라 분기하기
	      if(reg_email.test(reinputEmail)){//만일 매칭된다면
	         //document.querySelector(".invalid-feedback3").style.display="none";
	         isEmailValid=true;
	  	     document.querySelector("#email").classList.add("is-valid");
	      }else{
	         //document.querySelector(".invalid-feedback3").style.display="block";
	         isEmailValid=false;
	         document.querySelector("#email").classList.add("is-invalid");
	      }
	   });
	
	   document.querySelector("#updateBtn").addEventListener("click", function(e){
			  
		   
		      let isFormValid = isEmailValid;
		         
		      if(!isFormValid){//폼이 유효하지 않으면
		         //폼 전송 막기 
		         e.preventDefault();
		      }else{
		    	  let signupForm=document.querySelector("#updateForm");
			      // gura_util.js 에 있는 함수를 이용해서 ajax 전송한다. 
			      ajaxFormPromise(signupForm)
			      .then(function(response){
			         return response.json();
			      })
			      .then(function(update){
			    	  console.log(update);
			         if(update.isSuccess){
			        	 alert("<%=id%>님 개인정보 수정을 완료했습니다.");
				         location.href="my_page.jsp";
			         }
			      });
		      }
		   });
	
	  
   //프로필 이미지 링크를 클릭하면 
   document.querySelector("#profileLink").addEventListener("click", function(){
      // input type="file" 을 강제 클릭 시킨다. 
      document.querySelector("#image").click();
   });
   
   //이미지를 선택했을때 실행할 함수 등록 
   document.querySelector("#image").addEventListener("change", function(){
      
      let form=document.querySelector("#imageForm");
      
      // gura_util.js 에 정의된 함수를 호출하면서 ajax 전송할 폼의 참조값을 전달하면 된다. 
      ajaxFormPromise(form)
      .then(function(response){
         return response.json();
      })
      .then(function(data){
         // data 는 {imagePath:"/upload/xxx.jpg"} 형식의 object 이다.
         console.log(data);
         let img=`<img id="profileImage" src="<%=request.getContextPath()%>\${data.imagePath}"/>`;
         // \${}을 바인딩 개념으로 쓰고 싶으면 ` ` (backtick) 안에서만 사용이 가능하다.
         // request.getContextPath()는 /Step05_Final
         document.querySelector("#profileLink").innerHTML=img;
         //위의 img를 그대로 innerHTML로 읽어달라고 부탁하면 웹브라우저에서 해석
         document.querySelector("input[name=profile]").value=data.imagePath;
         // inputname ="profile"요소의 value값으로 이미지 경로 넣어주기
      });
   });
      
</script>

</body>
</html>
