<%@page import="java.util.ArrayList"%>
<%@page import="home.homepg_info_dao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<footer class="main_copyright" style="color:white;height:auto;">
<div style="line-height:20px;opacity :0.8; margin: 20px auto;">
<%= li.get(0) %> (사업자등록번호 : <%= li.get(1) %>)<br>
대표자명 :  <%= li.get(2) %> | 대표전화번호 :  <%= li.get(3) %> |
통신판매업 신고번호 :  <%= li.get(4) %> | 부가통신 사업자번호 : <%= li.get(5) %><br>
사업장 우편번호 :  <%= li.get(6) %> | 사업장 주소 : <%= li.get(7) %><br>
정보관리책임자명 :  <%= li.get(8) %> | 정보책임자 E-mail : <%= li.get(9) %><br>
</div>

</footer>

</body>
</html>