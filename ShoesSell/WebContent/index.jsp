<%@page import="test.resell.dao.ResellDao"%>
<%@page import="test.share.dao.ShareDao"%>
<%@page import="test.share.dto.ShareDto"%>
<%@page import="test.resell.dto.ResellDto"%>
<%@page import="test.free.dao.FreeDao"%>
<%@page import="java.util.List"%>
<%@page import="test.free.dto.FreeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //로그인 된 아이디 읽어오기 
    String id=(String)session.getAttribute("id");

	//한 페이지에 몇개씩 표시할 것인지
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT1=5;
	final int PAGE_DISPLAY_COUNT1=3;
	
	final int PAGE_ROW_COUNT2=5;
	final int PAGE_DISPLAY_COUNT2=3;
	
	final int PAGE_ROW_COUNT3=5;
	final int PAGE_DISPLAY_COUNT3=3;
   
   //보여줄 페이지의 번호를 일단 1이라고 초기값 지정
   int pageNum1=1;
   int pageNum2=1;
   int pageNum3=1;
  
   //페이지 번호가 파라미터로 전달되는지 읽어와 본다.
   String strPageNum1=request.getParameter("sharePageNum");
   String strPageNum2=request.getParameter("freePageNum");
   String strPageNum3=request.getParameter("resellPageNum");
   
   //만일 페이지 번호가 파라미터로 넘어 온다면
         //숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
   if(strPageNum1 != null){
      pageNum1=Integer.parseInt(strPageNum1);
   }
   if(strPageNum2 != null){
	      pageNum2=Integer.parseInt(strPageNum2);
	   }
   if(strPageNum3 != null){
      pageNum3=Integer.parseInt(strPageNum3);
   }
  
   //보여줄 페이지의 시작 ROWNUM
   int startRowNum1=1+(pageNum1-1)*PAGE_ROW_COUNT1;
   int startRowNum2=1+(pageNum2-1)*PAGE_ROW_COUNT2;
   int startRowNum3=1+(pageNum3-1)*PAGE_ROW_COUNT3;
   
   //보여줄 페이지의 끝 ROWNUM
   int endRowNum1=pageNum1*PAGE_ROW_COUNT1;
   int endRowNum2=pageNum2*PAGE_ROW_COUNT2;
   int endRowNum3=pageNum3*PAGE_ROW_COUNT3;
   
   //shareDto 객체에 startRowNum 과 endRowNum 을 담는다.
   ShareDto dto1=new ShareDto();
   dto1.setStartRowNum(startRowNum1);
   dto1.setEndRowNum(endRowNum1);
   //FreeDto 객체에 startRowNum 과 endRowNum 을 담는다.
   FreeDto dto2=new FreeDto();
   dto2.setStartRowNum(startRowNum2);
   dto2.setEndRowNum(endRowNum2);
   //FreeDto 객체에 startRowNum 과 endRowNum 을 담는다.
   ResellDto dto3=new ResellDto();
   dto3.setStartRowNum(startRowNum3);
   dto3.setEndRowNum(endRowNum3);
   
   //ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
   List<ShareDto> shareList=null;
   List<FreeDto> freeList=null;
   List<ResellDto> resellList=null;
   //전체 row 의 갯수를 담을 지역변수를 미리 만든다.
   int totalRow1=0;
   int totalRow2=0;
   int totalRow3=0;

   // 메소드를 이용해서 파일 목록을 얻어온다. 
   shareList=ShareDao.getInstance().getList(dto1);
   freeList=FreeDao.getInstance().getListMain(dto2);
   resellList=ResellDao.getInstance().getListMain(dto3);
   // 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
   totalRow1=ShareDao.getInstance().getCount();
   totalRow2=FreeDao.getInstance().getCount();
   totalRow3=ResellDao.getInstance().getCountMain();
     
   //하단 시작 페이지 번호 
   int startPageNum1 = 1 + ((pageNum1-1)/PAGE_DISPLAY_COUNT1)*PAGE_DISPLAY_COUNT1;
   int startPageNum2 = 1 + ((pageNum2-1)/PAGE_DISPLAY_COUNT2)*PAGE_DISPLAY_COUNT2;
   int startPageNum3 = 1 + ((pageNum3-1)/PAGE_DISPLAY_COUNT3)*PAGE_DISPLAY_COUNT3;
   //하단 끝 페이지 번호
   int endPageNum1=startPageNum1+PAGE_DISPLAY_COUNT1-1;
   int endPageNum2=startPageNum2+PAGE_DISPLAY_COUNT2-1;
   int endPageNum3=startPageNum3+PAGE_DISPLAY_COUNT3-1;
   
   //전체 페이지의 갯수
   int totalPageCount1=(int)Math.ceil(totalRow1/(double)PAGE_ROW_COUNT1);
   int totalPageCount2=(int)Math.ceil(totalRow2/(double)PAGE_ROW_COUNT2);
   int totalPageCount3=(int)Math.ceil(totalRow3/(double)PAGE_ROW_COUNT3);
   //끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
   if(endPageNum1 > totalPageCount1){
      endPageNum1=totalPageCount1; //보정해 준다.
   }
   if(endPageNum2 > totalPageCount2){
	  endPageNum2=totalPageCount2; //보정해 준다.
   }   
   if(endPageNum3 > totalPageCount3){
	  endPageNum3=totalPageCount3; //보정해 준다.
   }   


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
   .main_banner{
        position:relative;
        width:1100px;
        height:450px;
   }
   #main_img{
      position:absolute;
      width:1100px;
      height:450px;
   }
   .main_list{
        width:1100px;
        display:flex;
        margin-top:30px;
        justify-content:space-between;
   }
   .main_list a{
   		text-decoration:none;
   		color:black;
   }
   .main_list>div{
        width:350px;
        height:450px;
        box-sizing:border-box!important;
   }
   .share_table>a{
   		display:box;
   		color:white;
   }
   .free_table>a{
   		display:box;
   		color:white;
   }
   .resell_table>a{
   		display:box;
   		color:white;
   }
   .box_name{
   		width:350px;
   		height:50px;
   		background-color:#1a1a1a;
   		position:relative;
   		text-align:center;
   		line-height:50px;
   }

   .box_shadow{
   	    box-shadow: 0 0 3px rgb(0,0,0,.35);
   }
   
   .table_td{
		width:220px;
		height:20px;
   }
   .page-ui{
   		display:flex;
   		justify-content:center;
   }
   .resell_img{
   		width:75px;
   		height:50px;
   }
   td{
   		height:66.5px;
   		line-height:66.5px;
   		padding:0px!important;
   } 
   td:nth-child(1){
   		width:30px;
   		text-align:center;
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
      
      <div class="main_list">
         <div class="share_table box_shadow">
         	<a href="share/list.jsp"><div class="box_name">news</div></a>
            <table class="table table-striped">
               <tbody>
               <%for(ShareDto tmp:shareList){%>
                  <tr>
                     <td><%=tmp.getRowNum() %></td>
                     <a href="share/detail.jsp?num=<%=tmp.getNum()%>">
                     <td>
                        <a href="share/detail.jsp?num=<%=tmp.getNum()%>">
                        	<div class="table_td">
                        		
                        			<div class="content"><%=tmp.getTitle() %></div>
                        		
                        	</div>
                        </a>
                     </td>
                  </tr>
               <%} %>
               </tbody>
            </table>
            <div class="page-ui clearfix">
               <ul class="pagination"> 
				  <%if(startPageNum1 != 1){ %>
					 <li class="page-item">
					 	<a class="page-link" href="index.jsp?sharePageNum=<%=startPageNum1-1%>&freePageNum=<%=pageNum2%>&resellPageNum=<%=pageNum3%>">Prev</a>
					 </li>	
				  <%} %>                         
                  <%for(int i=startPageNum1; i<=endPageNum1 ; i++){ %>
                     <li class="page-item">
                        <%if(pageNum1 == i){ %>
                           <a class="page-link" class="active" href="index.jsp?sharePageNum=<%=i%>&freePageNum=<%=pageNum2%>&resellPageNum=<%=pageNum3%>"><%=i %></a>
                        <%}else{ %>
                           <a class="page-link" href="index.jsp?sharePageNum=<%=i%>&freePageNum=<%=pageNum2%>&resellPageNum=<%=pageNum3%>"><%=i %></a>
                        <%} %>
                     </li>   
                  <%} %>
				  <%if(endPageNum1 < totalPageCount1){ %>
					 <li class="page-item">
					 	<a class="page-link" href="index.jsp?sharePageNum=<%=endPageNum1+1%>&freePageNum=<%=pageNum2 %>&resellPageNum=<%=pageNum3%>">Next</a>
					 </li>	
				  <%} %>                  
               </ul>
               
            </div>          
         </div>
         <div class="free_table box_shadow">
         	<a href="free/list.jsp"><div class="box_name">커뮤니티</div></a>
            <table class="table table-striped">
               <tbody>
               <%for(FreeDto tmp:freeList){%>
                  <tr>
                     <td><%=tmp.getRowNum() %></td>
                     <td>
                        <a href="free/detail.jsp?num=<%=tmp.getNum()%>">
                        	<div class="table_td">
                        		<div class="content"><%=tmp.getTitle() %></div>
                        	</div>
                        </a>
                     </td>
                  </tr>
               <%} %>
               </tbody>
            </table>
            <div class="page-ui clearfix">
               <ul class="pagination"> 
				  <%if(startPageNum2 != 1){ %>
					 <li class="page-item">
					 	<a class="page-link" href="index.jsp?sharePageNum=<%=pageNum1%>&freePageNum=<%=startPageNum2-1%>&resellPageNum=<%=pageNum3%>">Prev</a>
					 </li>	
				  <%} %>                         
                  <%for(int i2=startPageNum2; i2<=endPageNum2 ; i2++){ %>
                     <li class="page-item">
                        <%if(pageNum2 == i2){ %>
                           <a class="active page-link" href="index.jsp?sharePageNum=<%=pageNum1%>&freePageNum=<%=i2%>&resellPageNum=<%=pageNum3%>"><%=i2 %></a>
                        <%}else{ %>
                           <a class="page-link" href="index.jsp?sharePageNum=<%=pageNum1%>&freePageNum=<%=i2%>&resellPageNum=<%=pageNum3%>"><%=i2 %></a>
                        <%} %>
                     </li>   
                  <%} %>
				  <%if(endPageNum2 < totalPageCount2){ %>
					 <li class="page-item">
					 	<a class="page-link" href="index.jsp?sharePageNum=<%=pageNum1%>&freePageNum=<%=endPageNum2+1 %>&resellPageNum=<%=pageNum3%>">Next</a>
					 </li>	
				  <%} %>                  
               </ul>
            </div>            
         </div>
         <div class="resell_table box_shadow">
         	<a href="resell/list.jsp"><div class="box_name">마켓</div></a>
            <table class="table table-striped">
               <tbody>
               <%for(ResellDto tmp:resellList){%>
                  <tr>
                     <td><%=tmp.getRowNum() %></td>
                     <td>
                        <a href="resell/detail.jsp?num=<%=tmp.getNum()%>">
                        	<div class="table_td">
                        		<div class="content"><%=tmp.getTitle() %></div>
                        	</div>
                        </a>
                     </td>
                     <td>
                     	<img class="resell_img" src="${pageContext.request.contextPath }<%=tmp.getImagePath() %>" />
                     </td>
                  </tr>
               <%} %>
               </tbody>
            </table>
            <div class="page-ui clearfix">
               <ul class="pagination"> 
				  <%if(startPageNum3 != 1){ %>
					 <li class="page-item">
					 	<a class="page-link" href="index.jsp?sharePageNum=<%=pageNum1%>&freePageNum=<%=pageNum2%>&resellPageNum=<%=startPageNum3-1%>">Prev</a>
					 </li>	
				  <%} %>                         
                  <%for(int i3=startPageNum3; i3<=endPageNum3 ; i3++){ %>
                     <li class="page-item">
                        <%if(pageNum3 == i3){ %>
                           <a class="active page-link" href="index.jsp?sharePageNum=<%=pageNum1%>&freePageNum=<%=pageNum2%>&resellPageNum=<%=i3%>"><%=i3 %></a>
                        <%}else{ %>
                           <a class="page-link" href="index.jsp?sharePageNum=<%=pageNum1%>&freePageNum=<%=pageNum2%>&resellPageNum=<%=i3%>"><%=i3 %></a>
                        <%} %>
                     </li>   
                  <%} %>
				  <%if(endPageNum3 < totalPageCount3){ %>
					 <li class="page-item">
					 	<a class="page-link" href="index.jsp?sharePageNum=<%=pageNum1%>&freePageNum=<%=pageNum2%>&resellPageNum=<%=endPageNum3+1%>">Next</a>
					 </li>	
				  <%} %>                  
               </ul>
            </div>         
         </div>
         
      </div>
      <!--main_list 끝 -->
   </div>
   
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
   <script text="javascript/text">
    $(document).ready(function(){
        $('.table_td').each(function(){
            var content = $(this).children('.content');
            var content_txt = content.text();
            var content_txt_short = content_txt.substring(0,13)+"...";
            
            if(content_txt.length >= 13){
                content.html(content_txt_short)               
            }
        });
    });
  </script>
</body>
</html>