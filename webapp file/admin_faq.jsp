<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="app" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	Date today = new Date();
	request.setAttribute("today", today);
%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./css/basic.css">
<link rel="stylesheet" type="text/css" href="./css/login.css?v=1">
<link rel="stylesheet" type="text/css" href="./css/main.css">
<link rel="stylesheet" href="./css/faq.css?v=33">
<link rel="icon" href="./img/logo.png" sizes="128x128">
<link rel="icon" href="./img/logo.png" sizes="64x64">
<link rel="icon" href="./img/logo.png" sizes="32x32">
<link rel="icon" href="./img/logo.png" sizes="16x16">
<script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
<title>항공공사 및 번호 등록</title>
<script>
</script>
</head>
<body>
    <%@ include file="./admin_header.jsp" %>
    <%@ include file="./admin_menu.jsp" %>
<!-- FAQ 리스트 시작 -->
<main class="maincss" id="vue">
<section class="page_section">
<p>FAQ 관리페이지</p>
<div class="listbody">
    <div class="procho">
       <section class="search_part">
        <ol>
        <li>FAQ 모든 내용 검색</li>
        <li>
        <form id="f">
        <input type="text" name="search" class="search_input" v-model="sch">
        <input type="submit" value="검색" class="datebtn" @click="search">
        </form>
        </li>        
        <li></li>
        <li></li> 
        </ol>
       </section> 
       <section class="data_listsview2">
       <ul>
        <li>QA</li>
        <li>질문/답변</li>
        <li>글쓴이</li>
        <li>등록일</li>
        <li>삭제</li>
       </ul>
          
<!-- FAQ 샘플 HTML 코드 시작 -->           
     <span>
       <!-- 반복 구간 -->
       <app:forEach var="li" items="${list}">
       <ul>
        <li>Q</li>
        <li style="text-align: left; justify-content: flex-start;" @click="go_modify('${li.getFidx()}')">${li.getFtitle()}</li>
        <li>${li.getAname()}</li>
        <li>${li.getFdate().substring(0,10)}</li>
        <li>
        <input type="button" value="삭제" class="delbtn" @click="go_del(${li.getFidx()})">
        </li>
       </ul>
       </app:forEach>
     </span>
     
<!-- FAQ 샘플 HTML 코드 끝 -->    
     <app:if test="${list.size() == 0}">      
       <ul class="nodatas">
        <li>등록된 FAQ 내용 없습니다.</li>
       </ul>
       </app:if>
       <span class="notice_btns">
       <input type="button" value="FAQ 등록" class="meno_btn2" onclick="location.href='./admin_faq_write.do'"></span>
       <aside>
        <div class="subpage_view3">
            <ul class="pageing">
                <li  @click="lleft"><img src="./ico/double_left.svg"></li>
                <li @click="left"><img src="./ico/left.svg"></li>
                <%
            	int ea = (int)request.getAttribute("ea");
	        	int pg = (int)Math.ceil(ea / 10f);
	        	int ww = 1;
	        	while(ww <= pg){
	        		request.setAttribute("pgg", ww);
        		%>
                <li onclick="location.href='./admin_faq.do?page=<%= ww%>'" ><%=ww %></li>
                 <% ww++; } %>
                <li @click="right(<%= pg %>)"><img src="./ico/right.svg"></li>
                <li @click="rright(<%= pg %>)"><img src="./ico/double_right.svg"></li>
            </ul>
        </div>
       </aside>
       </section>
    </div>
</div> 
</section>
</main>
<!-- FAQ 리스트 끝 -->
   <%@ include file="./admin_footer.jsp" %>
</body>
<script>
	var sch = "${search}"
</script>
<script src="./js/admin_faq.js?v=${today}"></script>
</html>