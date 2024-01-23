<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.notice_dao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="app" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<%
	Date today = new Date();
	request.setAttribute("today", today);
	

	/*
	ArrayList<String> all = (ArrayList<String>)request.getAttribute("allch");
	request.setAttribute("all", all);
	*/
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 등록 페이지</title>
    <link rel="stylesheet" type="text/css" href="./css/basic.css">
    <link rel="stylesheet" type="text/css" href="./css/login.css?v=1">
    <link rel="stylesheet" type="text/css" href="./css/main.css">
    <link rel="stylesheet" type="text/css" href="./css/notice.css">
    <link rel="icon" href="./img/logo.png" sizes="128x128">
    <link rel="icon" href="./img/logo.png" sizes="64x64">
    <link rel="icon" href="./img/logo.png" sizes="32x32">
    <link rel="icon" href="./img/logo.png" sizes="16x16">
    <script src="./js/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
</head>
<body>
<%@ include file="./admin_header.jsp" %>
<%@ include file="./admin_menu.jsp" %>
<main class="maincss">
<section id="sec">
    <p>공지사항 관리페이지</p>
    <div class="subpage_view">
    <ul>
        <li><input type="checkbox" v-model="all" @change="alldata">
        </li>
        <li>NO</li>
        <li>제목</li>
        <li>글쓴이</li>
        <li>날짜</li>
        <li>조회</li>
    </ul>
    <!-- 공지사항 반복 -->
    <app:forEach var="all" items= "${allnotice}" varStatus="no1">
    <app:if test="${all.getNimportant() == 'Y'}">
	    	<ol style="background:lightgray;">
		        <li></li>
		        <li></li>
		        <li @click="go_view('${all.getNidx()}')">${all.getNtitle()}</li>
		        <li>${all.getAname()}</li>
		        <li>${fn:substring(all.getNdate(),0,10)}</li>
		        <li>${all.getNview()}</li>
		    </ol>
	    </app:if>
    </app:forEach>
    <!-- 리스트 반복 -->
    <app:forEach var="nlist" items= "${list}" varStatus="no">
    	
	    <ol>
	        <li><input type="checkbox" name="del_ck" v-model="a" @change="onedata($event)" value="${nlist.getNidx()}"></li>
	        <li>${fn:length(list) - no.index}</li>
	        <li @click="go_view('${nlist.getNidx()}','${fn:length(list) - no.index}')">${nlist.getNtitle()}</li>
	        <li>${nlist.getAname()}</li>
	        <li>${fn:substring(nlist.getNdate(),0,10)}</li>
	        <li>${nlist.getNview()}</li>
	    </ol>
     </app:forEach>
    
     <app:if test="${allnotice.size() == 0}">
	    <ol class="none_text">
	        <li>등록된 공지 내용이 없습니다.</li>
	    </ol>
    </app:if>
    
    
    
    </div>
    <div class="board_btn">
        <button type="button" class="border_del" @click="delete_list">공지삭제</button>
        <button type="button" class="border_add" onclick="location.href='./admin_notice_write.jsp'" >공지등록</button>
    </div>
    <div class="border_page">
        <ul class="pageing">
        	
            <li @click="lleft"><img src="./ico/double_left.svg"></li>
            <li @click="left"><img src="./ico/left.svg"></li>
            <%
           		ArrayList<String> al = (ArrayList<String>)request.getAttribute("allnotice");
            	int ea = al.size();
	        	int pg = (int)Math.ceil(ea / 3f);
	        	int ww = 1;
	        	while(ww <= pg){
	        		request.setAttribute("pgg", ww);
        	%>
            <li onclick="location.href='./admin_notice.do?page=<%= ww%>'" id="b"><%=ww %></li>
            <% ww++; } %>
            <li @click="right(<%= pg %>)"><img src="./ico/right.svg"> </li>
            <li @click="rright(<%= pg %>)"><img src="./ico/double_right.svg"></li>
       
        </ul>
    </div>
    
</section>
<section></section>
<section></section>
</main>
<%@ include file="./admin_footer.jsp" %>
<script src="./js/admin_notice.js?v=${today}"></script>
</body>
</html>