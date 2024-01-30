<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>항공공사 및 번호 등록</title>
</head>
<body>
    <%@ include file="./admin_header.jsp" %>
    <%@ include file="./admin_menu.jsp" %>
<!-- FAQ 등록 시작 -->
<div id="vue">
<form id="f">
<input type="hidden" name="fidx" value="${fdOne.getFidx()}">
<main class="maincss">
<section class="page_section">
<p>FAQ 확인 및 수정</p>
<div class="listbody">
    <div class="procho">
       <section class="data_listsview">
       <ol>
       <li>질문 제목</li>
       <li><input type="text" name="ftitle" value="${fdOne.getFtitle()}" class="notice_in in1"></li>
       <li>글쓴이</li>
       <li><input type="text" name="aname" value="${fdOne.getAname()}" class="notice_in in2" readonly></li> <li style="height:520px;">질문 내용</li>
       <li style="height:520px; padding-top: 10px;">
       <textarea class="notice_in in3" name="fcontent" id="incontent">${fdOne.getFcontent()}</textarea>
       </li>      
       </ol>
       <span class="notice_btns">
        <input type="button" value="FAQ 리스트" class="meno_btn1" onclick="location.href='./admin_faq.do'">
        <input type="button" value="FAQ 수정" class="meno_btn2" @click="modifyok"></span>
       </section>
    </div>
</div> 
</section>
</main>
</form>
</div>
<!-- FAQ 등록 끝 -->
<footer class="main_copyright"></footer>
</body>
<script src="./js/admin_faq_modify.js?v=${today}"></script>
</html>