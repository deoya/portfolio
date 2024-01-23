<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav class="navcss" id="nav">
    <div class="nav_div">
        <ol>
            <li title="사이트 기본설정" onclick="location.href='./admin_siteinfo.do'">사이트 기본설정</li>
            <li title="회원관리" onclick="location.href='./admin_main.jsp'">회원관리</li>
            <li title="공지사항" onclick="location.href='./admin_notice.do'">공지사항</li>
            <li title="항공사 등록" onclick="location.href='./admin_product.do'">항공사 및 번호 등록</li>
            <li title="좌석 및 예매등록" onclick="location.href='./admin_seat.do'">좌석 및 예매등록</li>
            <li title="예매 확인 리스트" onclick="location.href='./admin_ticketing.do'">예매 리스트</li>
            <li title="고객관리 FAQ" onclick="location.href='./admin_faq.do'">고객관리 FAQ</li>
        </ol>
    </div>
</nav>
</body>
</html>