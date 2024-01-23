<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="app" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Date today = new Date();
	request.setAttribute("today", today);

%>        
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
</head>
<body>
<section>
    <p>신규등록 관리자</p>
    <ol class="new_admin_title">
        <li>NO</li>
        <li>관리자명</li>
        <li>아이디</li>
        <li>전화번호</li>
        <li>이메일</li>
        <li>담당부서</li>
        <li>담당직책</li>
        <li>가입일자</li>
        <li>승인여부</li>
    </ol>
    <ol class="new_admin_none" v-if="ea == 0">
        <li>신규 등록된 관리자가 없습니다.</li>
    </ol>
    <ol class="new_admin_lists"  v-for="nn in arr">
        <li>{{nn.aidx}}</li>
        <li>{{nn.aname}}</li>
        <li>{{nn.aid}}</li>
        <li>{{nn.atel}}</li>
        <li>{{nn.aemail}}</li>
        <li>{{nn.adiv}}</li>
        <li>{{nn.aposition}}</li>
        <li>{{nn.adate.substr(0,10)}}</li>
        <li>
            <input v-if="nn.approval =='Y'" type="button" value="승인" class="new_addbtn1" title="승인" @click="inblock(nn.aidx)">
            <input v-if="nn.approval =='N'" type="button" value="미승인" class="new_addbtn2" title="미승인" @click="inok(nn.aidx)">
        </li>
    </ol>
</section>
<section></section>
<section></section>
<script src="./js/admin_main.js?v=${today}"></script>
</body>
</html>