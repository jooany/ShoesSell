<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	// thisPage 라는 파라미터명으로 전달되는 문자열을 얻어와 본다. 
    	// null or "file" or "cafe"
    	String thisPage=request.getParameter("thisPage");
    	// thisPage 가 null 이면 index.jsp 페이지에 포함된 것이다. 
    	//System.out.println(thisPage);
    	//만일 null 이면 
    	if(thisPage==null){
    		//빈 문자열을 대입한다. (NullPointerException 방지용)
    		thisPage="";
    	}
    	//로그인 된 아이디 읽어오기 
    	String id=(String)session.getAttribute("id");
    	UsersDto dto=new UsersDto();
    	dto=UsersDao.getInstance().getData(id);
    %>
    <div class="inner">
		<nav class="navbar navbar-light bg-light navbar-expand-sm">
			<div class="container-fluid">
			    <a class="navbar-brand" href="<%=request.getContextPath() %>/">
			      	<img src="https://getbootstrap.com/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="30" height="24" class="d-inline-block align-text-top">
			      	ShoesSell
			    </a>
			    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
			    	data-bs-target="#navbarNav">
	   				<span class="navbar-toggler-icon"></span>
	    		</button>
	    		<div class="collapse navbar-collapse" id="navbarNav">
	      			<ul class="navbar-nav me-auto">
	      				<li class="nav-item">
		          			<a class="nav-link <%=thisPage.equals("share") ? "active" : "" %>" href="<%=request.getContextPath() %>/share/list.jsp">news</a>
		        		</li>
		        		<li class="nav-item">
		          			<a class="nav-link <%=thisPage.equals("free") ? "active" : "" %>" href="<%=request.getContextPath() %>/free/list.jsp">커뮤니티</a>
		        		</li>
						<li class="nav-item">
		          			<a class="nav-link <%=thisPage.equals("resell") ? "active" : "" %>" href="<%=request.getContextPath() %>/resell/list.jsp?kind=buy">마켓</a>
		        		</li>
		        		<li class="nav-item">
		          			<a class="nav-link <%=thisPage.equals("resell") ? "active" : "" %>" href="<%=request.getContextPath() %>/feed/list.jsp">피드</a>
		        		</li>
	      			</ul>
	      			<%if(id==null){ %>
	      				<a class="btn btn-outline-primary btn-sm me-2 " href="${pageContext.request.contextPath}/users/signup_form.jsp">회원가입</a>
	      				<a class="btn btn-outline-success btn-sm me-2 " href="${pageContext.request.contextPath}/users/login_form.jsp">로그인</a>
	      			<%}else{ %>
	      				<span class="navbar-text me-2">
	      		
	      					<a style="text-decoration:none;" href="${pageContext.request.contextPath}/users/private/my_page.jsp">
	      						<img style="width:25px; height:25px; border-radius:50%;" class="profile_img" src="<%=request.getContextPath()%><%=dto.getProfile()%>"/>
	      						<%=id %>
	      					</a>
	      				</span>
	      				<a class="btn btn-outline-danger btn-sm me-2" href="${pageContext.request.contextPath}/users/logout.jsp">로그아웃</a>
	      			<%} %>
	    		</div>
			</div>
		</nav>
	</div>
	
	
	
	
	
	
	
	
	