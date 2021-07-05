<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //로그인 된 아이디 읽어오기 
   String id=(String)session.getAttribute("id");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
   .inner{
      max-width:1100px!important;
      margin:0 auto!important;
      box-sizing:border-box!important;
      position:relative!important;
   }
   #main_img{
      position:absolute;
      width:100%;
      height:450px;
   }
   
</style>
</head>
<body>

<jsp:include page="include/navbar.jsp"></jsp:include>
   <div class="inner">
      <div class="main_banner">
         <img id="main_img" src="images/main_img.jpg" alt="메인이미지" />
      </div>
      <!-- main_banner 끝 -->
      
   </div>

</body>
</html>