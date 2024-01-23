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
    <title>공지사항</title>
    <link rel="stylesheet" type="text/css" href="./css/basic.css">
    <link rel="stylesheet" type="text/css" href="./css/login.css?v=1">
    <link rel="stylesheet" type="text/css" href="./css/main.css">
    <link rel="stylesheet" type="text/css" href="./css/notice.css?v=5">
    <link rel="icon" href="./img/logo.png" sizes="128x128">
    <link rel="icon" href="./img/logo.png" sizes="64x64">
    <link rel="icon" href="./img/logo.png" sizes="32x32">
    <link rel="icon" href="./img/logo.png" sizes="16x16">
    <script src="./js/jquery.js"></script>
    <script src="./ckeditor/ckeditor.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
</head>
<body>
	<%@ include file="./admin_header.jsp" %>
	<%@ include file="./admin_menu.jsp" %>
    <main class="maincss">
    <section id="sec">
	   	<form id="f">
	        <p>공지사항 수정 페이지</p>
	        <div class="write_view">
	        <ul>
	            <li>공지번호</li>
	            <li>${ndOne.getNidx()} 번째 공지글</li>
	            <input type="hidden" name="nidx" value="${ndOne.getNidx()}">
	        </ul>
	        <ul>
	            <li>공지사항 여부</li>
	            <li>
	                <label class="label_notice">
	                	<em class="cbox">
	                		<app:if test="${ndOne.getNimportant() == 'Y'}">
	                			<input type="checkbox" name="nimportant" value="Y" checked>
	                		</app:if>
	                		<app:if test="${ndOne.getNimportant() == 'N'}">
	                			<input type="checkbox" name="nimportant" value="Y">
	                		</app:if> 
	                	</em>
	                	공지 출력
	                </label> ※ 공지출력을 체크할 시 해당 글 내용은 최상단에 노출 되어 집니다.
	            </li>
	        </ul>
	        <ul>
	            <li>공지사항 제목</li>
	            <li>
	                <input type="text" name="ntitle" class="notice_input1" value="${ndOne.getNtitle()}"> ※ 최대 150자까지 입력이 가능
	            </li>
	        </ul>
	        <ul>
	            <li>글쓴이</li>
	            <li>
	                <input type="text" name="aname" class="notice_input2" value="${ndOne.getAname()}" readonly> ※ 관리자 이름이 노출 됩니다.       
	            </li>
	        </ul>
	        <ul>
	            <li>첨부파일</li>
	            <li>
	            	<app:if test="${ndOne.getNfile() == ''}">
		                <input type="file" name="userfile"> 
	            	</app:if>
	            	<app:if test="${ndOne.getNfile() != ''}">
		                <input type="file" name="userfile"> ※ 새로운 첨부파일 적용시 기본 첨부파일은 삭제 됩니다.
		                <em class="fileview">기존 첨부 파일명 :${ndOne.getNfile().substring(15)} </em>
		                <input type="hidden" name="oldfile" value="${ndOne.getNfile()}">
	            	</app:if>
	            </li>
	        </ul>
	        <ul class="ul_height">
	            <li>공지내용</li>
	            <li>
	                <textarea id="incontent" name="ncontent" class="notice_input3">${ndOne.getNcontent()}</textarea>
	            </li>
	        </ul>
	        </div>
	        <div class="board_btn">
	            <button class="border_list">공지목록</button>
	            <button class="border_modify" type="button" @click="go_update">공지수정 완료</button>
	        </div>
	    </form>
    </section>
    <section></section>
    <section></section>
    </main>
    <%@ include file="./admin_footer.jsp" %>
</body>
<script src="./js/admin_notice_modify.js?v=${today}"></script>
</html>