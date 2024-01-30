<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="app" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Date today = new Date();
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
        <title>사이트 환경설정</title>
        <link rel="stylesheet" type="text/css" href="./css/basic.css">
        <link rel="stylesheet" type="text/css" href="./css/login.css?v=1">
        <link rel="stylesheet" type="text/css" href="./css/main.css">
        <link rel="stylesheet" type="text/css" href="./css/subpage.css?v=3">
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
	<div id="main">
		<form id="f">
			<main class="maincss">
				<section>
				    <p>홈페이지 가입환경 설정</p>
				<div class="subpage_view">
				<ul class="info_form">
				    <li>홈페이지 제목</li>
				    <li>
				        <input type="text" name="hdomain" value="${homepg_info.getHdomain()}" class="in_form1"> 
				    </li>
				</ul>    
				<ul class="info_form">
				    <li>관리자 메일 주소</li>
				    <li>
				        <input type="text" name="hadmin_email" value="${homepg_info.getHadmin_email()}" class="in_form2"> ※ 관리자가 보내고 받는 용도로 사용하는 메일 주소를 입력합니다.(회원가입,인증메일,회원메일발송 등에서 사용)
				    </li>
				</ul> 
				<ul class="info_form">
				    <li>포인트 사용 유/무</li>
				    <li class="checkcss">
				    	<app:if test="${homepg_info.getHpoint_use() == 'Y'}">
					        <em><label><input type="radio" name="hpoint_use" value="Y" class="ckclass" checked>포인트 사용</label></em> 
					        <em><label><input type="radio" name="hpoint_use" value="N" class="ckclass">포인트 미사용</label></em>
				    	</app:if>
				    	<app:if test="${homepg_info.getHpoint_use() == 'N'}">
					        <em><label><input type="radio" name="hpoint_use" value="Y" class="ckclass">포인트 사용</label></em> 
					        <em><label><input type="radio" name="hpoint_use" value="N" class="ckclass" checked>포인트 미사용</label></em>
				    	</app:if>
				    </li>
				</ul>
				<ul class="info_form2" style="border-bottom:1px solid rgb(81, 61, 61);">
				    <li>회원가입시 적립금</li>
				    <li>
				        <input type="text" name="hpoint" value="${homepg_info.getHpoint()}" class="in_form3" maxlength="5"> 점
				    </li>
				    <li>회원가입시 권한레벨</li>
				    <li>
				        <input type="text" name="hlevel" value="${homepg_info.getHlevel()}" class="in_form3" maxlength="1" value="1"> 레벨
				    </li>
				</ul> 
				</div>
				<p>홈페이지 기본환경 설정</p>
				<div class="subpage_view">
				<ul class="info_form2">
				    <li>회사명</li>
				    <li>
				        <input type="text" name="hcompany" value="${homepg_info.getHcompany()}" class="in_form0"> 
				    </li>
				    <li>사업자등록번호</li>
				    <li>
				        <input type="text" name="hcompany_num" value="${homepg_info.getHcompany_num()}" class="in_form0"> 
				    </li>
				</ul> 
				<ul class="info_form2">
				    <li>대표자명</li>
				    <li>
				        <input type="text" name="hceo" value="${homepg_info.getHceo()}" class="in_form0"> 
				    </li>
				    <li>대표전화번호</li>
				    <li>
				        <input type="text" name="hceo_hp" value="${homepg_info.getHceo_hp()}" class="in_form0"> 
				    </li>
				</ul>
				<ul class="info_form2">
				    <li>통신판매업 신고번호</li>
				    <li>
				        <input type="text" name="hreport_num" value="${homepg_info.getHreport_num()}" class="in_form0"> 
				    </li>
				    <li>부가통신 사업자번호</li>
				    <li>
				        <input type="text" name="hprovide_num" value="${homepg_info.getHprovide_num()}" class="in_form0"> 
				    </li>
				</ul>
				<ul class="info_form2">
				    <li>사업장 우편번호</li>
				    <li>
				        <input type="text" name="hpost_code" value="${homepg_info.getHpost_code()}" class="in_form0"> 
				    </li>
				    <li>사업장 주소</li>
				    <li>
				        <input type="text" name="haddr" value="${homepg_info.getHaddr()}" class="in_form2"> 
				    </li>
				</ul>
				<ul class="info_form2" style="border-bottom:1px solid rgb(81, 61, 61);">
				    <li>정보관리책임자명</li>
				    <li>
				        <input type="text" name="hinfo_officer" value="${homepg_info.getHinfo_officer()}" class="in_form0"> 
				    </li>
				    <li>정보책임자 E-mail</li>
				    <li>
				        <input type="text" name="hinfo_email" value="${homepg_info.getHinfo_email()}" class="in_form1"> 
				    </li>
				</ul>
				</div>
				<p>결제 기본환경 설정</p>
				<div class="subpage_view">  
				<ul class="info_form2">
				    <li>무통장 은행</li>
				    <li>
				        <input type="text" name="hbank" value="${homepg_info.getHbank()}" class="in_form0"> 
				    </li>
				    <li>은행계좌번호</li>
				    <li>
				        <input type="text" name="hbank_num" value="${homepg_info.getHbank_num()}" class="in_form1"> 
				    </li>
				</ul>
				<ul class="info_form">
				    <li>신용카드 결제 사용</li>
				    <li class="checkcss">
					    <app:if test="${homepg_info.getHpay_card() == 'Y'}">
					        <em><label><input type="radio" name="hpay_card" value="Y" class="ckclass" checked> 사용</label></em> 
					        <em><label><input type="radio" name="hpay_card" value="N" class="ckclass"> 미사용</label></em> ※ 해당 PG사가 있을 경우 사용으로 변경합니다.
					    </app:if>
					    <app:if test="${homepg_info.getHpay_card() == 'N'}">
					        <em><label><input type="radio" name="hpay_card" value="Y" class="ckclass"> 사용</label></em> 
					        <em><label><input type="radio" name="hpay_card" value="N" class="ckclass" checked> 미사용</label></em> ※ 해당 PG사가 있을 경우 사용으로 변경합니다.
					    </app:if>
				    </li>
				</ul>
				<ul class="info_form">
				    <li>휴대폰 결제 사용</li>
				    <li class="checkcss">
				    	<app:if test="${homepg_info.getHpay_phone() == 'Y'}">
					        <em><label><input type="radio" name="hpay_phone" value="Y" class="ckclass" checked> 사용</label></em> 
					        <em><label><input type="radio" name="hpay_phone" value="N" class="ckclass"> 미사용</label></em> ※ 주문시 휴대폰 결제를 가능하게 할 것인지를 설정합니다.
				    	</app:if>
				    	<app:if test="${homepg_info.getHpay_phone() == 'N'}">
					        <em><label><input type="radio" name="hpay_phone" value="Y" class="ckclass"> 사용</label></em> 
					        <em><label><input type="radio" name="hpay_phone" value="N" class="ckclass" checked> 미사용</label></em> ※ 주문시 휴대폰 결제를 가능하게 할 것인지를 설정합니다.
				    	</app:if>
				    </li>
				</ul>
				<ul class="info_form">
				    <li>도서상품권 결제사용</li>
				    <li class="checkcss">
				    	<app:if test="${homepg_info.getHpay_book() == 'Y'}">
					        <em><label><input type="radio" name="hpay_book" value="Y" class="ckclass" checked> 사용</label></em> 
					        <em><label><input type="radio" name="hpay_book" value="N" class="ckclass"> 미사용</label></em> ※ 도서상품권 결제만 적용이 되며, 그 외에 상품권은 결제 되지 않습니다.
					    </app:if>
					    <app:if test="${homepg_info.getHpay_book() == 'N'}">
					        <em><label><input type="radio" name="hpay_book" value="Y" class="ckclass"> 사용</label></em> 
					        <em><label><input type="radio" name="hpay_book" value="N" class="ckclass" checked> 미사용</label></em> ※ 도서상품권 결제만 적용이 되며, 그 외에 상품권은 결제 되지 않습니다.
					    </app:if>
				    </li>
				</ul>
				<ul class="info_form2">
				    <li>결제 최소 포인트</li>
				    <li>
				        <input type="text" name="hpay_min_point" value="${homepg_info.getHpay_min_point()}" class="in_form0" maxlength="5"> 점
				    </li>
				    <li>결제 최대 포인트</li>
				    <li>
				        <input type="text" name="hpay_max_point" value="${homepg_info.getHpay_max_point()}" class="in_form0" maxlength="5"> 점
				    </li>
				</ul>
				<ul class="info_form" style="border-bottom:1px solid rgb(81, 61, 61);">
				    <li>현금 영수증 발급사용</li>
				    <li class="checkcss">
				    <app:if test="${homepg_info.getHcash_receipt() == 'Y'}">
				        <em><label><input type="radio" name="hcash_receipt" value="Y" class="ckclass" checked> 사용</label></em> 
				        <em><label><input type="radio" name="hcash_receipt" value="N" class="ckclass"> 미사용</label></em> ※ 현금영수증 관련 사항은 PG사 가입이 되었을 경우 사용가능 합니다.
				    </app:if>
				    <app:if test="${homepg_info.getHcash_receipt() == 'N'}">
				        <em><label><input type="radio" name="hcash_receipt" value="Y" class="ckclass"> 사용</label></em> 
				        <em><label><input type="radio" name="hcash_receipt" value="N" class="ckclass" checked> 미사용</label></em> ※ 현금영수증 관련 사항은 PG사 가입이 되었을 경우 사용가능 합니다.
				    </app:if>
				    </li>
				</ul>
				</div>
				<div class="btn_div">
				    <button type="button" class="sub_btn1" title="설정 저장" @click="info_save">설정 저장</button>
				    <button type="button" class="sub_btn2" title="저장 취소" onclick="window.location.reload()">저장 취소</button>
				</div>
				</section>
			</main>
		</form>
	</div>
	<%@ include file="./admin_footer.jsp" %>
</body>
<script src="./js/admin_siteinfo.js?v=${today}"></script>
</html>

