<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    
	  //요청과 함께 전달되는 쿠키 정보 얻어내기
	    Cookie[] cooks=request.getCookies();
	    //쿠키에서 읽어낸 아이디 비밀번호를 저장할 변수 
	    String savedId=null; //저장이 안되어있으면 null
	    String savedPwd=null;
	    if(cooks != null){
	       //반복문 돌면서 쿠키 객체를 하나씩 참조
	       for(Cookie tmp:cooks){
	          //쿠키의 키값을 읽어와서
	          String key=tmp.getName();
	          if(key.equals("savedId")){//저장된 아이디 값이라면 
	             savedId=tmp.getValue();
	          }else if(key.equals("savedPwd")){//저장된 비밀번호 값이라면
	             savedPwd=tmp.getValue();
	          }
	       }
	    }
    
	// GET 방식 파라미터 url 이라는 이름으로 전달되는 값이 있는지 읽어와 본다.
	String url=request.getParameter("url");
	//만일 넘어오는 값이 없다면
	if(url==null){
		//로그인 후에 index.jsp 페이지로 갈 수 있도록 절대 경로를 구성한다.
		String cPath=request.getContextPath();
		url=cPath+"/index.jsp";
	}
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
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
<link href="signin.css" rel="stylesheet">
</head>
<body class="text-center">
	<main class="form-signin">
        <form action="login.jsp" method="post">
          <input type="hidden" name="url" value="<%=url %>"/>
          <img class="mb-4" src="https://getbootstrap.com/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
          <h1 class="h3 mb-3 fw-normal">ShoesSell</h1>
          <%if(savedId == null){ %>
             <div class="form-floating">
                  <input type="text" name="id" class="form-control" id="id" placeholder="아이디 입력">
                  <label for="id">아이디</label>
             </div>
             <div class="form-floating">
                <input type="password" name="pwd" class="form-control" id="pwd" placeholder="비밀번호 입력">
                  <label for="pwd">비밀번호</label>
             </div>
             <div class="checkbox mb-3">
                 <label>
                    <input type="checkbox" name="isSave" value="yes"> 로그인 정보 저장
                  </label>
             </div>
          <%}else{ %>
             <div class="form-floating">
                  <input value="<%=savedId %>" type="text" name="id" class="form-control" id="id" placeholder="아이디 입력">
                  <label for="id">아이디</label>
            </div>
             <div class="form-floating">
                <input value="<%=savedPwd %>"  type="password" name="pwd" class="form-control" id="pwd" placeholder="비밀번호 입력">
                  <label for="pwd">비밀번호</label>
             </div>
             <div class="checkbox mb-3">
                 <label>
                    <input type="checkbox" name="isSave" value="yes" checked> 로그인 정보 저장
                  </label>
             </div>
          <%} %>  
          <button class="w-100 btn btn-lg btn btn-outline-dark" type="submit">로그인</button>
        </form>
   </main>
</body>
</html>