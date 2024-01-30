<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Date today = new Date();
	request.setAttribute("today", today);
%>
<!DOCTYPE html>
<html>
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
<script src="./ckeditor/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
<title>FAQ 등록</title>
</head>
<body>
    <%@ include file="./admin_header.jsp" %>
    <%@ include file="./admin_menu.jsp" %>
	<!-- FAQ 등록 시작 -->
	<div id="vue">
	<form id="f">
	<main class="maincss">
	<section class="page_section">
	<p>FAQ 관리등록</p>
	<div class="listbody">
	    <div class="procho">
	       <section class="data_listsview">
	       <ol>
	       <li>질문 제목</li>
	       <li><input type="text" name="ftitle" class="notice_in in1"></li>
	       <li>글쓴이</li>
	       <li><input type="text" name="aname" class="notice_in in2" value="<%=rname %>" readonly></li> <li style="height:520px;">질문 내용</li>
	       <li style="height:520px; padding-top: 10px;">
	       <textarea id="incontent" name="fcontent"  class="notice_in in3"></textarea>
	       </li>      
	       </ol>
	       <span class="notice_btns">
	       <input type="button" value="FAQ 등록" class="meno_btn2" @click="faqgo"></span>
	       </section>
	    </div>
	</div> 
	</section>
	</main>
	</form>
	</div>
	<!-- FAQ 등록 끝 -->
   <%@ include file="./admin_footer.jsp" %>
</body>
<script src="./js/admin_faq_write.js?v=${today}"></script>
</html>