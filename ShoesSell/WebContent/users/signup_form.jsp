<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<!-- Bootstrap core CSS -->

<style>
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
<!-- Custom styles for this template -->
<link href="form-validation.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>

<div class="container">
  <main>
  
    <div class="py-3 text-center">
      <img class="d-block mx-auto mb-4" src="https://getbootstrap.com/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
      <h1>회원가입</h1>
    </div>
    
      <div>
      
        <form action="ajax_signup.jsp" method="post" id="signupForm">
        
          <div class="d-grid gap-3 container max-auto">
          
            <div>
              <label for="id" class="form-label">아이디</label>
              <input type="text" class="form-control" name="id" id="id"/>
              <small class="form-text text-muted">영문자 소문자로 시작하고 5글자~10글자 이내로 입력하세요.</small>
              <div class="invalid-feedback">사용할 수 없는 아이디 입니다.</div>
            </div>
            
			  <div class="row g-3"> 
	            <div class="col-sm-6">
	              <label for="pwd" class="form-label">비밀번호</label>
	              <input type="password" class="form-control" id="pwd" name="pwd" />
	              <small class="form-text text-muted" >5글자~10글자 이내로 입력하세요.</small>
	              <div class="invalid-feedback">형식에 맞지 않는 비밀번호입니다.</div>
	            </div>
	          
	            <div class="col-sm-6">
	              <label for="lastName" class="form-label">비밀번호 확인</label>
	              <input type="password" class="form-control" id="pwd2" name="pwd2">
	              <small class="form-text text-muted" >동일한 비밀번호를 다시 한번 입력해주세요.</small>
	              <div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
	            </div>
	          </div>  

            <div class="col-12">
              <label for="email" class="form-label">Email</label>
              <input type="text" class="form-control" id="email" name="email">
              <div class="invalid-feedback">이메일 형식을 확인하세요.</div>
              <small class="form-text text-muted" >@을 포함하여 작성해주세요.</small>
            </div>
            
			<div class="btn-toolbar mx-auto" role="toolbar" >
			  <div class=" btn-group me-2" role="group" >
			    <button id="signupBtn" type="button" class="w-100 btn btn-outline-primary">회원가입</button>
			  </div>
			  <div class="btn-group me-2" role="group" >
			    <button id="resetBtn" type="reset" class="w-100 btn btn-outline-danger">초기화</button>
			  </div>
			</div>			
          
          </div>
          
        </form>
      </div>
  </main>
</div>


<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>

<script>
   //아이디, 비밀번호, 이메일의 유효성 여부를 관리한 변수 만들고 초기값 대입
   let isIdValid=false;
   let isPwdValid=false;
   let isEmailValid=false;

   //아이디를 입력했을때(input) 실행할 함수 등록 
   document.querySelector("#id").addEventListener("input", function(){
      //일단 is-invalid is-valid 클래스를 제거한다.
      document.querySelector("#id").classList.remove("is-valid");
      document.querySelector("#id").classList.remove("is-invalid");
      
      //1. 입력한 아이디 value 값 읽어오기  
      let inputId=this.value;
      //입력한 아이디를 검증할 정규 표현식
      const reg_id=/^[a-z].{4,9}$/;
      //만일 입력한 아이디가 정규표현식과 매칭되지 않는다면
      if(!reg_id.test(inputId)){
         isIdValid=false; //아이디가 매칭되지 않는다고 표시하고 
         // is-invalid 클래스를 추가한다. 
         document.querySelector("#id").classList.add("is-invalid");
         return; //함수를 여기서 끝낸다 (ajax 전송 되지 않도록)
      }
      
      //2. util 에 있는 함수를 이용해서 ajax 요청하기
      ajaxPromise("ajax_checkid.jsp", "get", "inputId="+inputId)
      .then(function(response){
         return response.json();
      })
      .then(function(data){
         console.log(data);
         //data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
         if(data.isExist){//만일 존재한다면
            //사용할수 없는 아이디라는 피드백을 보이게 한다. 
            isIdValid=false;
            // is-invalid 클래스를 추가한다. 
            document.querySelector("#id").classList.add("is-invalid");
         }else{
            isIdValid=true;
            document.querySelector("#id").classList.add("is-valid");
         }
      });
   });
   
   
   //비밀 번호 형식을 확인하는 함수 
   function checkPwd(){
	  document.querySelector("#pwd").classList.remove("is-valid");
	  document.querySelector("#pwd").classList.remove("is-invalid");
	  document.querySelector("#pwd2").classList.remove("is-valid");
	  document.querySelector("#pwd2").classList.remove("is-invalid");
	   
      const pwd=document.querySelector("#pwd").value;
      const pwd2=document.querySelector("#pwd2").value;
      
      // 최소5글자 최대 10글자인지를 검증할 정규표현식
      const reg_pwd=/^.{5,10}$/;
      if(!reg_pwd.test(pwd)){
         isPwdValid=false;
         document.querySelector("#pwd").classList.add("is-invalid");
         return; //함수를 여기서 종료
      }else{
    	  isPwdValid=true;
          document.querySelector("#pwd").classList.add("is-valid");
      }
      
      if(pwd != pwd2){//비밀번호와 비밀번호 확인란이 다르면      
	         isPwdValid=false;
	         document.querySelector("#pwd2").classList.add("is-invalid");
	         return;
	      }else{
	         isPwdValid=true;
	         document.querySelector("#pwd2").classList.add("is-valid");
	      }
   }
   
   
   //비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
   document.querySelector("#pwd").addEventListener("input", checkPwd);
   document.querySelector("#pwd2").addEventListener("input", checkPwd);
   
   //이메일을 입력했을때 실행할 함수 등록
   document.querySelector("#email").addEventListener("input", function(){
	   document.querySelector("#email").classList.remove("is-valid");
	   document.querySelector("#email").classList.remove("is-invalid");
	   
      //1. 입력한 이메일을 읽어와서
      const inputEmail=this.value;
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
   });
   
  
   
   document.querySelector("#signupBtn").addEventListener("click", function(e){
	      /*
	         입력한 아이디, 비밀번호, 이메일의 유효성 여부를 확인해서 하나라도 유효 하지 않으면
	         e.preventDefault(); 
	         가 수행 되도록 해서 폼의 제출을 막아야 한다. 
	      */
	      //폼 전체의 유효성 여부 알아내기 
	      let isFormValid = isIdValid && isPwdValid && isEmailValid;
	         
	      if(!isFormValid){//폼이 유효하지 않으면
	         //폼 전송 막기 
	         e.preventDefault();
	      }else{
	    	  let signupForm=document.querySelector("#signupForm");
		      // gura_util.js 에 있는 함수를 이용해서 ajax 전송한다. 
		      ajaxFormPromise(signupForm)
		      .then(function(response){
		         return response.json();
		      })
		      .then(function(sign){
		    	  console.log(sign);
		         if(sign.isSuccess){
		            alert("회원가입에 성공하였습니다. 로그인 화면으로 이동합니다.");
		            location.href="<%=request.getContextPath()%>/users/login_form.jsp";
		         }
		      });
	      }
	   });
   
   document.querySelector("#resetBtn").addEventListener("click",function(){
	   document.querySelector("#id").classList.remove("is-valid");
	   document.querySelector("#id").classList.remove("is-invalid");
	   document.querySelector("#pwd").classList.remove("is-valid");
	   document.querySelector("#pwd").classList.remove("is-invalid");
	   document.querySelector("#pwd2").classList.remove("is-valid");
	   document.querySelector("#pwd2").classList.remove("is-invalid");
	   document.querySelector("#email").classList.remove("is-valid");
	   document.querySelector("#email").classList.remove("is-invalid");
   });
</script>
</body>
</html>




