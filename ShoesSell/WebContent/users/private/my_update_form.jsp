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
<style>
   #profileImage{ /* 프로필 이미지를 작은 원형으로 만든다 */
      width: 50px;
      height: 50px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
  #imageForm{
  	display: none;
  }
</style>
</head>
<body>
	<div class="container">
	   <h1> 정보 수정 폼 입니다.</h1>
	   <table>
	   	  <tr>
	         <th><label for="id">아이디</label></th>
	         <td><input type="text" id="id" value="<%=id %>" disabled/></td>
	      </tr>
	      
	      <tr>
	         <th>프로필 이미지&nbsp</th>
	         <td>
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
	   		 </td>
	      </tr>
	    <form action="my_update.jsp" method="post">
	   	  	<input type="hidden" name="profile" value="<%=dto.getProfile()==null ? "empty" : dto.getProfile() %>"/> 
	   	  <tr>
	         <th><label for="email">이메일</label></th>
	         <td><input type="text" name="email" id="email" value="<%=dto.getEmail()%>"/></td>	
	      </tr>
	      <tr>
	      	<th><button type="submit">수정 반영</button></th>
	      </tr> 
	   </form>
	</table>
	<form action="my_ajax_profile_upload.jsp" method="post" id="imageForm" enctype="multipart/form-data">
	      <input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif"/>
	</form>
	</div>
<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>

<script>

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
