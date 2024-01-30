<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	HttpSession sess = request.getSession();
	String rid = (String)sess.getAttribute("aid");
	String rname = (String)sess.getAttribute("aname");
	
	String script = "";
	ArrayList<String> li = (ArrayList<String>)sess.getAttribute("info");
	if(rid == "null" || rid == "" || rid == null || rid.equals(null) || rid.equals("") || rid.equals("null")){		
		script = "<script>alert('올바른 접근 방식이 아닙니다');location.href='./index.jsp'; </script>";		
	}
	out.print(script);

%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>Insert title here</title>
</head>
<body>
<header class="headercss">
    <div class="header_div">
        <p><img src="./img/logo.png" class="logo_sm"> ADMINISTRATOR</p>
        <p><%=rname %> 관리자 <a href="#">[개인정보 수정]</a> <a href="./logout.do" >[로그아웃]</a></p>
    </div>
</header>
</body>
</html>