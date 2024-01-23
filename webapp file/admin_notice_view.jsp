<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="app" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Date today = new Date();
	request.setAttribute("today", today);
	

	String otpt = (String)request.getAttribute("output");
	request.setAttribute("ot", otpt);
	
	
	
%>
${ot}
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쇼핑몰 환경설정</title>
    <link rel="stylesheet" type="text/css" href="./css/basic.css">
    <link rel="stylesheet" type="text/css" href="./css/login.css?v=1">
    <link rel="stylesheet" type="text/css" href="./css/main.css">
    <link rel="stylesheet" type="text/css" href="./css/notice.css?v=5">
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
        <p>공지사항 VIEW 페이지</p>
        <div class="write_view">
        <ul>
            <li>공지번호</li>
            <li>${idx}번째 공지글</li>
        </ul>
        <ul>
            <li>공지사항 여부 </li>
            <app:if test="${ndOne.getNimportant() == 'Y'}">
	            <li>YES</li>
            </app:if>
            <app:if test="${ndOne.getNimportant() == 'N'}">
	            <li>NO</li>
            </app:if>
        </ul>
        <ul>
            <li>공지사항 제목</li>
            <li> ${ndOne.getNtitle()}</li>
        </ul>
        <ul>
            <li>글쓴이</li>
            <li>${ndOne.getAname()}</li>
        </ul>
        <ul>
            <li>첨부파일</li>
            <app:if test="${ndOne.getNfile() == ''}">
            	<li></li>
   			</app:if>
   			<app:if test="${ndOne.getNfile() != ''}">
	            <li><a href="http://deoya.cdn1.cafe24.com/${ndOne.getNfile()}" target="_blank" style="all:unset; color:red; cursor:pointer">${ndOne.getNfile().substring(15)}</a></li>
            </app:if>
        </ul>
        <ul class="ul_height">
            <li>공지내용</li>
            <li style="overflow: auto;">${ndOne.getNcontent()}</li>
        </ul>
        </div>
        <div class="board_btn">
            <button class="border_list" type="button" onclick="location.href='./admin_notice.do'">공지목록</button>
            <button class="border_modify" type="button" onclick="location.href='./admin_notice_modify.do?nidx=${ndOne.getNidx()}'">공지수정</button>
            <button class="border_del" type="button" @click="go_delete(${ndOne.getNidx()},'${ndOne.getNfile()}')">공지삭제</button>
        </div>
    </section>
    <section></section>
    <section></section>
    </main>
   <%@ include file="./admin_footer.jsp" %>
</body>
<script src="./js/admin_notice_view.js?v=${today}"></script>
</html>