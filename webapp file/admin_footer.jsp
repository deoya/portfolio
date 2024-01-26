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
  <script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
</head>

<body>
<footer id="footer_vue" class="main_copyright" style="color:white;height:auto;">
{{footer}}
<div style="line-height:20px;opacity :0.8; margin: 20px auto;" v-if="hcompany != ''">


{{hcompany}}(사업자등록번호 : {{hcompany_num}}) <br>
대표자명 :  {{hceo}} | 대표전화번호 :  {{hceo_hp}} <br>
통신판매업 신고번호 :  {{hreport_num}} <span style="display:inline;" v-if="hprovide_num != ''"> | 부가통신 사업자번호 : {{hprovide_num}}</span><br>
사업장 우편번호 :  {{hpost_code}} | 사업장 주소 : {{haddr}}<br>
정보관리책임자명 :  {{hinfo_officer}} | 정보책임자 E-mail : {{hinfo_email}} <br>

</div>
</footer>

</body>
<script src="./js/admin_footer.js?v=${today}"></script>
</html>